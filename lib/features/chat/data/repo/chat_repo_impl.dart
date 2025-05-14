import 'dart:io';
import 'package:dio/dio.dart';
import 'package:manager_app/core/constant/app_strings.dart';
import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/features/chat/data/model/conversation_model/conversation_model.dart';
import 'package:manager_app/features/chat/data/model/message_model/message_model.dart';
import 'package:manager_app/features/chat/data/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  ApiHelper apiHelper = ApiHelper();

  @override
  Future<ConversationModel?> getOrCreateConversation(int userId) async {
    try {
      final token = await getToken();
      final url = '${AppStrings.baseUrl}/api/conversations/for?user_id=$userId';
      final response = await apiHelper.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return ConversationModel.fromJson(response.data['data']);
      }
    } catch (e) {
      print("Conversation not found, trying to create. Reason: $e");
    }
    try {
      final token = await getToken();
      final createResponse = await apiHelper.post(
        '${AppStrings.baseUrl}/api/conversations',
        {
          "type": 0,
          "user_id": userId,
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      if (createResponse.statusCode == 200 ||
          createResponse.statusCode == 201) {
        return ConversationModel.fromJson(createResponse.data['data']);
      }
    } catch (e) {
      print("Failed to create conversation: $e");
    }
    return null;
  }

  @override
  Future<MessageModel?> sendMessage({
    required String conversationId,
    required String ticketId,
    required String content,
    required int type,
    List<File>? mediaFiles,
  }) async {
    if (content.trim().isEmpty && (mediaFiles == null || mediaFiles.isEmpty)) {
      print("Message content and media are both empty. Abort sending.");
      return null;
    }
    try {
      final token = await getToken();
      final url =
          '${AppStrings.baseUrl}/api/conversations/$conversationId/messages';
      final formData = FormData();
      formData.fields.addAll([
        MapEntry('type', type.toString()),
        MapEntry('ticket_id', ticketId),
        if (content.trim().isNotEmpty) MapEntry('content', content),
      ]);
      if (mediaFiles != null && mediaFiles.isNotEmpty) {
        for (var file in mediaFiles) {
          final fileName = file.path.split('/').last;
          formData.files.add(
            MapEntry(
              'media',
              await MultipartFile.fromFile(file.path, filename: fileName),
            ),
          );
        }
      }
      final response = await apiHelper.post(
        url,
        formData,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MessageModel.fromJson(response.data['data']);
      } else {
        print("Failed to send message: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception while sending message: $e");
      return null;
    }
  }

  @override
  Future<List<MessageModel>> fetchAllMessages({
    required String conversationId,
    required String ticketId,
    int page = 1,
  }) async {
    try {
      final token = await getToken();
      final response = await apiHelper.get(
        '${AppStrings.baseUrl}/api/conversations/$conversationId/messages?ticket_id=$ticketId&per_page=10',
        headers: {'Authorization': 'Bearer $token'},
        queryParameters: {'page': page},
      );
      var data = response.data;
      return (data["data"] as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();
    } catch (e) {
      print("Error fetching messages: $e");
      return [];
    }
  }

  @override
  Future<bool> deleteMessage(
      {required String conversationId,
      required String messageId,
      int deleteForAll = 0}) async {
    try {
      final token = await getToken();
      await apiHelper.delete(
        '${AppStrings.baseUrl}/api/conversations/$conversationId/messages/$messageId?delete_for_all=$deleteForAll',
        headers: {'Authorization': 'Bearer $token'},
      );
      return true;
    } catch (e) {
      print("Failed to delete conversation: $e");
      return false;
    }
  }
}

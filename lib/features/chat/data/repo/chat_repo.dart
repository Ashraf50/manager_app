import 'dart:io';
import '../model/conversation_model/conversation_model.dart';
import '../model/message_model/message_model.dart';

abstract class ChatRepo {
  Future<ConversationModel?> getOrCreateConversation(int userId);

  Future<MessageModel?> sendMessage({
    required String conversationId,
    required String ticketId,
    required String content,
    required int type,
    List<File>? mediaFiles,
  });
  Future<List<MessageModel>> fetchAllMessages({
    required String conversationId,
    required String ticketId,
    int page = 1,
  });
  Future<bool> deleteMessage({
    required String conversationId,
    required String messageId,
    int deleteForAll = 0,
  });
}

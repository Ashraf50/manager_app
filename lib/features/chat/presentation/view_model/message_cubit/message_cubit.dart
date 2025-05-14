import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/message_model/message_model.dart';
import '../../../data/repo/chat_repo.dart';
part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final ChatRepo chatRepo;
  List<MessageModel> allMessages = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isFetching = false;
  MessageCubit(this.chatRepo) : super(MessageInitial());

  Future<void> fetchMessages({
    bool loadMore = false,
    bool reset = false,
    required String conversationId,
    required String ticketId,
  }) async {
    if (isFetching || (!hasMore && !reset)) return;
    isFetching = true;
    if (reset) {
      allMessages = [];
      currentPage = 1;
      hasMore = true;
    }
    if (!loadMore || reset) {
      emit(MessageLoading());
    }
    try {
      final fetchedMessages = await chatRepo.fetchAllMessages(
        page: currentPage,
        ticketId: ticketId,
        conversationId: conversationId,
      );
      if (fetchedMessages.isEmpty) {
        hasMore = false;
      } else {
        allMessages = [
          ...allMessages,
          ...fetchedMessages,
        ];
        currentPage++;
      }
      _emitMessages();
    } catch (e) {
      emit(MessageError("Failed to load messages"));
    }
    isFetching = false;
  }

  void loadMoreMessages({
    required String conversationId,
    required String ticketId,
  }) {
    fetchMessages(
        loadMore: true, ticketId: ticketId, conversationId: conversationId);
  }

  void addNewMessage(MessageModel message) {
    print("Adding message to state: ${message.content}");
    if (!allMessages.any((m) => m.id == message.id)) {
      allMessages.add(message);
      emit(MessageLoaded(
        List.from(allMessages),
      ));
    }
  }

  Future<void> deleteMessage({
    required String conversationId,
    required String messageId,
    int deleteForAll = 0,
  }) async {
    try {
      await chatRepo.deleteMessage(
        conversationId: conversationId,
        messageId: messageId,
      );
      allMessages.removeWhere((msg) => msg.id == messageId);
      emit(MessageDeleted("Message deleted successfully"));
      _emitMessages();
    } catch (e) {
      emit(MessageError("Failed to delete message: ${e.toString()}"));
    }
  }

  Future<void> sendMessage({
    required String conversationId,
    required String ticketId,
    required String content,
    required int type,
    List<File>? mediaFiles,
  }) async {
    try {
      final message = await chatRepo.sendMessage(
        conversationId: conversationId,
        ticketId: ticketId,
        content: content,
        type: type,
        mediaFiles: mediaFiles,
      );
      if (message != null) {
        addNewMessage(message);
      } else {
        emit(MessageSentFailure("Failed to send message"));
      }
    } catch (e) {
      emit(MessageSentFailure("Error: ${e.toString()}"));
    }
  }

  void _emitMessages() {
    emit(MessageLoaded(
      List.from(allMessages),
    ));
  }
}

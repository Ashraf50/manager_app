import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/features/chat/data/model/conversation_model/conversation_model.dart';
import 'package:manager_app/features/chat/data/repo/chat_repo.dart';
import '../../../data/model/chat_detailing_args.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  ChatCubit(this.chatRepo) : super(ChatInitial());
  Future<void> handleChatWithUser(
      int userId, String ticketId, BuildContext context) async {
    emit(ConversationLoading());
    try {
      final conversation = await chatRepo.getOrCreateConversation(userId);
      if (conversation != null) {
        context.push(
          '/chat_details',
          extra:
              ChatDetailsArgs(conversation: conversation, ticketId: ticketId),
        );
      } else {
        emit(ConversationFailure(errMessage: "Failed to create conversation"));
      }
    } catch (_) {
      emit(ConversationFailure(
          errMessage: "Unexpected error during chat initiation"));
    }
  }
}

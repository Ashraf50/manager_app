import 'conversation_model/conversation_model.dart';

class ChatDetailsArgs {
  final ConversationModel conversation;
  final String ticketId;
  ChatDetailsArgs({
    required this.conversation,
    required this.ticketId,
  });
}

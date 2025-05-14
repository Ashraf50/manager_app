part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ConversationLoading extends ChatState {}

class ConversationSuccess extends ChatState {
  final List<ConversationModel> conversations;
  ConversationSuccess({required this.conversations});
}

class ConversationFailure extends ChatState {
  final String errMessage;
  ConversationFailure({required this.errMessage});
}

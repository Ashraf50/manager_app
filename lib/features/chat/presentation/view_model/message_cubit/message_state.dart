part of 'message_cubit.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<MessageModel> messages;
  final bool isNewMessages;
  MessageLoaded(this.messages, {this.isNewMessages = false});
  List<Object> get props => [messages, isNewMessages];
}

class MessageError extends MessageState {
  final String error;
  MessageError(this.error);
}

class MessageSending extends MessageState {}

class MessageSentSuccess extends MessageState {
  final MessageModel message;
  MessageSentSuccess(this.message);
}

class MessageSentFailure extends MessageState {
  final String error;
  MessageSentFailure(this.error);
}

class MessageDeleted extends MessageState {
  final String message;
  MessageDeleted(this.message);
}

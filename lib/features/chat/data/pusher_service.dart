import 'dart:convert';
import 'package:manager_app/features/chat/data/model/message_model/message_model.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  final PusherChannelsFlutter _pusher = PusherChannelsFlutter();
  String? _currentConversationId;
  final Set<String> _subscribedChannels = {};

  Future<void> init({
    required String loggedUserId,
    required String conversationId,
    required void Function(MessageModel) onNewMessage,
    required void Function(String messageId) onMessageDeleted,
    required void Function(MessageModel) onConversationUpdated,
  }) async {
    if (_currentConversationId != null &&
        _currentConversationId != conversationId) {
      final oldChannel = 'conversations.$_currentConversationId';
      if (_subscribedChannels.contains(oldChannel)) {
        await _pusher.unsubscribe(channelName: oldChannel);
        _subscribedChannels.remove(oldChannel);
      }
    }
    _currentConversationId = conversationId;
    await _pusher.init(
      apiKey: '4924e59671f5cabb61cb',
      cluster: 'eu',
      onConnectionStateChange: (currentState, previousState) {
        print("Pusher connected: $currentState (prev: $previousState)");
      },
      onError: (message, code, exception) {
        print("Pusher error: $message, code: $code, exception: $exception");
      },
      onEvent: (PusherEvent event) {
        final channel = event.channelName;
        final name = event.eventName;
        if (channel == 'chat.$loggedUserId' && name == 'conversation-updated') {
          final data = jsonDecode(event.data!);
          final message = MessageModel.fromJson(data);
          onConversationUpdated(message);
        } else if (channel == 'conversations.$conversationId') {
          final data = jsonDecode(event.data!);
          if (name == 'new-message') {
            final message = MessageModel.fromJson(data);
            onNewMessage(message);
          } else if (name == 'message-deleted') {
            final deletedMessageId = data['id'];
            onMessageDeleted(deletedMessageId);
          }
        }
      },
    );

    final userChannel = 'chat.$loggedUserId';
    if (!_subscribedChannels.contains(userChannel)) {
      await _pusher.subscribe(channelName: userChannel);
      _subscribedChannels.add(userChannel);
    }
    final convoChannel = 'conversations.$conversationId';
    if (!_subscribedChannels.contains(convoChannel)) {
      await _pusher.subscribe(channelName: convoChannel);
      _subscribedChannels.add(convoChannel);
    }

    await _pusher.connect();
  }

  Future<void> unsubscribeConversation(String conversationId) async {
    final channel = 'conversations.$conversationId';
    if (_subscribedChannels.contains(channel)) {
      await _pusher.unsubscribe(channelName: channel);
      _subscribedChannels.remove(channel);
    }
  }

  Future<void> disconnect() async {
    await _pusher.disconnect();
    _currentConversationId = null;
    _subscribedChannels.clear();
  }
}

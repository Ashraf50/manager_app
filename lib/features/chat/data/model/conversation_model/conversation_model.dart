import 'latest_message.dart';
import 'other_user.dart';

class ConversationModel {
  String? id;
  int? type;
  bool? pinned;
  int? unseenMessagesCount;
  OtherUser? otherUser;
  LatestMessage? latestMessage;

  ConversationModel({
    this.id,
    this.type,
    this.pinned,
    this.unseenMessagesCount,
    this.otherUser,
    this.latestMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String?,
      type: json['type'] as int?,
      pinned: json['pinned'] as bool?,
      unseenMessagesCount: json['unseen_messages_count'] as int?,
      otherUser: json['other_user'] == null
          ? null
          : OtherUser.fromJson(json['other_user'] as Map<String, dynamic>),
      latestMessage: json['latest_message'] == null
          ? null
          : LatestMessage.fromJson(
              json['latest_message'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'pinned': pinned,
        'unseen_messages_count': unseenMessagesCount,
        'other_user': otherUser?.toJson(),
        'latest_message': latestMessage?.toJson(),
      };
}

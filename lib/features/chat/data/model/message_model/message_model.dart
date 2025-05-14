import 'package:manager_app/features/chat/data/model/message_model/user_model.dart';

class MessageModel {
  final String id;
  final int? ticketId;
  final int? type;
  final bool? deletedForAll;
  final bool? forwarded;
  final bool? seen;
  final DateTime? createdAt;
  final double? latitude;
  final double? longitude;
  final String? media;
  final dynamic mediaObject;
  final int? recordDuration;
  final String? content;
  final int? page;
  final int? position;
  final DateTime? pinnedTill;
  final UserModel user;

  MessageModel({
    required this.id,
    this.ticketId,
    this.type,
    this.deletedForAll,
    this.forwarded,
    this.seen,
    this.createdAt,
    this.latitude,
    this.longitude,
    this.media,
    required this.mediaObject,
    required this.recordDuration,
    required this.content,
    required this.page,
    required this.position,
    required this.pinnedTill,
    required this.user,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      ticketId: json['ticket_id'],
      type: json['type'],
      deletedForAll: json['deleted_for_all'],
      forwarded: json['forwarded'],
      seen: json['seen'],
      createdAt: DateTime.parse(json['created_at']),
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      media: json['media'],
      mediaObject: json['media_object'],
      recordDuration: json['record_duration'],
      content: json['content'],
      page: json['page'],
      position: json['position'],
      pinnedTill: json['pinned_till'] != null
          ? DateTime.tryParse(json['pinned_till'])
          : null,
      user: UserModel.fromJson(json['user']),
    );
  }
}

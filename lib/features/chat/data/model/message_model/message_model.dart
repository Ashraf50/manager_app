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
    this.mediaObject,
    this.recordDuration,
    this.content,
    this.page,
    this.position,
    this.pinnedTill,
    required this.user,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    try {
      return MessageModel(
        id: json['id'] ?? '',
        ticketId: json['ticket_id'],
        type: json['type'],
        deletedForAll: json['deleted_for_all'],
        forwarded: json['forwarded'],
        seen: json['seen'],
        createdAt: json['created_at'] != null && json['created_at'] is String
            ? DateTime.tryParse(json['created_at'])
            : null,
        latitude: (json['latitude'] ?? 0).toDouble(),
        longitude: (json['longitude'] ?? 0).toDouble(),
        media: json['media'],
        mediaObject: json['media_object'],
        recordDuration: json['record_duration'],
        content: json['content'],
        page: json['page'],
        position: json['position'],
        pinnedTill: json['pinned_till'] != null && json['pinned_till'] is String
            ? DateTime.tryParse(json['pinned_till'])
            : null,
        user: json['user'] != null && json['user'] is Map<String, dynamic>
            ? UserModel.fromJson(json['user'])
            : UserModel(id: 0, name: "Unknown", avatar: ""),
      );
    } catch (e, stackTrace) {
      print('❌ Error parsing MessageModel: $e');
      print('📍 StackTrace: $stackTrace');
      rethrow;
    }
  }
}

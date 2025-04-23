import 'data.dart';

class NotificationModel {
  String? id;
  String? title;
  DateTime? createdAt;
  bool? seen;
  String? body;
  Data? data;

  NotificationModel({
    this.id,
    this.title,
    this.createdAt,
    this.seen,
    this.body,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      seen: json['seen'] as bool?,
      body: json['body'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'created_at': createdAt?.toIso8601String(),
        'seen': seen,
        'body': body,
        'data': data?.toJson(),
      };
}

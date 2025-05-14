class LatestMessage {
  String? id;
  int? senderId;
  int? type;
  bool? deletedForAll;
  bool? seen;
  DateTime? createdAt;
  dynamic recordDuration;
  String? content;

  LatestMessage({
    this.id,
    this.senderId,
    this.type,
    this.deletedForAll,
    this.seen,
    this.createdAt,
    this.recordDuration,
    this.content,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json['id'] as String?,
        senderId: json['sender_id'] as int?,
        type: json['type'] as int?,
        deletedForAll: json['deleted_for_all'] as bool?,
        seen: json['seen'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        recordDuration: json['record_duration'] as dynamic,
        content: json['content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender_id': senderId,
        'type': type,
        'deleted_for_all': deletedForAll,
        'seen': seen,
        'created_at': createdAt?.toIso8601String(),
        'record_duration': recordDuration,
        'content': content,
      };
}

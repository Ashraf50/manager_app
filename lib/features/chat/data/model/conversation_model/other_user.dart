class OtherUser {
  int? id;
  String? name;
  String? avatar;
  int? type;
  bool? online;
  dynamic lastTimeSeen;

  OtherUser({
    this.id,
    this.name,
    this.avatar,
    this.type,
    this.online,
    this.lastTimeSeen,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
        id: json['id'] as int?,
        name: json['name'] as String?,
        avatar: json['avatar'] as String?,
        type: json['type'] as int?,
        online: json['online'] as bool?,
        lastTimeSeen: json['last_time_seen'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'type': type,
        'online': online,
        'last_time_seen': lastTimeSeen,
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  int? type;
  DateTime? createdAt;
  DateTime? lastLoginTime;
  bool? status;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.type,
    this.createdAt,
    this.lastLoginTime,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        avatar: json['avatar'] as String?,
        type: json['type'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        lastLoginTime: json['last_login_time'] == null
            ? null
            : DateTime.parse(json['last_login_time'] as String),
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'type': type,
        'created_at': createdAt?.toIso8601String(),
        'last_login_time': lastLoginTime?.toIso8601String(),
        'status': status,
      };
}

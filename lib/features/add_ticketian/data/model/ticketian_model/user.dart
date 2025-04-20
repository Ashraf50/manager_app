class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  bool? status;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        avatar: json['avatar'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'status': status,
      };
}

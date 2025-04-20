import 'user.dart';

class Manager {
  int? id;
  User? user;

  Manager({this.id, this.user});

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json['id'] as int?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
      };
}

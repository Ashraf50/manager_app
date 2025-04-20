import 'user.dart';

class Technician {
  int? id;
  User? user;

  Technician({this.id, this.user});

  factory Technician.fromJson(Map<String, dynamic> json) => Technician(
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

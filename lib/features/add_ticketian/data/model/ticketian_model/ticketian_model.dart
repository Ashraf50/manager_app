import 'user.dart';

class TicketianModel {
  int? id;
  User? user;

  TicketianModel({this.id, this.user});

  factory TicketianModel.fromJson(Map<String, dynamic> json) {
    return TicketianModel(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
      };
}

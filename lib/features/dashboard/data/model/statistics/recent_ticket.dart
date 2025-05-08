import 'package:manager_app/features/dashboard/data/model/statistics/technician.dart';
import 'manager.dart';
import 'service.dart';
import 'user.dart';

class RecentTicket {
  int? id;
  String? title;
  int? status;
  DateTime? createdAt;
  String? description;
  Service? service;
  User? user;
  Manager? manager;
  Technician? technician;

  RecentTicket({
    this.id,
    this.title,
    this.status,
    this.createdAt,
    this.description,
    this.service,
    this.user,
    this.manager,
    this.technician,
  });

  factory RecentTicket.fromJson(Map<String, dynamic> json) => RecentTicket(
        id: json['id'] as int?,
        title: json['title'] as String?,
        status: json['status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        description: json['description'] as String?,
        service: json['service'] == null
            ? null
            : Service.fromJson(json['service'] as Map<String, dynamic>),
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        manager: json['manager'] == null
            ? null
            : Manager.fromJson(json['manager'] as Map<String, dynamic>),
        technician: json['technician'] == null
            ? null
            : Technician.fromJson(json['technician'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'description': description,
        'service': service?.toJson(),
        'user': user?.toJson(),
        'manager': manager?.toJson(),
        'technician': technician,
      };
}

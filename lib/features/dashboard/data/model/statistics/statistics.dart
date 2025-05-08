import 'data.dart';

class StatisticsModel {
  Data? data;
  String? message;
  String? type;
  int? code;
  bool? showToast;

  StatisticsModel({
    this.data,
    this.message,
    this.type,
    this.code,
    this.showToast,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) => StatisticsModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        message: json['message'] as String?,
        type: json['type'] as String?,
        code: json['code'] as int?,
        showToast: json['showToast'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'type': type,
        'code': code,
        'showToast': showToast,
      };
}

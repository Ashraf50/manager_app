class Data {
  String? type;
  int? modelId;

  Data({this.type, this.modelId});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json['type'] as String?,
        modelId: json['model_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'model_id': modelId,
      };
}

import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError implements Exception {
  String message;
  String? localizedMessage;
  int? code;

  ApiError({required this.message, this.localizedMessage, this.code});

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

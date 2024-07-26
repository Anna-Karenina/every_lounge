// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum ApiMetricsType {
  @JsonValue('SERVER_ERROR')
  SERVER_ERROR,
  @JsonValue('HANDLER_LOG')
  HANDLER_LOG,
}

const ApiMetricsTypeMap = {
  ApiMetricsType.SERVER_ERROR: 'SERVER_ERROR',
  ApiMetricsType.HANDLER_LOG: 'HANDLER_LOG',
};

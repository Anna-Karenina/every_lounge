// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

class EnvironmentConfig {
  static const HOST = String.fromEnvironment('HOST');
  static const APP_SUFFIX = kReleaseMode ? 'PROD' : 'DEV';
  static const ACCESS_TOKEN = String.fromEnvironment('ACCESS_TOKEN');
  static const API_TOKEN = String.fromEnvironment("API_TOKEN");
}

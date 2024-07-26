import 'package:every_test/presentation/application.dart';
import 'package:flutter/material.dart';
import 'package:package_common/package_common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DiManager.initDi();

  runApp(const Application());
}

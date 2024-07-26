// ignore_for_file: constant_identifier_names

import 'package:every_test/presentation/pages/home_page.dart';
import 'package:flutter/widgets.dart';

enum Routes {
  HOME,
}

const Map<Routes, String> routesMap = {
  Routes.HOME: '/',
};

Map<String, WidgetBuilder> routes = {
  routesMap[Routes.HOME]!: (_) => const HomePage(),
};

import 'dart:io';

import 'package:package_common/environment/environment.dart';
import 'package:http_interceptor/http_interceptor.dart';

class HttpAuthConfig {
  final Uri link;
  final Map<String, String> headers;

  HttpAuthConfig({
    required this.link,
    required this.headers,
  });
}

class HttpConfiguration {
  String environment = EnvironmentConfig.APP_SUFFIX;

  String httpLink(String key) => HttpConfiguration.getUri(environment)[key]!;

  final http = InterceptedClient.build(interceptors: [
    //for logging
  ]);

  Future<HttpAuthConfig> clientToQueryByKey(String key, String url) async {
    const accessToken = EnvironmentConfig.ACCESS_TOKEN;
    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    return HttpAuthConfig(
        link: Uri.parse(httpLink(key) + url), headers: headers);
  }

  static Map<String, String> getUri(String env) {
    const host = EnvironmentConfig.HOST;
    return {
      'themoviedb': host,
    };
  }
}

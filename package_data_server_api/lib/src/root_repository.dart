import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:package_data_server_api/package_data_server_api.dart';
import 'package:package_data_server_api/src/models/api_error.dart';
import 'package:package_data_server_api/src/models/api_metrics.dart';

class RootRepository {
  HttpConfiguration httpConfiguration;

  RootRepository({required this.httpConfiguration});

  Future<HttpAuthConfig> getHttpTimeDbToken(String url) =>
      httpConfiguration.clientToQueryByKey('themoviedb', url);

  Future<http.Response> throwHttpExceptionIfResponseFailed(
      Future<http.Response> Function() request) async {
    dynamic response;

    response = await request();

    if (response.statusCode != 200) {
      await _checkStatus(response).catchError((e) => throw (e));
    } else {
      _sendHttpMetrics(response, ApiMetricsType.HANDLER_LOG);
    }
    return response;
  }

  _sendHttpMetrics(
    http.Response response,
    ApiMetricsType type,
  ) {
    // TODO: impliment!
    return;
  }

  Future<void> _checkStatus(response) async {
    ApiError err;

    if (response.statusCode != 200) {
      try {
        var resp = jsonDecode(utf8.decode(response.bodyBytes));
        err = ApiError.fromJson(resp);
      } catch (e) {
        err = ApiError(message: 'Ошибка без текста :(');
      }

      err.code = response.statusCode;
      err.message = '${err.localizedMessage ?? err.message}\n'
          '[${response.headers['x-aer-trace-id']}]';

      _sendHttpMetrics(response, ApiMetricsType.SERVER_ERROR);
      throw err;
    } else {
      return response;
    }
  }
}

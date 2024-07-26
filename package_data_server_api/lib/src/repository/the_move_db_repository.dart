import 'dart:convert';

import 'package:package_data_server_api/package_data_server_api.dart';
import 'package:package_data_server_api/src/root_repository.dart';

class TheMoveDbRepository extends RootRepository {
  HttpConfiguration httpConfiguration;

  TheMoveDbRepository({required this.httpConfiguration})
      : super(httpConfiguration: httpConfiguration);

  Future<List<FilmDTO>> getFilms(int page, int size) async {
    request() async {
      var client = await getHttpTimeDbToken(
          '/3/movie/popular?language=en-US&page=$page');
      return httpConfiguration.http.get(
        client.link,
        headers: client.headers,
      );
    }

    final response = await throwHttpExceptionIfResponseFailed(request);
    final responseJson = jsonDecode(utf8.decode(response.bodyBytes));

    final content = responseJson["results"];
    return [...content.map((item) => FilmDTO.fromJson(item))];
  }

  Future<List<FilmDTO>> searchFilms(String query, int page, int size) async {
    request() async {
      var client = await getHttpTimeDbToken(
          '/3/search/movie?query=$query&include_adult=false&language=en-US&page=$page');
      return httpConfiguration.http.get(
        client.link,
        headers: client.headers,
      );
    }

    final response = await throwHttpExceptionIfResponseFailed(request);
    final responseJson = jsonDecode(utf8.decode(response.bodyBytes));

    final content = responseJson["results"];
    return [...content.map((item) => FilmDTO.fromJson(item))];
  }

  Future<List<GenereDTO>> getGenres() async {
    request() async {
      var client = await getHttpTimeDbToken('/3/genre/movie/list?language=en');
      return httpConfiguration.http.get(
        client.link,
        headers: client.headers,
      );
    }

    final response = await throwHttpExceptionIfResponseFailed(request);
    final responseJson = jsonDecode(utf8.decode(response.bodyBytes));

    final content = responseJson["genres"];
    return [...content.map((item) => GenereDTO.fromJson(item))];
  }
}

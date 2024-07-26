import 'package:every_test/data/models/film.dart';
import 'package:package_data_server_api/package_data_server_api.dart';

Film fromDtoToFilm(FilmDTO? film) {
  return Film(
      id: film?.id ?? 0,
      originalLanguage: film?.original_language ?? "",
      originalTitle: film?.original_title ?? "",
      overview: film?.overview ?? "",
      posterPath: film?.poster_path ?? "",
      title: film?.title ?? "",
      voteAverage: film?.vote_average?.toStringAsFixed(1) ?? "",
      backdropPath: film?.backdrop_path ?? "",
      voteCount: film?.vote_count?.toString() ?? "",
      generes: film?.genre_ids ?? [],
      releaseYear: _tryParseDate(
        film?.release_date ?? "",
      ));
}

String _tryParseDate(String s) {
  final year = DateTime.tryParse(s);
  return year != null ? year.year.toString() : "-";
}

// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'film.dto.g.dart';

@JsonSerializable()
class FilmDTO {
  final bool? adult;
  final String? backdrop_path;
  final List<int?>? genre_ids;
  final int? id;
  final String? original_language;
  final String? original_title;
  final String? overview;
  final double? popularity;
  final String? poster_path;
  final String? release_date;
  final String? title;
  final bool? video;
  final double? vote_average;
  final int? vote_count;

  FilmDTO({
    this.adult,
    this.backdrop_path,
    this.genre_ids,
    this.id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.release_date,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
  });

  factory FilmDTO.fromJson(Map<String, dynamic> json) =>
      _$FilmDTOFromJson(json);
}

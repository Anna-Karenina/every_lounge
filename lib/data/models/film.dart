class Film {
  final String backdropPath;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String posterPath;
  final String title;
  final String overview;
  final String voteAverage;
  final String releaseYear;
  final String voteCount;
  final List<int?> generes;

  Film(
      {required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.posterPath,
      required this.title,
      required this.overview,
      required this.voteAverage,
      required this.backdropPath,
      required this.releaseYear,
      required this.generes,
      required this.voteCount});
}

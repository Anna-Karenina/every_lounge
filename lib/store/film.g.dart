// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilmStore on FilmStoreBase, Store {
  late final _$filmsAtom = Atom(name: 'FilmStoreBase.films', context: context);

  @override
  List<Film?> get films {
    _$filmsAtom.reportRead();
    return super.films;
  }

  @override
  set films(List<Film?> value) {
    _$filmsAtom.reportWrite(value, super.films, () {
      super.films = value;
    });
  }

  late final _$generesAtom =
      Atom(name: 'FilmStoreBase.generes', context: context);

  @override
  List<Genere?> get generes {
    _$generesAtom.reportRead();
    return super.generes;
  }

  @override
  set generes(List<Genere?> value) {
    _$generesAtom.reportWrite(value, super.generes, () {
      super.generes = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'FilmStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLastPageAtom =
      Atom(name: 'FilmStoreBase.isLastPage', context: context);

  @override
  bool get isLastPage {
    _$isLastPageAtom.reportRead();
    return super.isLastPage;
  }

  @override
  set isLastPage(bool value) {
    _$isLastPageAtom.reportWrite(value, super.isLastPage, () {
      super.isLastPage = value;
    });
  }

  late final _$getFilmsAsyncAction =
      AsyncAction('FilmStoreBase.getFilms', context: context);

  @override
  Future<List<Film>> getFilms(int page, int size) {
    return _$getFilmsAsyncAction.run(() => super.getFilms(page, size));
  }

  late final _$getGeneresAsyncAction =
      AsyncAction('FilmStoreBase.getGeneres', context: context);

  @override
  Future<void> getGeneres() {
    return _$getGeneresAsyncAction.run(() => super.getGeneres());
  }

  @override
  String toString() {
    return '''
films: ${films},
generes: ${generes},
isLoading: ${isLoading},
isLastPage: ${isLastPage}
    ''';
  }
}

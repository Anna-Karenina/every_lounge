import 'package:every_test/data/mappers/dto_to_film.dart';
import 'package:every_test/data/mappers/dto_to_genere.dart';
import 'package:every_test/data/models/film.dart';
import 'package:every_test/data/models/genere.dart';
import 'package:mobx/mobx.dart';
import 'package:package_common/package_common.dart';
import 'package:package_data_server_api/package_data_server_api.dart';

part 'film.g.dart';

class FilmStore = FilmStoreBase with _$FilmStore;

abstract class FilmStoreBase with Store {
  final TheMoveDbRepository repository = DiManager.getTheMoveDbRepository();

  @observable
  List<Film?> films = [];

  @observable
  List<Genere?> generes = [];

  @observable
  bool isLoading = false;

  @observable
  bool isLastPage = false;

  @action
  Future<List<Film>> getFilms(int page, int size) async {
    try {
      isLoading = true;
      final apiList = await repository.getFilms(page, size);
      isLastPage = apiList.length < size;
      final currentPortition = apiList.map(fromDtoToFilm).toList();
      films = films + currentPortition;
      return currentPortition;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> getGeneres() async {
    try {
      isLoading = true;
      final apiList = await repository.getGenres();
      generes = apiList.map(fromDtoToGenere).toList();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }
}

import 'package:get_it/get_it.dart';
import 'package:package_data_server_api/package_data_server_api.dart';
import 'package:every_test/store/film.dart';

class DiManager {
  static GetIt getIt = GetIt.instance;

  static void initDi() {
    getIt.registerSingleton<HttpConfiguration>(HttpConfiguration());

    getIt.registerSingleton<TheMoveDbRepository>(TheMoveDbRepository(
      httpConfiguration: GetIt.instance.get<HttpConfiguration>(),
    ));
    getIt.registerSingleton<FilmStore>(FilmStore());
  }

  static TheMoveDbRepository getTheMoveDbRepository() =>
      getIt.get<TheMoveDbRepository>();
  static FilmStore getFilmStore() => getIt.get<FilmStore>();
}

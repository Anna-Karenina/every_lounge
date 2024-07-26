import 'package:every_test/data/models/genere.dart';
import 'package:package_data_server_api/package_data_server_api.dart';

Genere fromDtoToGenere(GenereDTO? genere) {
  return Genere(id: genere?.id ?? 0, name: genere?.name ?? "unknown");
}

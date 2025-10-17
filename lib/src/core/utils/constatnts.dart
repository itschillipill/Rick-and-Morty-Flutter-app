import 'package:rick_and_morty/src/data/models/info.dart';

class Constants {
  static const baseURL = "https://rickandmortyapi.com/api/";
  static const String apiDocumentationUrl =
      'https://rickandmortyapi.com/documentation/';
  static const characterEndpoint = "character";
  static const locationEndpoint = "location";
  static const episodeEndpoint = "episode";
  static Info info = Info(count: 826, pages: 42);
}

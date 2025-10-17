import 'package:rick_and_morty/src/core/network/dio_client.dart';
import 'package:rick_and_morty/src/core/utils/constatnts.dart';

import '../../../models/episode.dart';

class EpisodeService extends DioClient {
  Future<List<Episode>> getEpisodes({int? characterId}) async {
    List<Map<String, dynamic>> objects = await super.getAllEntities(
      '${Constants.baseURL}${Constants.episodeEndpoint}',
    );

    return List<Episode>.from(objects.map((x) => Episode.fromJson(x)));
  }

  Future<List<Episode>> getListOfEpisodes(List<String> ids) async {
    List<Map<String, dynamic>> objects = await super.getAllEntities(
      '${Constants.baseURL}${Constants.episodeEndpoint}/$ids',
      showResults: false,
    );

    return List<Episode>.from(objects.map((x) => Episode.fromJson(x)));
  }
}

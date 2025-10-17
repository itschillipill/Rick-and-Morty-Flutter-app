import 'package:rick_and_morty/src/core/network/dio_client.dart';
import 'package:rick_and_morty/src/core/utils/constatnts.dart';
import 'package:rick_and_morty/src/data/models/character.dart';


class CharacterService extends DioClient {
 Future<List<Character>> getAllCharacters({int page = 1}) async {
  final objects = await super.getAllEntities(
    '${Constants.baseURL}${Constants.characterEndpoint}?page=$page',
  );
  return List<Character>.from(objects.map((x) => Character.fromJson(x)));
} 

  Future<List<Character>> getListOfCharacters(List<String> ids) async {
    List<Map<String, dynamic>> objects = await super.getAllEntities(
        '${Constants.baseURL}${Constants.characterEndpoint}/$ids');

    return List<Character>.from(objects.map((x) => Character.fromJson(x)));
  }
}

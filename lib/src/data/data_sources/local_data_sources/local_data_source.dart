import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/src/data/models/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences _prefs;
  LocalDataSource({required SharedPreferences prefs}) : _prefs = prefs;

  static const String _favoritesKey = "favoritesIds";
  static const String _cacheFileName = "characters_cache.json";

  Future<File> _getCacheFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_cacheFileName');
  }

  Future<Map<String, dynamic>> _readCache() async {
    final file = await _getCacheFile();
    if (!await file.exists()) return {};
    final content = await file.readAsString();
    return jsonDecode(content) as Map<String, dynamic>;
  }

  Future<void> saveCharactersResponse(List<Character> characters, {required int page}) async {
    final file = await _getCacheFile();
    Map<String, dynamic> cache = await _readCache();

    cache[page.toString()] = characters.map((e) => e.toJson()).toList();

    await file.writeAsString(jsonEncode(cache));
  }

  Future<List<Character>?> getAllCharacters({required int page}) async {
    try {
      final cache = await _readCache();
      if (!cache.containsKey(page.toString())) return null;

      final data = cache[page.toString()] as List;
      return data.map((e) => Character.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }
  
  Future<List<Character>?> getListOfCharacters({required List<String> ids}) async {
    try {
      final cache = await _readCache();
      final allCharacters = cache.values
          .expand((pageList) => (pageList as List))
          .map((e) => Character.fromJson(e))
          .toList();

      final favorites = allCharacters
          .where((char) => ids.contains(char.id.toString()))
          .toList();

      return favorites;
    } catch (_) {
      return null;
    }
  }

  Future<void> clearCache() async {
    final file = await _getCacheFile();
    if (await file.exists()) {
      await file.delete();
    }
  }

  List<String> getFavoritesIds() {
    return _prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> setFavoritesIds(List<String> ids) async {
    await _prefs.setStringList(_favoritesKey, ids);
  }
}

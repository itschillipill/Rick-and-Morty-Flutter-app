import 'package:rick_and_morty/src/cubits/characters_cubit/characters_cubit.dart';
import 'package:rick_and_morty/src/cubits/settings_cubit/settings_cubit.dart';
import 'package:rick_and_morty/src/data/data_sources/local_data_sources/local_data_source.dart';
import 'package:rick_and_morty/src/data/data_sources/remote_data_sources/character/get_characters.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Dependencies {
  late SharedPreferences sharedPreferences;
  late LocalDataSource localDataSource;
  late CharacterService characterService;
  late CharactersCubit charactersCubit;
  late SettingsCubit settingsCubit;
}

import 'dart:async' show FutureOr;

import 'package:flutter/material.dart' show debugPrint;
import 'package:rick_and_morty/src/data/data_sources/local_data_sources/local_data_source.dart';
import 'package:rick_and_morty/src/data/data_sources/remote_data_sources/character/get_characters.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import '../cubits/characters_cubit/characters_cubit.dart';
import '../cubits/settings_cubit/settings_cubit.dart';
import 'dependencies.dart';
typedef _InitializationStep =
    FutureOr<void> Function(Dependencies dependencies);
    
class AppDependencies implements Dependencies {
  @override
  late SharedPreferences sharedPreferences;

  @override
  late CharacterService characterService;

  @override
  late LocalDataSource localDataSource;
  @override
  late CharactersCubit charactersCubit;
  @override
  late SettingsCubit settingsCubit;

} 

Future<Dependencies> $initializeDependencies() async{
   final steps = _initializationSteps;
    final dependencies = AppDependencies();
    final totalSteps = steps.length;
    for (var currentStep = 0; currentStep < totalSteps; currentStep++) {
      final step = steps[currentStep];
      final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
      debugPrint(
        'Initialization | $currentStep/$totalSteps ($percent%) | "${step.$1}"',
      );
      await step.$2(dependencies);
    }
    return dependencies;
}

List<(String, _InitializationStep)> get _initializationSteps =>
      <(String, _InitializationStep)>[
        ("prefs initialization",(deps)async{
          deps.sharedPreferences = await SharedPreferences.getInstance();
          return Future.value();
        }),
        ("local data source initialization",(deps)async{
          deps.localDataSource = LocalDataSource(prefs: deps.sharedPreferences);
          return Future.value();
        }),
        ("character service initialization",(deps)async{
          deps.characterService = CharacterService();
          return Future.value();
        }),
        ("characters cubit initialization",(deps)async{
          deps.charactersCubit = CharactersCubit(deps.characterService, deps.localDataSource);
          return Future.value();
        }),
        ("settings cubit initialization",(deps)async{
          deps.settingsCubit = SettingsCubit(deps.sharedPreferences);
          return Future.value();
        }),

      ];
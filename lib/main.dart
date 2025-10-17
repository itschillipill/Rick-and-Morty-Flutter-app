import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/core/theme/app_theme.dart';
import 'package:rick_and_morty/src/core/utils/app_data.dart';
import 'package:rick_and_morty/src/cubits/settings_cubit/settings_cubit.dart';
import 'package:rick_and_morty/src/cubits/settings_cubit/settings_state.dart';
import 'package:rick_and_morty/src/dependencies/widgets/dependencies_scope.dart';
import 'package:rick_and_morty/src/presentation/pages/app_gate.dart';

import 'src/dependencies/initialization.dart';
import 'src/dependencies/widgets/Initialization_splash_screen.dart';

void main() async {
  runZonedGuarded(() {
    final initialization = InitializationExecutor();
    runApp(
      DependenciesScope(
        initialization: initialization(
          orientations: [DeviceOrientation.portraitUp],
        ),
        splashScreen: InitializationSplashScreen(),
        child: const MyApp(),
      ),
    );
  }, (obj, stack) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final deps = DependenciesScope.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => deps.charactersCubit),
        BlocProvider(create: (context) => deps.settingsCubit),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppData.appTitle,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            themeMode: state.themeMode,
            home: const AppGate(),
          );
        },
      ),
    );
  }
}

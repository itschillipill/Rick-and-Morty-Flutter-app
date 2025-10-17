import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SharedPreferences _prefs;
  SettingsCubit(this._prefs) : super(SettingsState.initial()) {
    _loadSettings();
  }

  void _loadSettings() {
    final themeMode = ThemeMode.values[_prefs.getInt('themeMode') ?? 0];
    emit(state.copyWith(themeMode: themeMode));
  }

  void toggleTheme(ThemeMode themeMode) {
    _prefs.setInt('themeMode', themeMode.index);
    _loadSettings();
  }
}

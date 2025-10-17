import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/cubits/settings_cubit/settings_cubit.dart';
import 'package:rick_and_morty/src/cubits/settings_cubit/settings_state.dart';

class SettingsScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const SettingsScreen());

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Settings'), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile( 
                  title: Text("Theme"),
                  leading: Icon(Icons.dark_mode),
                  subtitle: Text("Choose app theme"),
                  trailing: DropdownButton<ThemeMode>(
                    padding: EdgeInsets.all(4),
                    borderRadius: BorderRadius.circular(8),
                    underline: SizedBox.shrink(),
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (value) {
                      if (value != null) {
                        context.read<SettingsCubit>().toggleTheme(value);
                      }
                    },
                    value: state.themeMode,
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text("Light"),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text("Dark"),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text("System"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/core/utils/constatnts.dart';
import 'package:rick_and_morty/src/presentation/pages/settings_screen.dart';

class NavigationBuider extends StatelessWidget {
  final Widget child;
  final int page;
  final Function(int value) onPageChanged;
  const NavigationBuider({
    super.key,
    required this.child,
    required this.page,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, SettingsScreen.route());
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if (page > 1) {
                    onPageChanged(page - 1);
                  }
                },
                icon: Icon(Icons.arrow_back),
              ),
              Text("Page $page"),
              IconButton(
                onPressed: () {
                  if (page < Constants.info.pages) {
                    onPageChanged(page + 1);
                  }
                },
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

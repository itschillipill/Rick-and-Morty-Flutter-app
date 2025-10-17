import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/presentation/pages/characters_page.dart';
import 'package:rick_and_morty/src/presentation/widgets/navigation_buider.dart';

class HomePage extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  const HomePage({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBuider(
      page: currentPage,
      onPageChanged: onPageChanged,
      child: CharactersPage(page: currentPage),
    );
  }
}

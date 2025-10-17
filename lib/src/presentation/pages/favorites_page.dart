import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/presentation/widgets/character_card.dart';

import '../../cubits/characters_cubit/characters_cubit.dart';
import '../../cubits/characters_cubit/characters_state.dart';
import '../../dependencies/widgets/dependencies_scope.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favoritesIds = [];
  bool isFavorite(String id) => favoritesIds.contains(id);
  @override
  Widget build(BuildContext context) {
    final localDataSource = DependenciesScope.of(context).localDataSource;
    final charactersCubit = DependenciesScope.of(context).charactersCubit;
    favoritesIds = localDataSource.getFavoritesIds();
    charactersCubit.getListOfCharacters(favoritesIds);
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: true),
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (favoritesIds.isEmpty) {
            return const Center(child: Text("No favorites"));
          }
          switch (state.status) {
            case CharactersStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case CharactersStatus.failure:
              return Center(
                child: Text(
                  'Failed to load characters:\n${state.errorMessage}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            case CharactersStatus.success:
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    favoritesIds = localDataSource.getFavoritesIds();
                  });
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.characters.length,
                  itemBuilder: (context, index) {
                    final character = state.characters[index];
                    return CharacterCard(
                      character: character,
                      isFavorite: isFavorite(character.id.toString()),
                      onFavoriteToggle: () {
                        setState(() {
                          if (isFavorite(character.id.toString())) {
                            favoritesIds.remove(character.id.toString());
                          } else {
                            favoritesIds.add(character.id.toString());
                          }
                          localDataSource.setFavoritesIds(favoritesIds);
                        });
                      },
                    );
                  },
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

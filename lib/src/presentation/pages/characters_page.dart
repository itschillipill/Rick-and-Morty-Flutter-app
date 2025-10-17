import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/cubits/characters_cubit/characters_cubit.dart';
import 'package:rick_and_morty/src/cubits/characters_cubit/characters_state.dart';
import 'package:rick_and_morty/src/dependencies/widgets/dependencies_scope.dart';
import 'package:rick_and_morty/src/presentation/widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  final int page;
  const CharactersPage({super.key, this.page=1});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  Widget build(BuildContext context) {
    final deps = DependenciesScope.of(context);
    final favoritesIds = deps.localDataSource.getFavoritesIds();
    bool isFavorite(String id)=> favoritesIds.contains(id);
    deps.charactersCubit.fetchAllCharacters(page: widget.page);
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
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
            final characters = state.characters;
            return RefreshIndicator(
              onRefresh: () =>deps.charactersCubit.fetchAllCharacters(page: widget.page),
              child: characters.isNotEmpty? ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return CharacterCard(character: character, 
                  isFavorite: isFavorite(character.id.toString()), 
                  onFavoriteToggle:() {
                    setState(() {
                      if(isFavorite(character.id.toString())){
                        favoritesIds.remove(character.id.toString());
                      }
                      else{
                        favoritesIds.add(character.id.toString());
                      }
                        deps.localDataSource.setFavoritesIds(favoritesIds);
                    });
                  },);
                },
              ):
              Center(
                child: Text("No characters"),
              )
              ,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

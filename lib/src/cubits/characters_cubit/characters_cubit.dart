import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/data/data_sources/local_data_sources/local_data_source.dart';
import '../../data/data_sources/remote_data_sources/character/get_characters.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterService _characterService;
  final LocalDataSource _localDataSource;

  CharactersCubit(this._characterService, this._localDataSource)
    : super(const CharactersState()) {
    fetchAllCharacters();
  }

  Future<void> fetchAllCharacters({int page = 1}) async {
    emit(state.copyWith(status: CharactersStatus.loading));

    try {
      final cached = await _localDataSource.getAllCharacters(page: page);
      if (cached != null && cached.isNotEmpty) {
        emit(
          state.copyWith(status: CharactersStatus.success, characters: cached),
        );
        debugPrint("got from cache");
        return;
      }

      final apiCharacters = await _characterService.getAllCharacters(
        page: page,
      );
      await _localDataSource.saveCharactersResponse(apiCharacters, page: page);
      debugPrint("got from api");

      emit(
        state.copyWith(
          status: CharactersStatus.success,
          characters: apiCharacters,
        ),
      );
    } catch (e) {
      final cached = await _localDataSource.getAllCharacters(page: page);
      if (cached != null && cached.isNotEmpty) {
        emit(
          state.copyWith(status: CharactersStatus.success, characters: cached),
        );
      } else {
        emit(
          state.copyWith(
            status: CharactersStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> getListOfCharacters(List<String> ids) async {
    emit(state.copyWith(status: CharactersStatus.loading));

    try {
      final cached = await _localDataSource.getListOfCharacters(ids: ids);
      if (cached != null && cached.isNotEmpty) {
        emit(
          state.copyWith(status: CharactersStatus.success, characters: cached),
        );
        debugPrint("got from cache");
        return;
      }

      final apiCharacters = await _characterService.getListOfCharacters(ids);
      debugPrint("got from api");

      emit(
        state.copyWith(
          status: CharactersStatus.success,
          characters: apiCharacters,
        ),
      );
    } catch (e) {
      final cached = await _localDataSource.getListOfCharacters(ids: ids);
      if (cached != null && cached.isNotEmpty) {
        emit(
          state.copyWith(status: CharactersStatus.success, characters: cached),
        );
      } else {
        emit(
          state.copyWith(
            status: CharactersStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}

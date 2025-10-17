import '../../data/models/character.dart';

enum CharactersStatus { initial, loading, success, failure }

class CharactersState {
  final CharactersStatus status;
  final List<Character> characters;
  final String? errorMessage;

  const CharactersState({
    this.status = CharactersStatus.initial,
    this.characters = const [],
    this.errorMessage,
  });

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
    String? errorMessage,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

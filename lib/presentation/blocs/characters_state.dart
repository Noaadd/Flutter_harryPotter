import 'package:blockflutter/domain/entities/character.dart';
import 'package:equatable/equatable.dart';

class CharacterState extends Equatable{
  final List<Character> characters;
  final bool isLoading;
  final String errorMessage;
  final String filter;

  const CharacterState({
    required this.characters,
    required this.isLoading,
    required this.errorMessage,
    required this.filter,
});

  factory CharacterState.initial(){
    return const CharacterState(
      characters: [],
      isLoading: false,
      errorMessage: '',
      filter: '',
    );
  }

  CharacterState copyWith({
    List<Character>? characters,
    bool? isLoading,
    String? errorMessage,
    String? filter,
}) {
    return CharacterState(
      characters: characters ?? this.characters,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.errorMessage,
    );
  }
  @override
  List<Object?> get props => [characters, isLoading, errorMessage, filter];
}
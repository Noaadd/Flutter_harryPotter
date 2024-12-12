import 'package:blockflutter/domain/usecases/get_all_characters_usecase.dart';
import 'package:blockflutter/presentation/blocs/characters_events.dart';
import 'package:blockflutter/presentation/blocs/characters_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState>{
  final GetAllCharacters getAllCharacters;

  CharacterBloc(this.getAllCharacters) : super(CharacterState.initial()){
    on<LoadCharactersEvent>(_onLoadCharacters);
  }

  Future<void> _onLoadCharacters(
      LoadCharactersEvent event,
      Emitter<CharacterState> emit,
    ) async {
    emit(state.copyWith(isLoading: true, filter: event.filter));
    final result = await getAllCharacters();
    result.fold(
        (error) => emit(
          state.copyWith(isLoading: false, errorMessage: error.toString())),
        (characters){
          final filteredCharacters = characters.where((character){
            return character.name.toLowerCase().contains(event.filter.toLowerCase());
          }).toList();
          emit(state.copyWith(isLoading: false, characters: filteredCharacters));
        }
    );
  }
}
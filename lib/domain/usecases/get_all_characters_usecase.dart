import 'package:blockflutter/domain/entities/character.dart';
import 'package:blockflutter/domain/repositories/character_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCharacters{
  final CharacterRepository repository;

  GetAllCharacters(this.repository);

  Future<Either<Exception, List<Character>>> call() async {
    return await repository.getAllCharacters();
  }
}
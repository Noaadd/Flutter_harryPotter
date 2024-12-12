import 'package:dartz/dartz.dart';

import '../entities/character.dart';

abstract class CharacterRepository{
  Future<Either<Exception, List<Character>>> getAllCharacters();
}
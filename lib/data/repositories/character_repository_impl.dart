import 'package:blockflutter/data/datasources/character_remote_datasource.dart';
import 'package:blockflutter/domain/entities/character.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository{
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, List<Character>>> getAllCharacters() async {
    try{
      final characterModels = await remoteDataSource.getAllCharacters();
      return Right(characterModels.map((model) => Character(name: model.name, house: model.house, image: model.image)).toList());
    }catch(e){
      return Left(Exception('Error al cargar personajes'));
    }
  }
}


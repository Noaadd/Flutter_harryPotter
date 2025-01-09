import 'package:blockflutter/presentation/blocs/character_bloc.dart';
import 'package:blockflutter/presentation/blocs/login/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/character_remote_datasource.dart';
import 'data/datasources/login_fake_datasource.dart';
import 'data/repositories/character_repository_impl.dart';
import 'data/repositories/login_repository.dart';
import 'data/repositories/login_repository_impl.dart';
import 'domain/repositories/character_repository.dart';
import 'domain/usecases/get_all_characters_usecase.dart';
import 'package:http/http.dart' as http;

import 'domain/usecases/login_user_usecase.dart';

final sl = GetIt.instance;
Future<void> init() async {
// BloC
  sl.registerFactory(() => CharacterBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl(), sl()));
// Casos de uso
  sl.registerLazySingleton(() => GetAllCharacters(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
// Repositorios
  sl.registerLazySingleton<CharacterRepository>(
          () => CharacterRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(sl(), sl()),
  );
// Data sources
  sl.registerLazySingleton<CharacterRemoteDataSource>(
        () => CharacterRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<LoginFakeDatasource>(
        () => LoginFakeDatasourceImpl(),
  );
// Cliente HTTP
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
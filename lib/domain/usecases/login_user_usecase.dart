import 'package:blockflutter/data/repositories/login_repository.dart';
import 'package:blockflutter/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

class LoginUser {
  final LoginRepository repository;
  LoginUser(this.repository);

  Future<Either<Exception, User>> call (String email, String password) async{
    return await repository.login(email, password);
  }
}
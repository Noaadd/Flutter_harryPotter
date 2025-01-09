import 'package:blockflutter/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Exception, User>> login (String email, String password);
  Future<Either<Exception, bool>> isLoggedIn();
  Future<void> logout();
}
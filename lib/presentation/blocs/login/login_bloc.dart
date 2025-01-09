import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/login_repository.dart';
import '../../../domain/usecases/login_user_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final LoginRepository loginRepository;
  LoginBloc(this.loginUser, this.loginRepository) : super(const LoginState())
  {
    on<LoginButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await loginUser(event.email, event.password);
      result.fold(
              (error) => emit(
              state.copyWith(isLoading: false, errorMessage:
              error.toString())),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
      );
    });
    on<LogoutButtonPressed>((event, emit) async {
      await loginRepository.logout();
      emit(const LoginState());
    });
  }
}
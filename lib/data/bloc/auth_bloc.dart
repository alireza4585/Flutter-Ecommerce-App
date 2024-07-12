import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapi/data/bloc/auth_event.dart';
import 'package:loginapi/data/bloc/auth_state.dart';
import 'package:loginapi/data/repository/auth_repository.dart';
import 'package:loginapi/gitit/gitit.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository = locator.get();

  AuthBloc() : super(AuthinitState()) {
    on<AuthLoginRequest>(
      (event, emit) async {
        emit(AuthloadingState());
        var login = await _authRepository.login(event.username, event.password);
        emit(AuthRequestSuccessSate(login));
      },
    );
    on<AuthRegisterRequest>(
      (event, emit) async {
        emit(AuthloadingState());
        var register = await _authRepository.register(
            event.email, event.password, event.passwordConfirm, event.username);
        emit(AuthRequestSuccessSate(register));
      },
    );
  }
}

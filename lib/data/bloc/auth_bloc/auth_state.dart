import 'package:either_dart/either.dart';

abstract class AuthState {}

class AuthinitState extends AuthState {}

class AuthloadingState extends AuthState {}

class AuthRequestSuccessSate extends AuthState {
  Either<String, String> response;
  AuthRequestSuccessSate(this.response);
}

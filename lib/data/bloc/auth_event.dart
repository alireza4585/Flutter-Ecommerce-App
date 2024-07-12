abstract class AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  String username;
  String password;
  AuthLoginRequest(this.password, this.username);
}

class AuthRegisterRequest extends AuthEvent {
  String username;
  String email;
  String password;
  String passwordConfirm;
  AuthRegisterRequest(
      this.email, this.password, this.passwordConfirm, this.username);
}

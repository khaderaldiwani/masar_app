
sealed class LoginState  {
  const LoginState();

}

final class LoginInitial extends LoginState {}
final class LoginChangeRemamber extends LoginState {}
final class LoginChangeObscure extends LoginState {}
final class LoginLoadingState extends LoginState {}
final class LoginSaccessState extends LoginState {}
final class LoginFnishLoginState extends LoginState {}

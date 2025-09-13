
sealed class ResetPasswordState{
}

final class ResetPasswordInitial extends ResetPasswordState {}
final class ResetPasswordChangeObscure1 extends ResetPasswordState {}
final class ResetPasswordChangeObscure2 extends ResetPasswordState {}
final class ResetPasswordLoadingState extends ResetPasswordState {}
final class ResetPasswordFnishState extends ResetPasswordState {}

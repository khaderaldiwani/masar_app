
sealed class CheckCodeState  {
}

final class CheckCodeInitial extends CheckCodeState {}
final class CheckCodeTimerdownState extends CheckCodeState {}
final class VerifyLoadingState extends CheckCodeState {}
final class VerifyFnishState extends CheckCodeState {}

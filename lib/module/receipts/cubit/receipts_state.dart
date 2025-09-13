
sealed class ReceiptsState  {
  const ReceiptsState();

}

final class ReceiptsInitial extends ReceiptsState {}
final class ReceiptsSuccessState extends ReceiptsState {}
final class ReceiptsFinishState extends ReceiptsState {}
final class ReceiptsChangeOngoing extends ReceiptsState {}

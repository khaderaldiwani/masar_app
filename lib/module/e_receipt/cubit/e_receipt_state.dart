sealed class EReceiptState  {
  const EReceiptState();

 
}

final class EReceiptInitial extends EReceiptState {}
final class EReceiptSuccessState extends EReceiptState {}
final class EReceiptFinishState extends EReceiptState {}

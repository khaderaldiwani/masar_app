
sealed class AllTeachersState  {
  const AllTeachersState();

}

final class AllTeachersInitial extends AllTeachersState {}
final class AllTeachersSuccessGetDataState extends AllTeachersState {}
final class AllTeachersFinishGetDataState extends AllTeachersState {}


sealed class MyCoursesState  {
}

final class MyCoursesInitial extends MyCoursesState {}
final class MyCoursesChangeOngoing extends MyCoursesState {}
final class MyCoursesCoursesSuccessRequestState extends MyCoursesState {}
final class MyCoursesFinishRequestState extends MyCoursesState {}

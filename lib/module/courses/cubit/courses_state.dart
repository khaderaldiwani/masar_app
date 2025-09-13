
sealed class CoursesState  {
  const CoursesState();

}

final class CoursesInitial extends CoursesState {}
final class CoursesChangeIndexTapState extends CoursesState {}
final class CoursesSuccessState extends CoursesState {}
final class CoursesFinishState extends CoursesState {}

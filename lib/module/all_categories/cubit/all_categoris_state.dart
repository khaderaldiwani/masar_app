
sealed class AllCategoriesState  {
  const AllCategoriesState();
}

final class AllCategoriesInitial extends AllCategoriesState {}
final class AllCategoriesSuccessState extends AllCategoriesState {}
final class AllCategoriesFinishState extends AllCategoriesState {}

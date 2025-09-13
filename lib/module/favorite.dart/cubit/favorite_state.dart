
sealed class FavoriteState  {
  const FavoriteState();

}

final class FavoriteInitial extends FavoriteState {}
final class FavoriteSuccessGetDataState extends FavoriteState {}
final class FavoriteFinishGetDataState extends FavoriteState {}


sealed class SearchState  {
  const SearchState();

}

final class SearchInitial extends SearchState {}
final class SearchChangeLevelState extends SearchState {}
final class SearchChangeTimeState extends SearchState {}
final class SearchSelectCertificateState extends SearchState {}
final class SearchChangeModeSearchState extends SearchState {}
final class SearchChangeOrderByState extends SearchState {}
final class SearchSuccessGetDataState extends SearchState {}
final class SearchFinshGetDataState extends SearchState {}


sealed class ProfileState {
  const ProfileState();

}

final class ProfileInitial extends ProfileState {}
final class ProfileChooseImageState extends ProfileState {}
final class ProfileGoToDetails extends ProfileState {}
final class ProfileSuccessRequestState extends ProfileState {}
final class ProfileFinishRequestState extends ProfileState {}


sealed class SettingState  {
  const SettingState();

}

final class SettingInitial extends SettingState {}
final class SettingChangeModeState extends SettingState {}
final class SettingChooseImageState extends SettingState {}
final class SettingFnishLogoutState extends SettingState {}
final class SettingSuccessLogoutState extends SettingState {}

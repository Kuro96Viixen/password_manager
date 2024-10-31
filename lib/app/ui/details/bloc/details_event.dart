part of 'details_bloc.dart';

@freezed
class DetailsEvent with _$DetailsEvent {
  const factory DetailsEvent.started() = _Started;

  const factory DetailsEvent.pressedBack() = _PressedBack;

  const factory DetailsEvent.pressedDelete() = _PressedDelete;

  const factory DetailsEvent.deleteAccount(AccountData accountData) =
      _DeleteAccount;

  const factory DetailsEvent.revealPassword(Password password) =
      _RevealPassword;

  const factory DetailsEvent.copyPassword(Password password) = _CopyPassword;

  const factory DetailsEvent.pressedModify() = _PressedModify;
}

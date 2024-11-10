part of 'private_bloc.dart';

@freezed
class PrivateEvent with _$PrivateEvent {
  const factory PrivateEvent.started() = _Started;

  const factory PrivateEvent.pressedAccount(int accountIndex) = _PressedAccount;

  const factory PrivateEvent.searchAccount(String searchString) =
      _SearchAccount;
}

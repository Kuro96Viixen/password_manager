import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_event.freezed.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const factory AccountsEvent.started({
    @Default(false) bool initializeEncryption,
  }) = _Started;

  const factory AccountsEvent.pressedAccount(int accountIndex) =
      _PressedAccount;
  const factory AccountsEvent.pressedModify() = _PressedModify;

  const factory AccountsEvent.showPrivate() = _ShowPrivate;

  const factory AccountsEvent.searchAccount(String searchString) =
      _SearchAccount;

  const factory AccountsEvent.onRandomPasswordPressed() =
      _OnRandomPasswordPressed;

  const factory AccountsEvent.showSettings() = _ShowSettings;
  const factory AccountsEvent.exportAccounts() = _ExportAccounts;
  const factory AccountsEvent.importAccounts() = _ImportAccounts;
}

part of 'accounts_bloc.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const factory AccountsEvent.started() = _Started;

  const factory AccountsEvent.pressedAccount(int accountIndex) =
      _PressedAccount;
  const factory AccountsEvent.pressedModify() = _PressedModify;

  const factory AccountsEvent.showPrivate() = _ShowPrivate;
  const factory AccountsEvent.closePrivate() = _ClosePrivate;

  const factory AccountsEvent.searchAccount(String searchString) =
      _SearchAccount;

  const factory AccountsEvent.showSettings() = _ShowSettings;
  const factory AccountsEvent.exportAccounts() = _ExportAccounts;
  const factory AccountsEvent.importAccounts() = _ImportAccounts;
}

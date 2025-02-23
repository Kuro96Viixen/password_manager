part of 'accounts_bloc.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const factory AccountsEvent.started(String encryptionKey) = _Started;

  const factory AccountsEvent.pressedAccount(int accountIndex) =
      _PressedAccount;
  const factory AccountsEvent.pressedModify() = _PressedModify;

  const factory AccountsEvent.showPrivate() = _ShowPrivate;

  const factory AccountsEvent.searchAccount(String searchString) =
      _SearchAccount;

  // TODO(Kuro): Uncomment this when GP deployed
  // const factory AccountsEvent.showSettings() = _ShowSettings;
  // const factory AccountsEvent.exportAccounts() = _ExportAccounts;
  // const factory AccountsEvent.importAccounts() = _ImportAccounts;
}

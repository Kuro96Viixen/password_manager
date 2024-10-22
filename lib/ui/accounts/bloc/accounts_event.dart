part of 'accounts_bloc.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const factory AccountsEvent.started() = _Started;

  const factory AccountsEvent.viewAccount(int accountIndex) = _ViewAccount;
  const factory AccountsEvent.addAccount() = _AddAccount;

  const factory AccountsEvent.showPrivate() = _ShowPrivate;
  const factory AccountsEvent.closePrivate() = _ClosePrivate;

  const factory AccountsEvent.searchAccount(String searchString) =
      _SearchAccount;

  const factory AccountsEvent.showSettings() = _ShowSettings;
  const factory AccountsEvent.exportAccounts() = _ExportAccounts;
  const factory AccountsEvent.importAccounts() = _ImportAccounts;
}

import 'package:equatable/equatable.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object?> get props => [];
}

final class AccountsStarted extends AccountsEvent {
  const AccountsStarted({this.initializeEncryption = false});

  final bool initializeEncryption;

  @override
  List<Object?> get props => [initializeEncryption];
}

final class AccountsAccountPressed extends AccountsEvent {
  const AccountsAccountPressed(this.accountIndex);

  final int accountIndex;

  @override
  List<Object?> get props => [accountIndex];
}

final class AccountsModifyPressed extends AccountsEvent {
  const AccountsModifyPressed();
}

final class AccountsShowPrivate extends AccountsEvent {
  const AccountsShowPrivate();
}

final class AccountsSearchAccount extends AccountsEvent {
  const AccountsSearchAccount(this.searchString);

  final String searchString;

  @override
  List<Object?> get props => [searchString];
}

final class AccountsRandomPasswordPressed extends AccountsEvent {
  const AccountsRandomPasswordPressed();
}

final class AccountsShowSettings extends AccountsEvent {
  const AccountsShowSettings();
}

final class AccountsExportAccounts extends AccountsEvent {
  const AccountsExportAccounts();
}

final class AccountsImportAccounts extends AccountsEvent {
  const AccountsImportAccounts();
}

final class AccountsMarkNavigationEventAsConsumed extends AccountsEvent {
  const AccountsMarkNavigationEventAsConsumed();
}

final class AccountsMarkBottomMenuAsConsumed extends AccountsEvent {
  const AccountsMarkBottomMenuAsConsumed();
}

final class AccountsMarkExportedSnackBarAsConsumed extends AccountsEvent {
  const AccountsMarkExportedSnackBarAsConsumed();
}

final class AccountsMarkImportedSnackBarAsConsumed extends AccountsEvent {
  const AccountsMarkImportedSnackBarAsConsumed();
}

final class AccountsMarkDialogAsConsumed extends AccountsEvent {
  const AccountsMarkDialogAsConsumed();
}

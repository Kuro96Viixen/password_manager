import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_event.freezed.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const factory AccountsEvent.started({
    @Default(false) bool initializeEncryption,
  }) = Started;

  const factory AccountsEvent.pressedAccount(int accountIndex) = PressedAccount;
  const factory AccountsEvent.pressedModify() = PressedModify;

  const factory AccountsEvent.showPrivate() = ShowPrivate;

  const factory AccountsEvent.searchAccount(String searchString) =
      SearchAccount;

  const factory AccountsEvent.onRandomPasswordPressed() =
      OnRandomPasswordPressed;

  const factory AccountsEvent.showSettings() = ShowSettings;
  const factory AccountsEvent.exportAccounts() = ExportAccounts;
  const factory AccountsEvent.importAccounts() = ImportAccounts;

  const factory AccountsEvent.markNavigationEventAsConsumed() =
      MarkNavigationEventAsConsumed;
  const factory AccountsEvent.markBottomMenuAsConsumed() =
      MarkBottomMenuAsConsumed;
  const factory AccountsEvent.markSnackBarAsConsumed() = MarkSnackBarAsConsumed;
  const factory AccountsEvent.markDialogAsConsumed() = MarkDialogAsConsumed;
}

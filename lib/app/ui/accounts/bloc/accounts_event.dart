import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_event.freezed.dart';

@freezed
sealed class AccountsEvent with _$AccountsEvent {
  const factory AccountsEvent.started({
    @Default(false) bool initializeEncryption,
  }) = Started;

  // Account List Tile
  const factory AccountsEvent.pressedAccount(int accountIndex) = PressedAccount;

  // Screen Buttons
  const factory AccountsEvent.pressedModify() = PressedModify;

  // AppBar Buttons
  const factory AccountsEvent.showPrivate() = ShowPrivate;

  // Search Bar
  const factory AccountsEvent.searchAccount(String searchString) =
      SearchAccount;

  // Random Password Button
  const factory AccountsEvent.onRandomPasswordPressed() =
      OnRandomPasswordPressed;

  // Bottom Menu Buttons
  const factory AccountsEvent.showSettings() = ShowSettings;
  const factory AccountsEvent.exportAccounts() = ExportAccounts;
  const factory AccountsEvent.importAccounts() = ImportAccounts;

  // Event Consumer
  const factory AccountsEvent.markNavigationEventAsConsumed() =
      MarkNavigationEventAsConsumed;
  const factory AccountsEvent.markBottomMenuAsConsumed() =
      MarkBottomMenuAsConsumed;
  const factory AccountsEvent.markSnackBarAsConsumed() = MarkSnackBarAsConsumed;
  const factory AccountsEvent.markDialogAsConsumed() = MarkDialogAsConsumed;
}

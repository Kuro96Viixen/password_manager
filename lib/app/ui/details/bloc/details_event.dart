import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

part 'details_event.freezed.dart';

@freezed
class DetailsEvent with _$DetailsEvent {
  const factory DetailsEvent.started(AccountData accountData) = Started;

  // AppBar Buttons Pressed
  const factory DetailsEvent.pressedDelete() = PressedDelete;

  // Delete Account Pop-Up Button
  const factory DetailsEvent.deleteAccount(AccountData accountData) =
      DeleteAccount;

  // Passwords Events
  const factory DetailsEvent.revealPassword(Password password) = RevealPassword;
  const factory DetailsEvent.copyPassword(Password password) = CopyPassword;

  // Modify Button
  const factory DetailsEvent.pressedModify() = PressedModify;

  // Event Consumer
  // No need to consume goBackEvent as it will close the page
  const factory DetailsEvent.markModifyAsConsumed() = MarkModifyAsConsumed;
  // const factory DetailsEvent.markGoBackAsConsumed() = MarkGoBackAsConsumed;
  const factory DetailsEvent.markSnackBarAsConsumed() = MarkSnackBarAsConsumed;
  const factory DetailsEvent.markPopUpAsConsumed() = MarkPopUpAsConsumed;
}

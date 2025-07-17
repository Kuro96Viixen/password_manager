import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

part 'modify_event.freezed.dart';

@freezed
class ModifyEvent with _$ModifyEvent {
  const factory ModifyEvent.started(AccountData? accountData) = Started;

  const factory ModifyEvent.onNameChanged(String nameString) = OnNameChanged;
  const factory ModifyEvent.onUsernameChanged(String usernameString) =
      OnUsernameChanged;

  // Switch to change forms
  const factory ModifyEvent.onChangePasswordForm({
    required bool isRandomPasswordForm,
  }) = OnChangePasswordForm;

  // Password form
  const factory ModifyEvent.onPasswordChanged(String passwordString) =
      OnPasswordChanged;
  const factory ModifyEvent.hidePassword() = HidePassword;

  // Random password form
  const factory ModifyEvent.onRandomPasswordLengthChanged(
    String randomPasswordLengthString,
  ) = OnRandomPasswordLengthChanged;
  const factory ModifyEvent.hasSpanishCharacters({
    required bool hasSpanishCharacters,
  }) = HasSpanishCharacters;
  const factory ModifyEvent.hasNumbersCharacters({
    required bool hasNumbersCharacters,
  }) = HasNumbersCharacters;
  const factory ModifyEvent.hasSymbolsCharacters({
    required bool hasSymbolsCharacters,
  }) = HasSymbolsCharacters;
  const factory ModifyEvent.generateRandomPassword() = GenerateRandomPassword;
  const factory ModifyEvent.copyPassword(String password) = CopyPassword;

  // Save Account
  const factory ModifyEvent.setIsPrivateAccount({
    required bool isPrivateAccount,
  }) = SetIsPrivateAccount;
  const factory ModifyEvent.saveAccount(AccountData? accountData) = SaveAccount;

  // Event Consumer
  // No need to consume goBackEvent as it will close the page
  // const factory ModifyEvent.markGoBackAsConsumed() = MarkGoBackAsConsumed;
  const factory ModifyEvent.markSnackBarAsConsumed() = MarkSnackBarAsConsumed;
}

part of 'modify_bloc.dart';

@freezed
class ModifyEvent with _$ModifyEvent {
  const factory ModifyEvent.started(AccountData? accountData) = _Started;

  const factory ModifyEvent.onNameChanged(String nameString) = _OnNameChanged;
  const factory ModifyEvent.onUsernameChanged(String usernameString) =
      _OnUsernameChanged;

  // Switch to change forms
  const factory ModifyEvent.onChangePasswordForm(bool isRandomPasswordForm) =
      _OnChangePasswordForm;

  // Password form
  const factory ModifyEvent.onPasswordChanged(String passwordString) =
      _OnPasswordChanged;
  const factory ModifyEvent.hidePassword() = _HidePassword;

  // Random password form
  const factory ModifyEvent.onRandomPasswordLengthChanged(
    String randomPasswordLengthString,
  ) = _OnRandomPasswordLengthChanged;
  const factory ModifyEvent.hasSpanishCharacters(bool hasSpanishCharacters) =
      _HasSpanishCharacters;
  const factory ModifyEvent.hasNumbersCharacters(bool hasNumbersCharacters) =
      _HasNumbersCharacters;
  const factory ModifyEvent.hasSymbolsCharacters(bool hasSymbolsCharacters) =
      _HasSymbolsCharacters;
  const factory ModifyEvent.generateRandomPassword() = _GenerateRandomPassword;
  const factory ModifyEvent.copyPassword(String password) = _CopyPassword;

  // Save Account
  const factory ModifyEvent.setIsPrivateAccount(bool isPrivateAccount) =
      _SetIsPrivateAccount;
  const factory ModifyEvent.saveAccount(AccountData? accountData) =
      _SaveAccount;
}

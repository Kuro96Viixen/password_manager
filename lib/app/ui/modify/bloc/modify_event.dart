import 'package:equatable/equatable.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

sealed class ModifyEvent extends Equatable {
  const ModifyEvent();

  @override
  List<Object?> get props => [];
}

final class ModifyStarted extends ModifyEvent {
  const ModifyStarted(this.accountData);

  final AccountData? accountData;

  @override
  List<Object?> get props => [accountData];
}

final class OnNameChanged extends ModifyEvent {
  const OnNameChanged(this.nameString);

  final String nameString;

  @override
  List<Object?> get props => [nameString];
}

final class OnUsernameChanged extends ModifyEvent {
  const OnUsernameChanged(this.usernameString);

  final String usernameString;

  @override
  List<Object?> get props => [usernameString];
}

// Switch to change forms
final class OnChangePasswordForm extends ModifyEvent {
  const OnChangePasswordForm({this.isRandomPasswordForm = false});

  final bool isRandomPasswordForm;

  @override
  List<Object?> get props => [isRandomPasswordForm];
}

// Password form
final class OnPasswordChanged extends ModifyEvent {
  const OnPasswordChanged(this.passwordString);

  final String passwordString;

  @override
  List<Object?> get props => [passwordString];
}

final class HidePassword extends ModifyEvent {
  const HidePassword();
}

// Random password form
final class OnRandomPasswordLengthChanged extends ModifyEvent {
  const OnRandomPasswordLengthChanged(
    this.randomPasswordLengthString,
  );

  final String randomPasswordLengthString;

  @override
  List<Object?> get props => [randomPasswordLengthString];
}

final class HasSpanishCharacters extends ModifyEvent {
  const HasSpanishCharacters({this.hasSpanishCharacters = false});

  final bool hasSpanishCharacters;

  @override
  List<Object?> get props => [hasSpanishCharacters];
}

final class HasNumbersCharacters extends ModifyEvent {
  const HasNumbersCharacters({this.hasNumbersCharacters = false});

  final bool hasNumbersCharacters;

  @override
  List<Object?> get props => [hasNumbersCharacters];
}

final class HasSymbolsCharacters extends ModifyEvent {
  const HasSymbolsCharacters({this.hasSymbolsCharacters = false});

  final bool hasSymbolsCharacters;

  @override
  List<Object?> get props => [hasSymbolsCharacters];
}

final class GenerateRandomPassword extends ModifyEvent {
  const GenerateRandomPassword();
}

// Copy Password
final class CopyPassword extends ModifyEvent {
  const CopyPassword();
}

// Save Account
final class SetIsPrivateAccount extends ModifyEvent {
  const SetIsPrivateAccount({required this.isPrivateAccount});

  final bool isPrivateAccount;

  @override
  List<Object?> get props => [isPrivateAccount];
}

final class SaveAccount extends ModifyEvent {
  const SaveAccount(this.accountData);

  final AccountData? accountData;

  @override
  List<Object?> get props => [accountData];
}

// Event Consumer
// No need to consume goBackEvent as it will close the page
// final class MarkGoBackAsConsumed extends ModifyEvent {
//   const MarkGoBackAsConsumed();
// }
final class MarkCopySnackBarAsConsumed extends ModifyEvent {
  const MarkCopySnackBarAsConsumed();
}

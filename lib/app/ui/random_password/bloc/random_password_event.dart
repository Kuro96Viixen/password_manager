import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_password_event.freezed.dart';

@freezed
class RandomPasswordEvent with _$RandomPasswordEvent {
  const factory RandomPasswordEvent.onRandomPasswordLengthChanged(
    String randomPasswordLengthString,
  ) = _OnRandomPasswordLengthChanged;

  const factory RandomPasswordEvent.hasSpanishCharacters({
    required bool hasSpanishCharacters,
  }) = _HasSpanishCharacters;

  const factory RandomPasswordEvent.hasNumbersCharacters({
    required bool hasNumbersCharacters,
  }) = _HasNumbersCharacters;

  const factory RandomPasswordEvent.hasSymbolsCharacters({
    required bool hasSymbolsCharacters,
  }) = _HasSymbolsCharacters;

  const factory RandomPasswordEvent.generateRandomPassword() =
      _GenerateRandomPassword;

  const factory RandomPasswordEvent.copyPassword() = _CopyPassword;
}

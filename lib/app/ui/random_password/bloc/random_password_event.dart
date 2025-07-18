import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_password_event.freezed.dart';

@freezed
sealed class RandomPasswordEvent with _$RandomPasswordEvent {
  // Password Length
  const factory RandomPasswordEvent.onRandomPasswordLengthChanged(
    String randomPasswordLengthString,
  ) = OnRandomPasswordLengthChanged;

  // CheckBox
  const factory RandomPasswordEvent.hasSpanishCharacters({
    required bool hasSpanishCharacters,
  }) = HasSpanishCharacters;
  const factory RandomPasswordEvent.hasNumbersCharacters({
    required bool hasNumbersCharacters,
  }) = HasNumbersCharacters;
  const factory RandomPasswordEvent.hasSymbolsCharacters({
    required bool hasSymbolsCharacters,
  }) = HasSymbolsCharacters;

  // Button
  const factory RandomPasswordEvent.generateRandomPassword() =
      GenerateRandomPassword;

  // Copy Password
  const factory RandomPasswordEvent.copyPassword() = CopyPassword;

  // Event Consumer
  const factory RandomPasswordEvent.markSnackBarEventAsConsumed() =
      MarkSnackBarEventAsConsumed;
}

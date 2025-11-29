import 'package:equatable/equatable.dart';

sealed class RandomPasswordEvent extends Equatable {
  const RandomPasswordEvent();

  @override
  List<Object?> get props => [];
}

// Password Length
final class OnRandomPasswordLengthChanged extends RandomPasswordEvent {
  const OnRandomPasswordLengthChanged(
    this.randomPasswordLengthString,
  );

  final String randomPasswordLengthString;

  @override
  List<Object?> get props => [randomPasswordLengthString];
}

// CheckBox
final class HasSpanishCharacters extends RandomPasswordEvent {
  const HasSpanishCharacters({this.hasSpanishCharacters = false});

  final bool hasSpanishCharacters;

  @override
  List<Object?> get props => [hasSpanishCharacters];
}

final class HasNumbersCharacters extends RandomPasswordEvent {
  const HasNumbersCharacters({this.hasNumbersCharacters = false});

  final bool hasNumbersCharacters;

  @override
  List<Object?> get props => [hasNumbersCharacters];
}

final class HasSymbolsCharacters extends RandomPasswordEvent {
  const HasSymbolsCharacters({this.hasSymbolsCharacters = false});

  final bool hasSymbolsCharacters;

  @override
  List<Object?> get props => [hasSymbolsCharacters];
}

// Button
final class GenerateRandomPassword extends RandomPasswordEvent {
  const GenerateRandomPassword();
}

// Copy Password
final class CopyPassword extends RandomPasswordEvent {
  const CopyPassword();
}

// Event Consumer
final class MarkCopySnackBarEventAsConsumed extends RandomPasswordEvent {
  const MarkCopySnackBarEventAsConsumed();
}

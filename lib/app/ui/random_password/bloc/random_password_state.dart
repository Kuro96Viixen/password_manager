import 'package:equatable/equatable.dart';
import 'package:password_manager/app/core/constants/validation.dart';
import 'package:password_manager/app/domain/model/password_strength.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

final class RandomPasswordState extends Equatable {
  const RandomPasswordState({
    required this.randomPasswordLength,
    required this.randomPassword,
    required this.randomPasswordStrength,
    required this.hasSpanishCharacters,
    required this.hasNumbersCharacters,
    required this.hasSymbolsCharacters,
    required this.copySnackBarEvent,
  });

  factory RandomPasswordState.initial() => const RandomPasswordState(
    randomPasswordLength: kDefaultPasswordLength,
    randomPassword: '',
    randomPasswordStrength: PasswordStrength.unset,
    hasSpanishCharacters: false,
    hasNumbersCharacters: true,
    hasSymbolsCharacters: true,
    copySnackBarEvent: UIEvent(consumed: true),
  );

  final int randomPasswordLength;
  final String randomPassword;
  final PasswordStrength randomPasswordStrength;
  final bool hasSpanishCharacters;
  final bool hasNumbersCharacters;
  final bool hasSymbolsCharacters;
  final UIEvent<void> copySnackBarEvent;

  @override
  List<Object?> get props => [
    randomPasswordLength,
    randomPassword,
    randomPasswordStrength,
    hasSpanishCharacters,
    hasNumbersCharacters,
    hasSymbolsCharacters,
    copySnackBarEvent,
  ];

  RandomPasswordState copyWith({
    int? randomPasswordLength,
    String? randomPassword,
    PasswordStrength? randomPasswordStrength,
    bool? hasSpanishCharacters,
    bool? hasNumbersCharacters,
    bool? hasSymbolsCharacters,
    UIEvent<void>? copySnackBarEvent,
  }) {
    return RandomPasswordState(
      randomPasswordLength: randomPasswordLength ?? this.randomPasswordLength,
      randomPassword: randomPassword ?? this.randomPassword,
      randomPasswordStrength:
          randomPasswordStrength ?? this.randomPasswordStrength,
      hasSpanishCharacters: hasSpanishCharacters ?? this.hasSpanishCharacters,
      hasNumbersCharacters: hasNumbersCharacters ?? this.hasNumbersCharacters,
      hasSymbolsCharacters: hasSymbolsCharacters ?? this.hasSymbolsCharacters,
      copySnackBarEvent: copySnackBarEvent ?? this.copySnackBarEvent,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

final class RandomPasswordState extends Equatable {
  const RandomPasswordState({
    required this.randomPasswordLength,
    required this.randomPassword,
    required this.hasSpanishCharacters,
    required this.hasNumbersCharacters,
    required this.hasSymbolsCharacters,
    required this.copySnackBarEvent,
  });

  factory RandomPasswordState.initial() => const RandomPasswordState(
    randomPasswordLength: 10,
    randomPassword: '',
    hasSpanishCharacters: true,
    hasNumbersCharacters: true,
    hasSymbolsCharacters: true,
    copySnackBarEvent: UIEvent(consumed: true),
  );

  final int randomPasswordLength;
  final String randomPassword;
  final bool hasSpanishCharacters;
  final bool hasNumbersCharacters;
  final bool hasSymbolsCharacters;
  final UIEvent<void> copySnackBarEvent;

  @override
  List<Object?> get props => [
    randomPasswordLength,
    randomPassword,
    hasSpanishCharacters,
    hasNumbersCharacters,
    hasSymbolsCharacters,
    copySnackBarEvent,
  ];

  RandomPasswordState copyWith({
    int? randomPasswordLength,
    String? randomPassword,
    bool? hasSpanishCharacters,
    bool? hasNumbersCharacters,
    bool? hasSymbolsCharacters,
    UIEvent<void>? copySnackBarEvent,
  }) {
    return RandomPasswordState(
      randomPasswordLength: randomPasswordLength ?? this.randomPasswordLength,
      randomPassword: randomPassword ?? this.randomPassword,
      hasSpanishCharacters: hasSpanishCharacters ?? this.hasSpanishCharacters,
      hasNumbersCharacters: hasNumbersCharacters ?? this.hasNumbersCharacters,
      hasSymbolsCharacters: hasSymbolsCharacters ?? this.hasSymbolsCharacters,
      copySnackBarEvent: copySnackBarEvent ?? this.copySnackBarEvent,
    );
  }
}

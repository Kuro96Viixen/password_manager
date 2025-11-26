import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

part 'random_password_state.freezed.dart';

@freezed
sealed class RandomPasswordState with _$RandomPasswordState {
  const factory RandomPasswordState({
    required int randomPasswordLength,
    required String randomPassword,
    required bool hasSpanishCharacters,
    required bool hasNumbersCharacters,
    required bool hasSymbolsCharacters,
    required UIEvent<void> copySnackBarEvent,
  }) = _RandomPasswordState;

  factory RandomPasswordState.initial() => const RandomPasswordState(
    randomPasswordLength: 10,
    randomPassword: '',
    hasSpanishCharacters: true,
    hasNumbersCharacters: true,
    hasSymbolsCharacters: true,
    copySnackBarEvent: UIEvent(consumed: true),
  );
}

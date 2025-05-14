import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_password_state.freezed.dart';

@freezed
class RandomPasswordState with _$RandomPasswordState {
  const factory RandomPasswordState({
    required int randomPasswordLength,
    required String randomPassword,
    required bool hasSpanishCharacters,
    required bool hasNumbersCharacters,
    required bool hasSymbolsCharacters,
    RandomPasswordNavigationState? navigationState,
  }) = _RandomPasswordState;

  factory RandomPasswordState.initial() => const RandomPasswordState(
        randomPasswordLength: 10,
        randomPassword: '',
        hasSpanishCharacters: true,
        hasNumbersCharacters: true,
        hasSymbolsCharacters: true,
      );
}

@freezed
class RandomPasswordNavigationState with _$RandomPasswordNavigationState {
  const factory RandomPasswordNavigationState.showSnackBar(
    String snackBarMessage,
  ) = _ShowSnackBar;
}

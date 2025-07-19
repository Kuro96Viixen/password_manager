import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

part 'modify_state.freezed.dart';

@freezed
sealed class ModifyState with _$ModifyState {
  const factory ModifyState({
    required String name,
    required String username,
    required String password,
    required bool isPasswordHidden,
    required int randomPasswordLength,
    required String randomPassword,
    required String passwordIV,
    required bool hasSpanishCharacters,
    required bool hasNumbersCharacters,
    required bool hasSymbolsCharacters,
    required ModifyScreenState screenState,
    required bool isPrivateAccount,
    required bool canBeSaved,
    required UIEvent<void> goBackEvent,
    required UIEvent<String> snackBarEvent,
  }) = _ModifyState;

  factory ModifyState.initial() => const ModifyState(
        name: '',
        username: '',
        password: '',
        isPasswordHidden: false,
        randomPasswordLength: 10,
        randomPassword: '',
        passwordIV: '',
        hasSpanishCharacters: true,
        hasNumbersCharacters: true,
        hasSymbolsCharacters: true,
        screenState: ModifyScreenState.passwordForm(),
        isPrivateAccount: false,
        canBeSaved: false,
        goBackEvent: UIEvent(consumed: true),
        snackBarEvent: UIEvent(consumed: true),
      );
}

@freezed
sealed class ModifyScreenState with _$ModifyScreenState {
  const factory ModifyScreenState.passwordForm() = PasswordForm;

  const factory ModifyScreenState.randomForm() = RandomForm;
}

part of 'modify_bloc.dart';

@freezed
class ModifyState with _$ModifyState {
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
    ModifyNavigationState? navigationState,
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
      );
}

@freezed
class ModifyScreenState with _$ModifyScreenState {
  const factory ModifyScreenState.passwordForm() = _PasswordForm;

  const factory ModifyScreenState.randomForm() = _RandomForm;
}

@freezed
class ModifyNavigationState with _$ModifyNavigationState {
  const factory ModifyNavigationState.goBack() = _GoBack;

  const factory ModifyNavigationState.showSnackBar(String snackBarMessage) =
      _ShowSnackBar;
}

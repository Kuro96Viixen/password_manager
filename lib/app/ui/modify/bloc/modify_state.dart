import 'package:equatable/equatable.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

final class ModifyState extends Equatable {
  const ModifyState({
    required this.name,
    required this.username,
    required this.password,
    required this.isPasswordHidden,
    required this.randomPasswordLength,
    required this.randomPassword,
    required this.passwordIV,
    required this.hasSpanishCharacters,
    required this.hasNumbersCharacters,
    required this.hasSymbolsCharacters,
    required this.screenState,
    required this.isPrivateAccount,
    required this.canBeSaved,
    required this.goBackEvent,
    required this.copySnackBarEvent,
  });

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
    screenState: PasswordForm(),
    isPrivateAccount: false,
    canBeSaved: false,
    goBackEvent: UIEvent(consumed: true),
    copySnackBarEvent: UIEvent(consumed: true),
  );

  final String name;
  final String username;
  final String password;
  final bool isPasswordHidden;
  final int randomPasswordLength;
  final String randomPassword;
  final String passwordIV;
  final bool hasSpanishCharacters;
  final bool hasNumbersCharacters;
  final bool hasSymbolsCharacters;
  final ModifyScreenState screenState;
  final bool isPrivateAccount;
  final bool canBeSaved;
  final UIEvent<void> goBackEvent;
  final UIEvent<void> copySnackBarEvent;

  @override
  List<Object?> get props => [
    name,
    username,
    password,
    isPasswordHidden,
    randomPasswordLength,
    randomPassword,
    passwordIV,
    hasSpanishCharacters,
    hasNumbersCharacters,
    hasSymbolsCharacters,
    screenState,
    isPrivateAccount,
    canBeSaved,
    goBackEvent,
    copySnackBarEvent,
  ];

  ModifyState copyWith({
    String? name,
    String? username,
    String? password,
    bool? isPasswordHidden,
    int? randomPasswordLength,
    String? randomPassword,
    String? passwordIV,
    bool? hasSpanishCharacters,
    bool? hasNumbersCharacters,
    bool? hasSymbolsCharacters,
    ModifyScreenState? screenState,
    bool? isPrivateAccount,
    bool? canBeSaved,
    UIEvent<void>? goBackEvent,
    UIEvent<void>? copySnackBarEvent,
  }) {
    return ModifyState(
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      randomPasswordLength: randomPasswordLength ?? this.randomPasswordLength,
      randomPassword: randomPassword ?? this.randomPassword,
      passwordIV: passwordIV ?? this.passwordIV,
      hasSpanishCharacters: hasSpanishCharacters ?? this.hasSpanishCharacters,
      hasNumbersCharacters: hasNumbersCharacters ?? this.hasNumbersCharacters,
      hasSymbolsCharacters: hasSymbolsCharacters ?? this.hasSymbolsCharacters,
      screenState: screenState ?? this.screenState,
      isPrivateAccount: isPrivateAccount ?? this.isPrivateAccount,
      canBeSaved: canBeSaved ?? this.canBeSaved,
      goBackEvent: goBackEvent ?? this.goBackEvent,
      copySnackBarEvent: copySnackBarEvent ?? this.copySnackBarEvent,
    );
  }
}

sealed class ModifyScreenState extends Equatable {
  const ModifyScreenState();

  @override
  List<Object?> get props => [];
}

final class PasswordForm extends ModifyScreenState {
  const PasswordForm();
}

final class RandomForm extends ModifyScreenState {
  const RandomForm();
}

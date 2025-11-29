import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/use_cases/encrypt_password_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/app/domain/use_cases/set_accounts_data_on_storage_use_case.dart';
import 'package:password_manager/app/domain/use_cases/set_accounts_data_use_case.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_event.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_state.dart';
import 'package:password_manager/utils/utils.dart';

class ModifyBloc extends Bloc<ModifyEvent, ModifyState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;
  final SetAccountsDataUseCase setAccountsDataUseCase;
  final SetAccountsDataOnStorageUseCase setAccountsDataOnStorageUseCase;
  final EncryptPasswordUseCase encryptPasswordUseCase;

  ModifyBloc({
    required this.getAccountsDataUseCase,
    required this.setAccountsDataUseCase,
    required this.setAccountsDataOnStorageUseCase,
    required this.encryptPasswordUseCase,
  }) : super(ModifyState.initial()) {
    on<ModifyStarted>(_onStarted);
    on<OnNameChanged>(_onOnNameChanged);
    on<OnUsernameChanged>(_onOnUsernameChanged);
    on<OnChangePasswordForm>(_onOnChangePasswordForm);
    on<OnPasswordChanged>(_onOnPasswordChanged);
    on<HidePassword>(_onHidePassword);
    on<OnRandomPasswordLengthChanged>(_onOnRandomPasswordLengthChanged);
    on<HasSpanishCharacters>(_onHasSpanishCharacters);
    on<HasNumbersCharacters>(_onHasNumbersCharacters);
    on<HasSymbolsCharacters>(_onHasSymbolsCharacters);
    on<GenerateRandomPassword>(_onGenerateRandomPassword);
    on<CopyPassword>(_onCopyPassword);
    on<SetIsPrivateAccount>(_onSetIsPrivateAccount);
    on<SaveAccount>(_onSaveAccount);
    on<MarkCopySnackBarAsConsumed>(_onMarkCopySnackBarAsConsumed);
  }

  void _onStarted(
    ModifyStarted event,
    Emitter<ModifyState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.accountData?.name ?? '',
        username: event.accountData?.username ?? '',
        passwordIV: event.accountData?.passwordIV ?? '',
        isPrivateAccount: event.accountData?.private ?? false,
        canBeSaved: false,
      ),
    );
  }

  void _onOnNameChanged(
    OnNameChanged event,
    Emitter<ModifyState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.nameString,
        canBeSaved: _accountCanBeSaved(
          state.copyWith(name: event.nameString),
        ),
      ),
    );
  }

  void _onOnUsernameChanged(
    OnUsernameChanged event,
    Emitter<ModifyState> emit,
  ) {
    emit(
      state.copyWith(
        username: event.usernameString,
        canBeSaved: _accountCanBeSaved(
          state.copyWith(username: event.usernameString),
        ),
      ),
    );
  }

  void _onOnChangePasswordForm(
    OnChangePasswordForm event,
    Emitter<ModifyState> emit,
  ) {
    emit(
      state.copyWith(
        password: '',
        randomPassword: '',
        randomPasswordLength: 10,
        canBeSaved: false,
        isPasswordHidden: false,
        screenState: event.isRandomPasswordForm
            ? const RandomForm()
            : const PasswordForm(),
      ),
    );
  }

  void _onOnPasswordChanged(
    OnPasswordChanged event,
    Emitter<ModifyState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.passwordString,
        canBeSaved: _accountCanBeSaved(
          state.copyWith(password: event.passwordString),
        ),
      ),
    );
  }

  void _onHidePassword(
    HidePassword event,
    Emitter<ModifyState> emit,
  ) {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  void _onOnRandomPasswordLengthChanged(
    OnRandomPasswordLengthChanged event,
    Emitter<ModifyState> emit,
  ) {
    emit(
      state.copyWith(
        randomPasswordLength:
            int.tryParse(event.randomPasswordLengthString) ?? 10,
      ),
    );
  }

  void _onHasSpanishCharacters(
    HasSpanishCharacters event,
    Emitter<ModifyState> emit,
  ) {
    emit(state.copyWith(hasSpanishCharacters: event.hasSpanishCharacters));
  }

  void _onHasNumbersCharacters(
    HasNumbersCharacters event,
    Emitter<ModifyState> emit,
  ) {
    emit(state.copyWith(hasNumbersCharacters: event.hasNumbersCharacters));
  }

  void _onHasSymbolsCharacters(
    HasSymbolsCharacters event,
    Emitter<ModifyState> emit,
  ) {
    emit(state.copyWith(hasSymbolsCharacters: event.hasSymbolsCharacters));
  }

  void _onGenerateRandomPassword(
    GenerateRandomPassword event,
    Emitter<ModifyState> emit,
  ) {
    final randomPassword = Utils.generateRandomPassword(
      length: state.randomPasswordLength,
      hasSpanishCharacters: state.hasSpanishCharacters,
      hasNumbersCharacters: state.hasNumbersCharacters,
      hasSymbolsCharacters: state.hasSymbolsCharacters,
    );

    emit(
      state.copyWith(
        randomPassword: randomPassword,
        canBeSaved: _accountCanBeSaved(
          state.copyWith(randomPassword: randomPassword),
        ),
      ),
    );
  }

  Future<void> _onCopyPassword(
    CopyPassword event,
    Emitter<ModifyState> emit,
  ) async {
    await Clipboard.setData(ClipboardData(text: state.randomPassword));

    emit(
      state.copyWith(
        copySnackBarEvent: const UIEvent(),
      ),
    );
  }

  void _onSetIsPrivateAccount(
    SetIsPrivateAccount event,
    Emitter<ModifyState> emit,
  ) {
    emit(state.copyWith(isPrivateAccount: event.isPrivateAccount));
  }

  Future<void> _onSaveAccount(
    SaveAccount event,
    Emitter<ModifyState> emit,
  ) async {
    final accountsData = await getAccountsDataUseCase();

    final accountsList = accountsData.accountsList.toList();

    final encryptedPassword = await encryptPasswordUseCase(
      state.password != '' ? state.password : state.randomPassword,
    );

    final accountToSave = AccountData(
      name: state.name,
      username: state.username,
      password: encryptedPassword.password,
      passwordIV: encryptedPassword.iv,
      private: state.isPrivateAccount,
    );

    if (event.accountData != null) {
      // Get index to update
      final index = accountsData.accountsList.indexOf(event.accountData!);

      // Update account with form data
      accountsList[index] = accountToSave;
    } else {
      // Append new data at the end
      accountsList.add(accountToSave);
    }

    await setAccountsDataUseCase(
      accountsData.copyWith(accountsList: accountsList),
    );

    await setAccountsDataOnStorageUseCase(
      accountsData.copyWith(accountsList: accountsList).toStore(),
    );

    emit(
      state.copyWith(
        goBackEvent: const UIEvent(),
      ),
    );
  }

  void _onMarkCopySnackBarAsConsumed(
    MarkCopySnackBarAsConsumed event,
    Emitter<ModifyState> emit,
  ) {
    emit(
      state.copyWith(
        copySnackBarEvent: state.copySnackBarEvent.asConsumed(),
      ),
    );
  }

  bool _accountCanBeSaved(ModifyState state) {
    return state.name != '' &&
        state.username != '' &&
        (state.randomPassword != '' || state.password != '');
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
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
    on<ModifyEvent>((event, emit) async {
      switch (event) {
        case Started(accountData: final accountData):
          emit(
            state.copyWith(
              name: accountData?.name ?? '',
              username: accountData?.username ?? '',
              passwordIV: accountData?.passwordIV ?? '',
              isPrivateAccount: accountData?.private ?? false,
              canBeSaved: false,
            ),
          );
        case OnNameChanged(nameString: final name):
          emit(
            state.copyWith(
              name: name,
              canBeSaved: _accountCanBeSaved(
                state.copyWith(name: name),
              ),
            ),
          );
        case OnUsernameChanged(usernameString: final username):
          emit(
            state.copyWith(
              username: username,
              canBeSaved: _accountCanBeSaved(
                state.copyWith(username: username),
              ),
            ),
          );
        case OnChangePasswordForm(
          isRandomPasswordForm: final isRandomPasswordForm,
        ):
          emit(
            state.copyWith(
              password: '',
              randomPassword: '',
              randomPasswordLength: 10,
              canBeSaved: false,
              isPasswordHidden: false,
              screenState: isRandomPasswordForm
                  ? const ModifyScreenState.randomForm()
                  : const ModifyScreenState.passwordForm(),
            ),
          );
        case OnPasswordChanged(passwordString: final password):
          emit(
            state.copyWith(
              password: password,
              canBeSaved: _accountCanBeSaved(
                state.copyWith(password: password),
              ),
            ),
          );
        case HidePassword():
          emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
        case OnRandomPasswordLengthChanged(
          randomPasswordLengthString: final randomPasswordLength,
        ):
          emit(
            state.copyWith(
              randomPasswordLength: int.tryParse(randomPasswordLength) ?? 10,
            ),
          );
        case HasSpanishCharacters(
          hasSpanishCharacters: final hasSpanishCharacters,
        ):
          emit(state.copyWith(hasSpanishCharacters: hasSpanishCharacters));
        case HasNumbersCharacters(
          hasNumbersCharacters: final hasNumbersCharacters,
        ):
          emit(state.copyWith(hasNumbersCharacters: hasNumbersCharacters));
        case HasSymbolsCharacters(
          hasSymbolsCharacters: final hasSymbolsCharacters,
        ):
          emit(state.copyWith(hasSymbolsCharacters: hasSymbolsCharacters));
        case GenerateRandomPassword():
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
        case CopyPassword(password: final password):
          await Clipboard.setData(ClipboardData(text: password));

          emit(
            state.copyWith(
              snackBarEvent: UIEvent(data: Texts.copiedToClipboard),
            ),
          );
        case SetIsPrivateAccount(isPrivateAccount: final isPrivateAccount):
          emit(state.copyWith(isPrivateAccount: isPrivateAccount));
        case SaveAccount(accountData: final accountData):
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

          if (accountData != null) {
            // Get index to update
            final index = accountsData.accountsList.indexOf(accountData);

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
        case MarkSnackBarAsConsumed():
          emit(state.copyWith(snackBarEvent: state.snackBarEvent.asConsumed()));
      }
    });
  }

  bool _accountCanBeSaved(ModifyState state) {
    return state.name != '' &&
        state.username != '' &&
        (state.randomPassword != '' || state.password != '');
  }
}

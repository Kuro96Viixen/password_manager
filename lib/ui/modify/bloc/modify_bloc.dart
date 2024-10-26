import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_on_storage_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_use_case.dart';
import 'package:password_manager/utils/utils.dart';

part 'modify_bloc.freezed.dart';
part 'modify_event.dart';
part 'modify_state.dart';

class ModifyBloc extends Bloc<ModifyEvent, ModifyState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;
  final SetAccountsDataUseCase setAccountsDataUseCase;
  final SetAccountsDataOnStorageUseCase setAccountsDataOnStorageUseCase;

  ModifyBloc({
    required this.getAccountsDataUseCase,
    required this.setAccountsDataUseCase,
    required this.setAccountsDataOnStorageUseCase,
  }) : super(ModifyState.initial()) {
    on<ModifyEvent>((event, emit) {
      event.when(
        started: (accountData) {
          if (accountData != null) {
            emit(
              state.copyWith(
                name: accountData.name,
                username: accountData.username,
                isPrivateAccount: accountData.private,
                canBeSaved: false,
              ),
            );
          } else {
            emit(state.copyWith(canBeSaved: false));
          }
        },
        backPressed: (backToList) {
          emit(
            state.copyWith(
              navigationState: ModifyNavigationState.goBack(backToList),
            ),
          );
        },
        onNameChanged: (nameString) {
          emit(
            state.copyWith(
              name: nameString,
              canBeSaved: accountCanBeSaved(
                state.copyWith(name: nameString),
              ),
            ),
          );
        },
        onUsernameChanged: (usernameString) {
          emit(
            state.copyWith(
              username: usernameString,
              canBeSaved: accountCanBeSaved(
                state.copyWith(username: usernameString),
              ),
            ),
          );
        },
        onChangePasswordForm: (isRandomPasswordForm) {
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
        },
        onPasswordChanged: (passwordString) {
          emit(
            state.copyWith(
              password: passwordString,
              canBeSaved: accountCanBeSaved(
                state.copyWith(password: passwordString),
              ),
            ),
          );
        },
        hidePassword: () {
          emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
        },
        onRandomPasswordLengthChanged: (randomPasswordLength) {
          emit(
            state.copyWith(
              randomPasswordLength: int.tryParse(randomPasswordLength) ?? 10,
            ),
          );
        },
        hasSpanishCharacters: (hasSpanishCharacters) {
          emit(state.copyWith(hasSpanishCharacters: hasSpanishCharacters));
        },
        hasNumbersCharacters: (hasNumbersCharacters) {
          emit(state.copyWith(hasNumbersCharacters: hasNumbersCharacters));
        },
        hasSymbolsCharacters: (hasSymbolsCharacters) {
          emit(state.copyWith(hasSymbolsCharacters: hasSymbolsCharacters));
        },
        generateRandomPassword: () {
          final randomPassword = Utils.generateRandomPassword(
            length: state.randomPasswordLength,
            hasSpanishCharacters: state.hasSpanishCharacters,
            hasNumbersCharacters: state.hasNumbersCharacters,
            hasSymbolsCharacters: state.hasSymbolsCharacters,
          );

          emit(
            state.copyWith(
              randomPassword: randomPassword,
              canBeSaved: accountCanBeSaved(
                state.copyWith(randomPassword: randomPassword),
              ),
            ),
          );
        },
        copyPassword: (password) {
          Clipboard.setData(ClipboardData(text: password));

          emit(
            state.copyWith(
              navigationState:
                  ModifyNavigationState.showSnackBar(Texts.copiedToClipboard),
            ),
          );

          emit(state.copyWith(navigationState: null));
        },
        setIsPrivateAccount: (isPrivateAccount) {
          emit(state.copyWith(isPrivateAccount: isPrivateAccount));
        },
        saveAccount: (accountData) async {
          final accountsDataResult = await getAccountsDataUseCase();

          List<AccountData> accountsList = [];

          accountsDataResult.when(
            failure: (error, message) {},
            success: (accountsData) {
              accountsList = accountsData.accountsList.toList();

              // TODO missing encrypt password at set
              // Encryption.encryptPassword(password);
              if (accountData != null) {
                // Get index to update
                final index = accountsData.accountsList.indexOf(accountData);

                // Update account with form data
                accountsList[index] = AccountData(
                  name: state.name,
                  username: state.username,
                  password: state.password != ''
                      ? state.password
                      : state.randomPassword,
                  private: state.isPrivateAccount,
                );
              } else {
                // Append new data at the end
                accountsList.add(
                  AccountData(
                    name: state.name,
                    username: state.username,
                    password: state.password != ''
                        ? state.password
                        : state.randomPassword,
                    private: state.isPrivateAccount,
                  ),
                );
              }

              setAccountsDataUseCase(
                accountsData.copyWith(accountsList: accountsList),
              );

              setAccountsDataOnStorageUseCase(
                accountsData.copyWith(accountsList: accountsList).toStore(),
              );

              emit(
                state.copyWith(
                  navigationState: const ModifyNavigationState.goBack(true),
                ),
              );
            },
          );
        },
      );
    });
  }

  bool accountCanBeSaved(ModifyState state) {
    return state.name != '' &&
        state.username != '' &&
        (state.randomPassword != '' || state.password != '');
  }
}

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/model/error_type.dart';
import 'package:password_manager/app/domain/use_cases/export_accounts_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_from_storage_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_authentication_use_case.dart';
import 'package:password_manager/app/domain/use_cases/import_accounts_use_case.dart';
import 'package:password_manager/app/domain/use_cases/initialize_encryption_use_case.dart';
import 'package:password_manager/app/domain/use_cases/set_accounts_data_on_storage_use_case.dart';
import 'package:password_manager/app/domain/use_cases/set_accounts_data_use_case.dart';
import 'package:password_manager/app/ui/accounts/bloc/accounts_event.dart';
import 'package:password_manager/app/ui/accounts/bloc/accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;
  final SetAccountsDataUseCase setAccountsDataUseCase;
  final GetAccountsDataFromStorageUseCase getAccountsDataFromStorageUseCase;
  final SetAccountsDataOnStorageUseCase setAccountsDataOnStorageUseCase;
  final GetAuthenticationUseCase getAuthenticationUseCase;
  final ExportAccountsUseCase exportAccountsUseCase;
  final ImportAccountsUseCase importAccountsUseCase;
  final InitializeEncryptionUseCase initializeEncryptionUseCase;

  AccountsBloc({
    required this.getAccountsDataUseCase,
    required this.setAccountsDataUseCase,
    required this.getAccountsDataFromStorageUseCase,
    required this.setAccountsDataOnStorageUseCase,
    required this.getAuthenticationUseCase,
    required this.exportAccountsUseCase,
    required this.importAccountsUseCase,
    required this.initializeEncryptionUseCase,
  }) : super(AccountsState.initial()) {
    on<AccountsEvent>((event, emit) async {
      await event.when(
        started: (encryptionKey) async {
          final oldScreenState = state.screenState;
          // Emitting Loading ScreenState before while loading Accounts
          emit(
            state.copyWith(
              screenState: const AccountsScreenState.loading(),
              navigationState: null,
            ),
          );

          if (encryptionKey != '') {
            await initializeEncryptionUseCase(encryptionKey);
          }

          // Retrieving data from the MemoryDataSource
          final accountsData = await getAccountsDataUseCase();

          var accountsList = <AccountData>[];

          // If the MemoryDataSource Accounts are empty read from Storage
          // If not, fill the list above with them
          if (accountsData.accountsList.isEmpty) {
            // Looking if there are Accounts in the SecureStorage
            final storedAccountsData =
                await getAccountsDataFromStorageUseCase();

            // If there are, formatting into list from JSON and
            // setting them into the MemoryDataSource
            if (storedAccountsData != null) {
              final accountsJson =
                  jsonDecode(storedAccountsData) as List<dynamic>;

              accountsList = List<AccountData>.from(
                accountsJson
                    .map(
                      (e) => AccountData.empty()
                          .fromJson(e as Map<String, dynamic>),
                    )
                    .toList(),
              )

                // Shuffle to not showing up the same accounts at the top
                ..shuffle();

              await setAccountsDataUseCase(
                accountsData.copyWith(accountsList: accountsList),
              );
            }
          } else {
            accountsList = accountsData.accountsList;
          }

          final accountsToShow = List<AccountData>.from(accountsList)
            ..removeWhere((account) => account.private);

          // Sending the accounts to the screen and
          // remove the loader from the screen
          emit(
            state.copyWith(
              accountsList: accountsToShow,
              screenState: oldScreenState == const AccountsScreenState.loading()
                  ? const AccountsScreenState.loaded(searchText: '')
                  : oldScreenState,
            ),
          );
        },
        pressedAccount: (accountIndex) async {
          final accountsData = await getAccountsDataUseCase();

          final index = accountsData.accountsList
              .indexOf(state.accountsList[accountIndex]);

          // Resetting navigationState
          emit(state.copyWith(navigationState: null));

          emit(
            state.copyWith(
              navigationState: AccountsNavigationState.goToDetails(
                accountData: accountsData.accountsList[index],
              ),
            ),
          );
        },
        pressedModify: () {
          // Resetting navigationState
          emit(state.copyWith(navigationState: null));

          emit(
            state.copyWith(
              navigationState: const AccountsNavigationState.goToModify(),
            ),
          );
        },
        showPrivate: () async {
          // Resetting navigationState
          emit(state.copyWith(navigationState: null));

          if (await getAuthenticationUseCase()) {
            emit(
              state.copyWith(
                screenState: const AccountsScreenState.loaded(searchText: ''),
                navigationState: const AccountsNavigationState.goToPrivate(),
              ),
            );
          }
        },
        searchAccount: (String searchString) {
          emit(
            state.copyWith(
              screenState: AccountsScreenState.loaded(searchText: searchString),
              navigationState: null,
            ),
          );
        },
        onRandomPasswordPressed: () {
          emit(
            state.copyWith(
              navigationState:
                  const AccountsNavigationState.goToGeneratePassword(),
            ),
          );
        },
        showSettings: () {
          // Resetting navigationState
          emit(state.copyWith(navigationState: null));

          emit(
            state.copyWith(
              navigationState: const AccountsNavigationState.showBottomMenu(),
            ),
          );
        },
        exportAccounts: () async {
          final accountsData = await getAccountsDataUseCase();

          final exportAccountsResult =
              await exportAccountsUseCase(accountsData);

          // Resetting navigationState
          emit(
            state.copyWith(
              screenState: const AccountsScreenState.loading(),
              navigationState: null,
            ),
          );

          exportAccountsResult.when(
            failure: (message) {
              emit(
                state.copyWith(
                  navigationState: const AccountsNavigationState.showDialog(
                    ErrorType.pickFolderException(),
                  ),
                ),
              );
            },
            success: (filePath) {
              // TODO(Kuro): Review this
              // This filePath returns different folder (tested on Android 11)

              emit(
                state.copyWith(
                  navigationState: AccountsNavigationState.showSnackBar(
                    snackBarMessage: Texts.exportedAccounts,
                  ),
                  screenState: const AccountsScreenState.loaded(searchText: ''),
                ),
              );
            },
          );
        },
        importAccounts: () async {
          final importAccountsResult = await importAccountsUseCase();

          // Resetting navigationState
          emit(state.copyWith(navigationState: null));
          importAccountsResult.when(
            failure: (message) {
              emit(
                state.copyWith(
                  navigationState: const AccountsNavigationState.showDialog(
                    ErrorType.pickFileException(),
                  ),
                ),
              );
            },
            success: (importedAccounts) {
              setAccountsDataUseCase(importedAccounts);

              setAccountsDataOnStorageUseCase(
                importedAccounts.toStore(),
              );

              emit(
                state.copyWith(
                  navigationState: AccountsNavigationState.showSnackBar(
                    snackBarMessage: Texts.importedAccounts,
                  ),
                ),
              );

              add(const AccountsEvent.started(''));
            },
          );
        },
      );
    });
  }
}

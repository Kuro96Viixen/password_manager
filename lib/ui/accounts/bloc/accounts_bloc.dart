import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/use_cases/export_accounts_use_case.dart';
import 'package:password_manager/domain/use_cases/get_accounts_data_from_storage_use_case.dart';
import 'package:password_manager/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/domain/use_cases/get_authentication_use_case.dart';
import 'package:password_manager/domain/use_cases/import_accounts_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_on_storage_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_use_case.dart';

part 'accounts_bloc.freezed.dart';
part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;
  final SetAccountsDataUseCase setAccountsDataUseCase;
  final GetAccountsDataFromStorageUseCase getAccountsDataFromStorageUseCase;
  final SetAccountsDataOnStorageUseCase setAccountsDataOnStorageUseCase;
  final GetAuthenticationUseCase getAuthenticationUseCase;
  final ExportAccountsUseCase exportAccountsUseCase;
  final ImportAccountsUseCase importAccountsUseCase;

  AccountsBloc({
    required this.getAccountsDataUseCase,
    required this.setAccountsDataUseCase,
    required this.getAccountsDataFromStorageUseCase,
    required this.setAccountsDataOnStorageUseCase,
    required this.getAuthenticationUseCase,
    required this.exportAccountsUseCase,
    required this.importAccountsUseCase,
  }) : super(AccountsState.initial()) {
    on<AccountsEvent>((event, emit) async {
      await event.when(
        started: () async {
          // Emitting Loading ScreenState before while loading Accounts
          emit(
            state.copyWith(
              screenState: const AccountsScreenState.loading(),
              navigationState: null,
            ),
          );

          // Retrieving data from the MemoryDataSource
          final accountsDataResult = await getAccountsDataUseCase();

          // Looking if there are Accounts in the SecureStorage
          String? storedAccountsData =
              await getAccountsDataFromStorageUseCase();

          accountsDataResult.when(
            // If failure
            failure: (message) => null,
            // If success
            success: (data) {
              List<AccountData> accountsList = [];

              // If the MemoryDataSource Accounts are empty read from Storage
              // If not, fill the list above with them
              if (data.accountsList.isEmpty) {
                // If there are, formatting into list from JSON and
                // setting them into the MemoryDataSource
                if (storedAccountsData != null) {
                  final accountsJson = jsonDecode(storedAccountsData);

                  accountsList = List<AccountData>.from(
                    accountsJson
                        .map((e) => AccountData.empty().fromJson(e))
                        .toList(),
                  );

                  // Shuffle to not showing up the same accounts at the top
                  accountsList.shuffle();

                  setAccountsDataUseCase(
                    data.copyWith(accountsList: accountsList),
                  );
                }
              } else {
                accountsList = data.accountsList;
              }

              // Sending the accounts to the screen and
              // remove the loader from the screen
              emit(
                state.copyWith(
                  accountsList: accountsList,
                  screenState: const AccountsScreenState.loaded(searchText: ''),
                ),
              );
            },
          );
        },
        pressedAccount: (accountIndex) async {
          final accountDataResult = await getAccountsDataUseCase();

          accountDataResult.when(
            failure: (message) => null,
            success: (accountsData) {
              emit(
                state.copyWith(
                  navigationState: AccountsNavigationState.goToDetails(
                    accountData: accountsData.accountsList[accountIndex],
                  ),
                ),
              );
            },
          );
        },
        pressedModify: () {
          emit(
            state.copyWith(
              navigationState: const AccountsNavigationState.goToModify(),
            ),
          );
        },
        showPrivate: () async {
          if (await getAuthenticationUseCase()) {
            emit(
              state.copyWith(
                arePrivateAccounts: true,
                screenState: const AccountsScreenState.loaded(searchText: ''),
                navigationState: null,
              ),
            );
          }
        },
        closePrivate: () {
          emit(
            state.copyWith(
              arePrivateAccounts: false,
              screenState: const AccountsScreenState.loaded(searchText: ''),
              navigationState: null,
            ),
          );
        },
        searchAccount: (String searchString) {
          emit(
            state.copyWith(
              screenState: AccountsScreenState.loaded(searchText: searchString),
              navigationState: null,
            ),
          );
        },
        showSettings: () {
          // Resetting navigationState
          emit(
            state.copyWith(
              navigationState: null,
            ),
          );

          emit(
            state.copyWith(
              navigationState: const AccountsNavigationState.showBottomMenu(),
            ),
          );
        },
        exportAccounts: () async {
          final getAccountsDataResult = await getAccountsDataUseCase();

          getAccountsDataResult.when(
            failure: (message) => null,
            success: (accountsData) async {
              add(AccountsEvent.exportedAccounts(accountsData));
            },
          );
        },
        exportedAccounts: (accountsData) async {
          final exportAccountsResult =
              await exportAccountsUseCase(accountsData);

          exportAccountsResult.when(
            failure: (message) {
              // TODO Check
              // Duplicate
              // Folder gone
              // No Permissions
              print(message);
            },
            success: (filePath) {
              // TODO: This filePath returns different folder
              // Resetting navigationState
              emit(
                state.copyWith(
                  navigationState: null,
                ),
              );

              emit(
                state.copyWith(
                  navigationState: AccountsNavigationState.showSnackBar(
                    snackBarMessage: Texts.exportedAccounts,
                  ),
                ),
              );
            },
          );
        },
        importAccounts: () async {
          final importAccountsResult = await importAccountsUseCase();

          importAccountsResult.when(
            failure: (message) {
              // TODO:
              /// No File or folder:
              /// ErrorStatus.unknown()
              /// PathNotFoundException: Cannot open file, path = '/storage/emulated/0/Documents/accounts.csv' (OS Error: No such file or directory, errno = 2)
            },
            success: (importedAccounts) {
              setAccountsDataUseCase(importedAccounts);

              setAccountsDataOnStorageUseCase(
                importedAccounts.toStore(),
              );

              // Resetting navigationState
              emit(
                state.copyWith(
                  navigationState: null,
                ),
              );

              emit(
                state.copyWith(
                  navigationState: AccountsNavigationState.showSnackBar(
                    snackBarMessage: Texts.importedAccounts,
                  ),
                ),
              );

              add(const AccountsEvent.started());
            },
          );
        },
      );
    });
  }
}

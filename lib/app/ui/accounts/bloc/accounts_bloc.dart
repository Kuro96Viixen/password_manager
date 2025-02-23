import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

          List<AccountData> accountsList = [];

          // If the MemoryDataSource Accounts are empty read from Storage
          // If not, fill the list above with them
          if (accountsData.accountsList.isEmpty) {
            // Looking if there are Accounts in the SecureStorage
            String? storedAccountsData =
                await getAccountsDataFromStorageUseCase();

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
                accountsData.copyWith(accountsList: accountsList),
              );
            }
          } else {
            accountsList = accountsData.accountsList;
          }

          // Sending the accounts to the screen and
          // remove the loader from the screen
          emit(
            state.copyWith(
              accountsList: accountsList,
              screenState: oldScreenState == AccountsScreenState.loading()
                  ? AccountsScreenState.loaded(searchText: '')
                  : oldScreenState,
            ),
          );
        },
        pressedAccount: (accountIndex) async {
          final accountsData = await getAccountsDataUseCase();

          // Resetting navigationState
          emit(state.copyWith(navigationState: null));

          emit(
            state.copyWith(
              navigationState: AccountsNavigationState.goToDetails(
                accountData: accountsData.accountsList[accountIndex],
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
        // TODO(Kuro): Uncomment this when GP deployed
        // showSettings: () {
        //   // Resetting navigationState
        //   emit(state.copyWith(navigationState: null));
        //
        //   emit(
        //     state.copyWith(
        //       navigationState: const AccountsNavigationState.showBottomMenu(),
        //     ),
        //   );
        // },
        // exportAccounts: () async {
        //   final accountsData = await getAccountsDataUseCase();
        //
        //   final exportAccountsResult =
        //       await exportAccountsUseCase(accountsData);
        //
        //   // Resetting navigationState
        //   emit(
        //     state.copyWith(
        //       screenState: const AccountsScreenState.loading(),
        //       navigationState: null,
        //     ),
        //   );
        //
        //   exportAccountsResult.when(
        //     failure: (message) {
        //       emit(
        //         state.copyWith(
        //           navigationState: const AccountsNavigationState.showDialog(
        //             ErrorType.pickFolderException(),
        //           ),
        //         ),
        //       );
        //     },
        //     success: (filePath) {
        //       // TODO
        //       // This filePath returns different folder (tested on Android 11)
        //
        //       emit(
        //         state.copyWith(
        //           navigationState: AccountsNavigationState.showSnackBar(
        //             snackBarMessage: Texts.exportedAccounts,
        //           ),
        //         ),
        //       );
        //     },
        //   );
        // },
        // importAccounts: () async {
        //   final importAccountsResult = await importAccountsUseCase();
        //
        //   // Resetting navigationState
        //   emit(state.copyWith(navigationState: null));
        //   importAccountsResult.when(
        //     failure: (message) {
        //       emit(
        //         state.copyWith(
        //           navigationState: const AccountsNavigationState.showDialog(
        //             ErrorType.pickFileException(),
        //           ),
        //         ),
        //       );
        //     },
        //     success: (importedAccounts) {
        //       setAccountsDataUseCase(importedAccounts);
        //
        //       setAccountsDataOnStorageUseCase(
        //         importedAccounts.toStore(),
        //       );
        //
        //       emit(
        //         state.copyWith(
        //           navigationState: AccountsNavigationState.showSnackBar(
        //             snackBarMessage: Texts.importedAccounts,
        //           ),
        //         ),
        //       );
        //
        //       add(const AccountsEvent.started(''));
        //     },
        //   );
        // },
      );
    });
  }
}

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/use_cases/get_accounts_data_from_storage_use_case.dart';
import 'package:password_manager/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_use_case.dart';

part 'accounts_bloc.freezed.dart';
part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;
  final SetAccountsDataUseCase setAccountsDataUseCase;
  final GetAccountsDataFromStorageUseCase getAccountsDataFromStorageUseCase;

  AccountsBloc({
    required this.getAccountsDataUseCase,
    required this.setAccountsDataUseCase,
    required this.getAccountsDataFromStorageUseCase,
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
            failure: (error, message) {},
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
            failure: (error, message) {},
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
        showPrivate: () {
          // TODO
          // Utils.authenticate(
          //   Texts.fingerprintPrivateAuthTitle,
          // );

          emit(
            state.copyWith(
              arePrivateAccounts: true,
              screenState: const AccountsScreenState.loaded(searchText: ''),
              navigationState: null,
            ),
          );
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
        exportAccounts: () {
          // TODO
          // Utils.exportAccounts();

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
        importAccounts: () {
          // TODO
          // Utils.importAccounts();

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
        },
      );
      // TODO: implement event handler
    });
  }
}

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/model/error_type.dart';
import 'package:password_manager/app/domain/model/result.dart';
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
import 'package:password_manager/app/ui/bloc/ui_event.dart';
import 'package:password_manager/app/ui/details/details_view.dart';
import 'package:password_manager/app/ui/modify/modify_view.dart';
import 'package:password_manager/app/ui/private/private_view.dart';
import 'package:password_manager/app/ui/random_password/random_password_view.dart';

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
      switch (event) {
        case Started(initializeEncryption: final initializeEncryption):
          await _mapStartedEventToState(emit, initializeEncryption);
        case PressedAccount(accountIndex: final accountIndex):
          emit(
            state.copyWith(
              selectedAccount: state.accountsList[accountIndex],
              navigationEvent: const UIEvent(data: DetailsView.routeName),
            ),
          );
        case PressedModify():
          emit(
            state.copyWith(
              navigationEvent: const UIEvent(data: ModifyView.routeName),
            ),
          );
        case ShowPrivate():
          if (await getAuthenticationUseCase()) {
            emit(
              state.copyWith(
                screenState: const AccountsScreenState.loaded(searchText: ''),
                navigationEvent: const UIEvent(data: PrivateView.routeName),
              ),
            );
          }
        case SearchAccount(:final searchString):
          emit(
            state.copyWith(
              screenState: AccountsScreenState.loaded(searchText: searchString),
            ),
          );
        case OnRandomPasswordPressed():
          emit(
            state.copyWith(
              navigationEvent:
                  const UIEvent(data: RandomPasswordView.routeName),
            ),
          );
        case ShowSettings():
          emit(state.copyWith(bottomMenuEvent: const UIEvent()));
        case ExportAccounts():
          await _mapExportAccountsEventToState(emit);
        case ImportAccounts():
          await _mapImportAccountsEventToState(emit);

        case MarkNavigationEventAsConsumed():
          emit(
            state.copyWith(
              selectedAccount: null,
              navigationEvent: state.navigationEvent.asConsumed(),
            ),
          );
        case MarkBottomMenuAsConsumed():
          emit(
            state.copyWith(bottomMenuEvent: state.bottomMenuEvent.asConsumed()),
          );
        case MarkSnackBarAsConsumed():
          emit(state.copyWith(snackBarEvent: state.snackBarEvent.asConsumed()));
        case MarkDialogAsConsumed():
          emit(state.copyWith(dialogEvent: state.dialogEvent.asConsumed()));
      }
    });
  }

  Future<void> _mapStartedEventToState(
    Emitter<AccountsState> emit,
    bool initializeEncryption,
  ) async {
    final oldScreenState = state.screenState;
    // Emitting Loading ScreenState before while loading Accounts
    emit(
      state.copyWith(
        screenState: const AccountsScreenState.loading(),
      ),
    );

    if (initializeEncryption) {
      await initializeEncryptionUseCase();
    }

    // Retrieving data from the MemoryDataSource
    final accountsData = await getAccountsDataUseCase();

    var accountsList = <AccountData>[];

    // If the MemoryDataSource Accounts are empty read from Storage
    // If not, fill the list above with them
    if (accountsData.accountsList.isEmpty) {
      // Looking if there are Accounts in the SecureStorage
      final storedAccountsData = await getAccountsDataFromStorageUseCase();

      // If there are, formatting into list from JSON and
      // setting them into the MemoryDataSource
      if (storedAccountsData != null) {
        final accountsJson = jsonDecode(storedAccountsData) as List<dynamic>;

        accountsList = List<AccountData>.from(
          accountsJson
              .map(
                (e) => AccountData.empty().fromJson(e as Map<String, dynamic>),
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
  }

  Future<void> _mapExportAccountsEventToState(
    Emitter<AccountsState> emit,
  ) async {
    final accountsData = await getAccountsDataUseCase();

    final exportAccountsResult = await exportAccountsUseCase(accountsData);

    emit(
      state.copyWith(
        screenState: const AccountsScreenState.loading(),
      ),
    );

    switch (exportAccountsResult) {
      case Failure():
        emit(
          state.copyWith(
            dialogEvent: const UIEvent(
              data: ErrorType.pickFolderException(),
            ),
          ),
        );
      case Success():
        // TODO(Kuro): Review this
        // This filePath returns different folder (tested on Android 11)

        emit(
          state.copyWith(
            snackBarEvent: UIEvent(data: Texts.exportedAccounts),
            screenState: const AccountsScreenState.loaded(searchText: ''),
          ),
        );
    }
  }

  Future<void> _mapImportAccountsEventToState(
    Emitter<AccountsState> emit,
  ) async {
    final importAccountsResult = await importAccountsUseCase();

    switch (importAccountsResult) {
      case Failure():
        emit(
          state.copyWith(
            dialogEvent: const UIEvent(
              data: ErrorType.pickFileException(),
            ),
          ),
        );
      case Success(data: final importedAccounts):
        await setAccountsDataUseCase(importedAccounts);

        await setAccountsDataOnStorageUseCase(
          importedAccounts.toStore(),
        );

        emit(
          state.copyWith(
            snackBarEvent: UIEvent(data: Texts.importedAccounts),
          ),
        );

        add(const AccountsEvent.started());
    }
  }
}

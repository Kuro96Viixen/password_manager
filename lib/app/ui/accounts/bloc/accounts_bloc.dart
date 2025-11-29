import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<AccountsStarted>(_onStarted);
    on<AccountsAccountPressed>(_onAccountPressed);
    on<AccountsModifyPressed>(_onModifyPressed);
    on<AccountsShowPrivate>(_onShowPrivate);
    on<AccountsSearchAccount>(_onSearchAccount);
    on<AccountsRandomPasswordPressed>(_onRandomPasswordPressed);
    on<AccountsShowSettings>(_onShowSettings);
    on<AccountsExportAccounts>(_onExportAccounts);
    on<AccountsImportAccounts>(_onImportAccounts);
    on<AccountsMarkNavigationEventAsConsumed>(_onMarkNavigationEventAsConsumed);
    on<AccountsMarkBottomMenuAsConsumed>(_onMarkBottomMenuAsConsumed);
    on<AccountsMarkExportedSnackBarAsConsumed>(
      _onMarkExportedSnackBarAsConsumed,
    );
    on<AccountsMarkImportedSnackBarAsConsumed>(
      _onMarkImportedSnackBarAsConsumed,
    );
    on<AccountsMarkDialogAsConsumed>(_onMarkDialogAsConsumed);
  }

  final GetAccountsDataUseCase getAccountsDataUseCase;
  final SetAccountsDataUseCase setAccountsDataUseCase;
  final GetAccountsDataFromStorageUseCase getAccountsDataFromStorageUseCase;
  final SetAccountsDataOnStorageUseCase setAccountsDataOnStorageUseCase;
  final GetAuthenticationUseCase getAuthenticationUseCase;
  final ExportAccountsUseCase exportAccountsUseCase;
  final ImportAccountsUseCase importAccountsUseCase;
  final InitializeEncryptionUseCase initializeEncryptionUseCase;

  Future<void> _onStarted(
    AccountsStarted event,
    Emitter<AccountsState> emit,
  ) async {
    final oldScreenState = state.screenState;
    // Emitting Loading ScreenState before while loading Accounts
    emit(
      state.copyWith(
        screenState: const AccountsScreenStateLoading(),
      ),
    );

    if (event.initializeEncryption) {
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

        accountsList =
            List<AccountData>.from(
                accountsJson
                    .map(
                      (e) => AccountData.empty().fromJson(
                        e as Map<String, dynamic>,
                      ),
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
        screenState: oldScreenState is AccountsScreenStateLoading
            ? const AccountsScreenStateLoaded(searchText: '')
            : oldScreenState,
      ),
    );
  }

  void _onAccountPressed(
    AccountsAccountPressed event,
    Emitter<AccountsState> emit,
  ) {
    emit(
      state.copyWith(
        selectedAccount: state.accountsList[event.accountIndex],
        navigationEvent: const UIEvent(data: DetailsView.routeName),
      ),
    );
  }

  void _onModifyPressed(
    AccountsModifyPressed event,
    Emitter<AccountsState> emit,
  ) {
    emit(
      state.copyWith(
        navigationEvent: const UIEvent(data: ModifyView.routeName),
      ),
    );
  }

  Future<void> _onShowPrivate(
    AccountsShowPrivate event,
    Emitter<AccountsState> emit,
  ) async {
    if (await getAuthenticationUseCase()) {
      emit(
        state.copyWith(
          screenState: const AccountsScreenStateLoaded(searchText: ''),
          navigationEvent: const UIEvent(data: PrivateView.routeName),
        ),
      );
    }
  }

  void _onSearchAccount(
    AccountsSearchAccount event,
    Emitter<AccountsState> emit,
  ) {
    emit(
      state.copyWith(
        screenState: AccountsScreenStateLoaded(searchText: event.searchString),
      ),
    );
  }

  void _onRandomPasswordPressed(
    AccountsRandomPasswordPressed event,
    Emitter<AccountsState> emit,
  ) {
    emit(
      state.copyWith(
        navigationEvent: const UIEvent(
          data: RandomPasswordView.routeName,
        ),
      ),
    );
  }

  void _onShowSettings(
    AccountsShowSettings event,
    Emitter<AccountsState> emit,
  ) {
    emit(state.copyWith(bottomMenuEvent: const UIEvent()));
  }

  Future<void> _onExportAccounts(
    AccountsExportAccounts event,
    Emitter<AccountsState> emit,
  ) async {
    final accountsData = await getAccountsDataUseCase();

    final exportAccountsResult = await exportAccountsUseCase(accountsData);

    emit(
      state.copyWith(
        screenState: const AccountsScreenStateLoading(),
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
            exportedSnackBarEvent: const UIEvent(),
            screenState: const AccountsScreenStateLoaded(searchText: ''),
          ),
        );
    }
  }

  Future<void> _onImportAccounts(
    AccountsImportAccounts event,
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
            importedSnackBarEvent: const UIEvent(),
          ),
        );

        add(const AccountsStarted());
    }
  }

  void _onMarkNavigationEventAsConsumed(
    AccountsMarkNavigationEventAsConsumed event,
    Emitter<AccountsState> emit,
  ) {
    emit(
      state.copyWith(
        navigationEvent: state.navigationEvent.asConsumed(),
      ),
    );
  }

  void _onMarkBottomMenuAsConsumed(
    AccountsMarkBottomMenuAsConsumed event,
    Emitter<AccountsState> emit,
  ) {
    emit(
      state.copyWith(bottomMenuEvent: state.bottomMenuEvent.asConsumed()),
    );
  }

  void _onMarkExportedSnackBarAsConsumed(
    AccountsMarkExportedSnackBarAsConsumed event,
    Emitter<AccountsState> emit,
  ) {
    emit(
      state.copyWith(
        exportedSnackBarEvent: state.exportedSnackBarEvent.asConsumed(),
      ),
    );
  }

  void _onMarkImportedSnackBarAsConsumed(
    AccountsMarkImportedSnackBarAsConsumed event,
    Emitter<AccountsState> emit,
  ) {
    emit(
      state.copyWith(
        importedSnackBarEvent: state.importedSnackBarEvent.asConsumed(),
      ),
    );
  }

  void _onMarkDialogAsConsumed(
    AccountsMarkDialogAsConsumed event,
    Emitter<AccountsState> emit,
  ) {
    emit(state.copyWith(dialogEvent: state.dialogEvent.asConsumed()));
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/use_cases/decrypt_password_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_authentication_use_case.dart';
import 'package:password_manager/app/domain/use_cases/set_accounts_data_on_storage_use_case.dart';
import 'package:password_manager/app/domain/use_cases/set_accounts_data_use_case.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';
import 'package:password_manager/app/ui/details/bloc/details_event.dart';
import 'package:password_manager/app/ui/details/bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;
  final SetAccountsDataUseCase setAccountsDataUseCase;
  final SetAccountsDataOnStorageUseCase setAccountsDataOnStorageUseCase;
  final GetAuthenticationUseCase getAuthenticationUseCase;
  final DecryptPasswordUseCase decryptPasswordUseCase;

  DetailsBloc({
    required this.getAccountsDataUseCase,
    required this.setAccountsDataUseCase,
    required this.setAccountsDataOnStorageUseCase,
    required this.getAuthenticationUseCase,
    required this.decryptPasswordUseCase,
  }) : super(DetailsState.initial()) {
    on<DetailsEvent>((event, emit) async {
      switch (event) {
        case Started(accountData: final accountData):
          await _mapStartedEventToState(emit, accountData);
        case PressedDelete():
          emit(
            state.copyWith(
              popUpEvent: const UIEvent(),
            ),
          );
        case DeleteAccount(accountData: final accountData):
          await _mapDeleteAccountEventToState(accountData, emit);
        case RevealPassword(password: final password):
          if (await getAuthenticationUseCase()) {
            final decryptedPassword = await decryptPasswordUseCase(
              password,
            );

            emit(state.copyWith(passwordString: decryptedPassword));
          }
        case CopyPassword(password: final password):
          final decryptedPassword = await decryptPasswordUseCase(password);

          await Clipboard.setData(ClipboardData(text: decryptedPassword));

          emit(
            state.copyWith(
              copySnackBarEvent: const UIEvent(),
            ),
          );
        case PressedModify():
          final accountsData = await getAccountsDataUseCase();

          emit(
            state.copyWith(
              modifyEvent: UIEvent(
                data: accountsData.accountsList[state.accountPosition],
              ),
            ),
          );
        case MarkModifyAsConsumed():
          emit(state.copyWith(modifyEvent: state.modifyEvent.asConsumed()));
        case MarkCopySnackBarAsConsumed():
          emit(
            state.copyWith(
              copySnackBarEvent: state.copySnackBarEvent.asConsumed(),
            ),
          );
        case MarkPopUpAsConsumed():
          emit(state.copyWith(popUpEvent: state.popUpEvent.asConsumed()));
      }
    });
  }

  Future<void> _mapStartedEventToState(
    Emitter<DetailsState> emit,
    AccountData accountData,
  ) async {
    emit(
      state.copyWith(
        screenState: const DetailsScreenState.loading(),
      ),
    );

    final accountsData = await getAccountsDataUseCase();

    var accountPosition = accountsData.accountsList.indexOf(accountData);

    if (accountPosition == -1) {
      accountPosition = state.accountPosition;
    }

    emit(
      state.copyWith(
        accountData: accountsData.accountsList[accountPosition],
        accountPosition: accountPosition,
        screenState: const DetailsScreenState.loaded(),
      ),
    );
  }

  Future<void> _mapDeleteAccountEventToState(
    AccountData accountData,
    Emitter<DetailsState> emit,
  ) async {
    final accountsData = await getAccountsDataUseCase();

    final accountsList = accountsData.accountsList.toList()
      ..remove(accountData);

    await setAccountsDataUseCase(
      accountsData.copyWith(accountsList: accountsList),
    );

    final accountsToSave = AccountsData(accountsList: accountsList).toStore();

    await setAccountsDataOnStorageUseCase(accountsToSave);

    emit(
      state.copyWith(
        goBackEvent: const UIEvent(),
      ),
    );
  }
}

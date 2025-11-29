import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/model/password.dart';
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
    on<DetailsStarted>(_onStarted);
    on<PressedDelete>(_onPressedDelete);
    on<DeleteAccount>(_onDeleteAccount);
    on<RevealPassword>(_onRevealPassword);
    on<CopyPassword>(_onCopyPassword);
    on<PressedModify>(_onPressedModify);
    on<MarkModifyAsConsumed>(_onMarkModifyAsConsumed);
    on<MarkCopySnackBarAsConsumed>(_onMarkCopySnackBarAsConsumed);
    on<MarkPopUpAsConsumed>(_onMarkPopUpAsConsumed);
  }

  Future<void> _onStarted(
    DetailsStarted event,
    Emitter<DetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        screenState: const Loading(),
      ),
    );

    final accountsData = await getAccountsDataUseCase();

    var accountPosition = accountsData.accountsList.indexOf(event.accountData);

    if (accountPosition == -1) {
      accountPosition = state.accountPosition;
    }

    emit(
      state.copyWith(
        accountData: accountsData.accountsList[accountPosition],
        accountPosition: accountPosition,
        screenState: const Loaded(),
      ),
    );
  }

  void _onPressedDelete(
    PressedDelete event,
    Emitter<DetailsState> emit,
  ) {
    emit(
      state.copyWith(
        popUpEvent: const UIEvent(),
      ),
    );
  }

  Future<void> _onDeleteAccount(
    DeleteAccount event,
    Emitter<DetailsState> emit,
  ) async {
    final accountsData = await getAccountsDataUseCase();

    final accountsList = accountsData.accountsList.toList()
      ..remove(event.accountData);

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

  Future<void> _onRevealPassword(
    RevealPassword event,
    Emitter<DetailsState> emit,
  ) async {
    if (await getAuthenticationUseCase()) {
      final decryptedPassword = await decryptPasswordUseCase(
        Password(
          password: state.accountData.password,
          iv: state.accountData.passwordIV,
        ),
      );

      emit(state.copyWith(passwordString: decryptedPassword));
    }
  }

  Future<void> _onCopyPassword(
    CopyPassword event,
    Emitter<DetailsState> emit,
  ) async {
    final decryptedPassword = await decryptPasswordUseCase(
      Password(
        password: state.accountData.password,
        iv: state.accountData.passwordIV,
      ),
    );

    await Clipboard.setData(ClipboardData(text: decryptedPassword));

    emit(
      state.copyWith(
        copySnackBarEvent: const UIEvent(),
      ),
    );
  }

  Future<void> _onPressedModify(
    PressedModify event,
    Emitter<DetailsState> emit,
  ) async {
    final accountsData = await getAccountsDataUseCase();

    emit(
      state.copyWith(
        modifyEvent: UIEvent(
          data: accountsData.accountsList[state.accountPosition],
        ),
      ),
    );
  }

  void _onMarkModifyAsConsumed(
    MarkModifyAsConsumed event,
    Emitter<DetailsState> emit,
  ) {
    emit(state.copyWith(modifyEvent: state.modifyEvent.asConsumed()));
  }

  void _onMarkCopySnackBarAsConsumed(
    MarkCopySnackBarAsConsumed event,
    Emitter<DetailsState> emit,
  ) {
    emit(
      state.copyWith(
        copySnackBarEvent: state.copySnackBarEvent.asConsumed(),
      ),
    );
  }

  void _onMarkPopUpAsConsumed(
    MarkPopUpAsConsumed event,
    Emitter<DetailsState> emit,
  ) {
    emit(state.copyWith(popUpEvent: state.popUpEvent.asConsumed()));
  }
}

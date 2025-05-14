import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/use_cases/decrypt_password_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_authentication_use_case.dart';
import 'package:password_manager/app/domain/use_cases/set_accounts_data_on_storage_use_case.dart';
import 'package:password_manager/app/domain/use_cases/set_accounts_data_use_case.dart';

part 'details_bloc.freezed.dart';
part 'details_event.dart';
part 'details_state.dart';

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
      await event.when(
        started: (accountData) async {
          emit(
            state.copyWith(
              screenState: const DetailsScreenState.loading(),
              navigationState: null,
            ),
          );

          final accountsData = await getAccountsDataUseCase();

          var accountPosition = accountsData.accountsList.indexOf(accountData);

          if (accountPosition == -1) {
            accountPosition = state.accountPosition;
          }

          emit(
            state.copyWith(
              passwordString: Texts.hiddenPasswordText,
              accountData: accountsData.accountsList[accountPosition],
              accountPosition: accountPosition,
              screenState: const DetailsScreenState.loaded(),
              navigationState: null,
            ),
          );
        },
        pressedBack: () {
          emit(
            state.copyWith(
              navigationState: const DetailsNavigationState.goBack(),
            ),
          );
        },
        pressedDelete: () {
          emit(state.copyWith(navigationState: null));

          emit(
            state.copyWith(
              navigationState: const DetailsNavigationState.showPopUp(),
            ),
          );
        },
        deleteAccount: (accountData) async {
          final accountsData = await getAccountsDataUseCase();

          final accountsList = accountsData.accountsList.toList()
            ..remove(accountData);

          await setAccountsDataUseCase(
            accountsData.copyWith(accountsList: accountsList),
          );

          final accountsToSave =
              AccountsData(accountsList: accountsList).toStore();

          await setAccountsDataOnStorageUseCase(accountsToSave);

          emit(
            state.copyWith(
              navigationState: const DetailsNavigationState.goBack(),
            ),
          );
        },
        revealPassword: (password) async {
          if (await getAuthenticationUseCase()) {
            final decryptedPassword = await decryptPasswordUseCase(
              password,
            );

            emit(state.copyWith(passwordString: decryptedPassword));
          }
        },
        copyPassword: (password) async {
          final decryptedPassword = await decryptPasswordUseCase(password);

          await Clipboard.setData(ClipboardData(text: decryptedPassword));

          emit(
            state.copyWith(
              navigationState: DetailsNavigationState.showSnackBar(
                Texts.copiedToClipboard,
              ),
            ),
          );
        },
        pressedModify: () async {
          emit(state.copyWith(navigationState: null));

          final accountsData = await getAccountsDataUseCase();

          emit(
            state.copyWith(
              navigationState: DetailsNavigationState.goToModify(
                accountsData.accountsList[state.accountPosition],
              ),
            ),
          );
        },
      );
    });
  }
}

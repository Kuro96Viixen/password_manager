import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/domain/mapper/accounts_data_mapper.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/domain/use_cases/get_authentication_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_on_storage_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_use_case.dart';
import 'package:password_manager/utils/encryption.dart';

part 'details_bloc.freezed.dart';
part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;
  final SetAccountsDataUseCase setAccountsDataUseCase;
  final SetAccountsDataOnStorageUseCase setAccountsDataOnStorageUseCase;
  final GetAuthenticationUseCase getAuthenticationUseCase;

  DetailsBloc({
    required this.getAccountsDataUseCase,
    required this.setAccountsDataUseCase,
    required this.setAccountsDataOnStorageUseCase,
    required this.getAuthenticationUseCase,
  }) : super(DetailsState.initial()) {
    on<DetailsEvent>((event, emit) async {
      await event.when(
        started: () {
          emit(
            state.copyWith(
              passwordString: Texts.hiddenPasswordText,
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
        deleteAccount: (accountData) async {
          final accountsData = await getAccountsDataUseCase();

          List<AccountData> accountsList = accountsData.accountsList.toList();

          accountsList.remove(accountData);

          setAccountsDataUseCase(
            accountsData.copyWith(accountsList: accountsList),
          );

          String accountsToSave =
              AccountsData(accountsList: accountsList).toStore();

          setAccountsDataOnStorageUseCase(accountsToSave);

          emit(
            state.copyWith(
              navigationState: const DetailsNavigationState.goBack(),
            ),
          );
        },
        revealPassword: (password) async {
          if (await getAuthenticationUseCase()) {
            final decryptedPassword = Encryption.decryptPassword(password);

            emit(state.copyWith(passwordString: decryptedPassword));
          }
        },
        copyPassword: (password) {
          final decryptedPassword = Encryption.decryptPassword(password);

          Clipboard.setData(ClipboardData(text: decryptedPassword));

          emit(
            state.copyWith(
              navigationState: DetailsNavigationState.showSnackBar(
                Texts.copiedToClipboard,
              ),
            ),
          );
        },
        pressedModify: () {
          emit(state.copyWith(navigationState: null));

          emit(
            state.copyWith(
              navigationState: const DetailsNavigationState.goToModify(),
            ),
          );
        },
      );
    });
  }
}

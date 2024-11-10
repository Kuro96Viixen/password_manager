import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';

part 'private_bloc.freezed.dart';
part 'private_event.dart';
part 'private_state.dart';

class PrivateBloc extends Bloc<PrivateEvent, PrivateState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;

  PrivateBloc({
    required this.getAccountsDataUseCase,
  }) : super(PrivateState.initial()) {
    on<PrivateEvent>((event, emit) async {
      await event.when(
        started: () async {
          // Emitting Loading ScreenState before while loading Accounts
          emit(
            state.copyWith(
              screenState: const PrivateScreenState.loading(),
              navigationState: null,
            ),
          );

          // Retrieving data from the MemoryDataSource
          final accountsData = await getAccountsDataUseCase();

          List<AccountData> accountsList = accountsData.accountsList;

          // Sending the accounts to the screen and
          // remove the loader from the screen
          emit(
            state.copyWith(
              accountsList: accountsList,
              screenState: const PrivateScreenState.loaded(searchText: ''),
            ),
          );
        },
        pressedAccount: (accountIndex) async {
          final accountsData = await getAccountsDataUseCase();

          emit(
            state.copyWith(
              navigationState: PrivateNavigationState.goToDetails(
                accountData: accountsData.accountsList[accountIndex],
              ),
            ),
          );
        },
        searchAccount: (searchString) {
          emit(
            state.copyWith(
              screenState: PrivateScreenState.loaded(searchText: searchString),
              navigationState: null,
            ),
          );
        },
      );
    });
  }
}

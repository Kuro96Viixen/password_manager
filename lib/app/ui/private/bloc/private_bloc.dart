import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';
import 'package:password_manager/app/ui/private/bloc/private_event.dart';
import 'package:password_manager/app/ui/private/bloc/private_state.dart';

class PrivateBloc extends Bloc<PrivateEvent, PrivateState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;

  PrivateBloc({
    required this.getAccountsDataUseCase,
  }) : super(PrivateState.initial()) {
    on<PrivateEvent>((event, emit) async {
      switch (event) {
        case Started():
          await _mapStartedEventToState(emit);
        case PressedAccount(accountIndex: final accountIndex):
          emit(
            state.copyWith(
              navigationEvent: UIEvent(
                data: state.accountsList[accountIndex],
              ),
            ),
          );
        case SearchAccount(searchString: final searchString):
          emit(
            state.copyWith(
              screenState: PrivateScreenState.loaded(searchText: searchString),
            ),
          );
        case MarkNavigationEventAsConsumed():
          emit(
            state.copyWith(
              navigationEvent: state.navigationEvent.asConsumed(),
            ),
          );
      }
    });
  }

  Future<void> _mapStartedEventToState(Emitter<PrivateState> emit) async {
    // Emitting Loading ScreenState before while loading Accounts
    emit(
      state.copyWith(
        screenState: const PrivateScreenState.loading(),
      ),
    );

    // Retrieving data from the MemoryDataSource
    final accountsData = await getAccountsDataUseCase();

    final accountsList = List<AccountData>.from(accountsData.accountsList)
      ..removeWhere((account) => !account.private)
      ..toList();

    // Sending the accounts to the screen and
    // remove the loader from the screen
    emit(
      state.copyWith(
        accountsList: accountsList,
        screenState: const PrivateScreenState.loaded(searchText: ''),
      ),
    );
  }
}

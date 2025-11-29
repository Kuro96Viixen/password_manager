import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';
import 'package:password_manager/app/ui/private/bloc/private_event.dart';
import 'package:password_manager/app/ui/private/bloc/private_state.dart';

class PrivateBloc extends Bloc<PrivateEvent, PrivateState> {
  PrivateBloc({
    required this.getAccountsDataUseCase,
  }) : super(PrivateState.initial()) {
    on<PrivateStarted>(_onStarted);
    on<PrivatePressedAccount>(_onPressedAccount);
    on<PrivateSearchAccount>(_onSearchAccount);
    on<MarkNavigationEventAsConsumed>(_onMarkNavigationEventAsConsumed);
  }

  final GetAccountsDataUseCase getAccountsDataUseCase;

  Future<void> _onStarted(
    PrivateStarted event,
    Emitter<PrivateState> emit,
  ) async {
    // Emitting Loading ScreenState before while loading Accounts
    emit(
      state.copyWith(
        screenState: const PrivateScreenStateLoading(),
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
        screenState: const PrivateScreenStateLoaded(searchText: ''),
      ),
    );
  }

  void _onPressedAccount(
    PrivatePressedAccount event,
    Emitter<PrivateState> emit,
  ) {
    emit(
      state.copyWith(
        navigationEvent: UIEvent(
          data: state.accountsList[event.accountIndex],
        ),
      ),
    );
  }

  void _onSearchAccount(
    PrivateSearchAccount event,
    Emitter<PrivateState> emit,
  ) {
    emit(
      state.copyWith(
        screenState: PrivateScreenStateLoaded(searchText: event.searchString),
      ),
    );
  }

  void _onMarkNavigationEventAsConsumed(
    MarkNavigationEventAsConsumed event,
    Emitter<PrivateState> emit,
  ) {
    emit(
      state.copyWith(
        navigationEvent: state.navigationEvent.asConsumed(),
      ),
    );
  }
}

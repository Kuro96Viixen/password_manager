import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_event.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_state.dart';

class DuplicatedPasswordCheckerBloc extends Bloc<DuplicatedPasswordCheckerEvent,
    DuplicatedPasswordCheckerState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;

  DuplicatedPasswordCheckerBloc({
    required this.getAccountsDataUseCase,
  }) : super(DuplicatedPasswordCheckerState.initial()) {
    on<DuplicatedPasswordCheckerEvent>((event, emit) async {
      await event.when(
        started: () async => await _mapStartedEventToState(emit),
      );
    });
  }

  Future<void> _mapStartedEventToState(
    Emitter<DuplicatedPasswordCheckerState> emit,
  ) async {
    final accountsData = await getAccountsDataUseCase();

    // TODO Do Somehting

    emit(
      state.copyWith(
        accountsList: accountsData.accountsList,
        // screenState: DuplicatedPasswordCheckerScreenState.success(),
      ),
    );
  }
}

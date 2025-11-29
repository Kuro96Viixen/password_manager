import 'package:encrypt/encrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/use_cases/decrypt_password_use_case.dart';
import 'package:password_manager/app/domain/use_cases/encrypt_for_duplicate_use_case.dart';
import 'package:password_manager/app/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_event.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_state.dart';

class DuplicatedPasswordCheckerBloc
    extends
        Bloc<DuplicatedPasswordCheckerEvent, DuplicatedPasswordCheckerState> {
  final GetAccountsDataUseCase getAccountsDataUseCase;
  final DecryptPasswordUseCase decryptPasswordUseCase;
  final EncryptForDuplicateUseCase encryptForDuplicateUseCase;

  DuplicatedPasswordCheckerBloc({
    required this.getAccountsDataUseCase,
    required this.decryptPasswordUseCase,
    required this.encryptForDuplicateUseCase,
  }) : super(DuplicatedPasswordCheckerState.initial()) {
    on<DuplicatedPasswordCheckerStarted>(_onStarted);
  }

  Future<void> _onStarted(
    DuplicatedPasswordCheckerStarted event,
    Emitter<DuplicatedPasswordCheckerState> emit,
  ) async {
    final accountsData = await getAccountsDataUseCase();

    final duplicatedAccountsMap = <String, List<AccountData>>{};

    final iv = IV.fromLength(16);

    for (final account in accountsData.accountsList) {
      final key = await encryptForDuplicateUseCase(
        await decryptPasswordUseCase(
          Password(password: account.password, iv: account.passwordIV),
        ),
        iv,
      );

      if (duplicatedAccountsMap.containsKey(key)) {
        duplicatedAccountsMap[key]!.add(account);
      } else {
        duplicatedAccountsMap[key] = [account];
      }
    }

    // Calculate percentage of different accounts
    final differentAccountsPercentage =
        (duplicatedAccountsMap.length / accountsData.accountsList.length * 100)
            .round();

    // Remove items with only one account
    duplicatedAccountsMap.removeWhere((key, value) => value.length == 1);

    final finalDuplicatedAccountsMap = <int, List<AccountData>>{};
    var index = 1;
    for (final entry in duplicatedAccountsMap.entries) {
      finalDuplicatedAccountsMap[index] = entry.value;
      index++;
    }

    emit(
      state.copyWith(
        accountsList: finalDuplicatedAccountsMap,
        differentAccountsPercentage: differentAccountsPercentage,
        screenState: differentAccountsPercentage == 100
            ? const Unique()
            : const Success(),
      ),
    );
  }
}

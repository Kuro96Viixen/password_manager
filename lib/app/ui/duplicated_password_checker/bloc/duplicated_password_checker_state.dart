import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

part 'duplicated_password_checker_state.freezed.dart';

@freezed
sealed class DuplicatedPasswordCheckerState
    with _$DuplicatedPasswordCheckerState {
  factory DuplicatedPasswordCheckerState({
    required Map<int, List<AccountData>> accountsList,
    required int differentAccountsPercentage,
    required DuplicatedPasswordCheckerScreenState screenState,
  }) = _DuplicatedPasswordCheckerState;

  factory DuplicatedPasswordCheckerState.initial() =>
      DuplicatedPasswordCheckerState(
        accountsList: {},
        differentAccountsPercentage: 0,
        screenState: DuplicatedPasswordCheckerScreenState.loading(),
      );
}

@freezed
sealed class DuplicatedPasswordCheckerScreenState
    with _$DuplicatedPasswordCheckerScreenState {
  factory DuplicatedPasswordCheckerScreenState.loading() = Loading;

  factory DuplicatedPasswordCheckerScreenState.success() = Success;

  factory DuplicatedPasswordCheckerScreenState.unique() = Unique;
}

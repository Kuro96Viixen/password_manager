import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

part 'duplicated_password_checker_state.freezed.dart';

@freezed
class DuplicatedPasswordCheckerState with _$DuplicatedPasswordCheckerState {
  factory DuplicatedPasswordCheckerState({
    required List<AccountData> accountsList,
    required DuplicatedPasswordCheckerScreenState screenState,
  }) = _DuplicatedPasswordCheckerState;

  factory DuplicatedPasswordCheckerState.initial() =>
      DuplicatedPasswordCheckerState(
        accountsList: [],
        screenState: DuplicatedPasswordCheckerScreenState.loading(),
      );
}

@freezed
class DuplicatedPasswordCheckerScreenState
    with _$DuplicatedPasswordCheckerScreenState {
  factory DuplicatedPasswordCheckerScreenState.loading() = _Loading;

  factory DuplicatedPasswordCheckerScreenState.success() = _Success;
}

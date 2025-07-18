import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/model/error_type.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

part 'accounts_state.freezed.dart';

@freezed
sealed class AccountsState with _$AccountsState {
  const factory AccountsState({
    required List<AccountData> accountsList,
    required AccountsScreenState screenState,
    required AccountData? selectedAccount,
    required UIEvent<String> navigationEvent,
    required UIEvent<void> bottomMenuEvent,
    required UIEvent<String> snackBarEvent,
    required UIEvent<ErrorType> dialogEvent,
  }) = _AccountsState;

  factory AccountsState.initial() => const AccountsState(
        accountsList: [],
        screenState: AccountsScreenState.loading(),
        selectedAccount: null,
        navigationEvent: UIEvent<String>(consumed: true),
        bottomMenuEvent: UIEvent<void>(consumed: true),
        snackBarEvent: UIEvent<String>(consumed: true),
        dialogEvent: UIEvent<ErrorType>(consumed: true),
      );
}

@freezed
sealed class AccountsScreenState with _$AccountsScreenState {
  const factory AccountsScreenState.loading() = Loading;

  const factory AccountsScreenState.loaded({required String searchText}) =
      Loaded;
}

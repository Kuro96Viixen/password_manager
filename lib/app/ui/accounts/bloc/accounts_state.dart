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
    required UIEvent<void> exportedSnackBarEvent,
    required UIEvent<void> importedSnackBarEvent,
    required UIEvent<ErrorType> dialogEvent,
  }) = _AccountsState;

  factory AccountsState.initial() => const AccountsState(
    accountsList: [],
    screenState: AccountsScreenState.loading(),
    selectedAccount: null,
    navigationEvent: UIEvent(consumed: true),
    bottomMenuEvent: UIEvent(consumed: true),
    exportedSnackBarEvent: UIEvent(consumed: true),
    importedSnackBarEvent: UIEvent(consumed: true),
    dialogEvent: UIEvent(consumed: true),
  );
}

@freezed
sealed class AccountsScreenState with _$AccountsScreenState {
  const factory AccountsScreenState.loading() = Loading;

  const factory AccountsScreenState.loaded({required String searchText}) =
      Loaded;
}

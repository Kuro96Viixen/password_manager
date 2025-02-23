import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/model/error_type.dart';

part 'accounts_state.freezed.dart';

@freezed
class AccountsState with _$AccountsState {
  const factory AccountsState({
    required List<AccountData> accountsList,
    required AccountsScreenState screenState,
    AccountsNavigationState? navigationState,
  }) = _AccountsState;

  factory AccountsState.initial() => const AccountsState(
        accountsList: [],
        screenState: AccountsScreenState.loading(),
        navigationState: null,
      );
}

@freezed
class AccountsScreenState with _$AccountsScreenState {
  const factory AccountsScreenState.loading() = _Loading;

  const factory AccountsScreenState.loaded({required String searchText}) =
      _Loaded;
}

@freezed
class AccountsNavigationState with _$AccountsNavigationState {
  const factory AccountsNavigationState.goToPrivate() = _GoToPrivate;

  const factory AccountsNavigationState.goToDetails({
    required AccountData accountData,
  }) = _GoToDetails;

  const factory AccountsNavigationState.goToModify() = _GoToModify;

  const factory AccountsNavigationState.goToGeneratePassword() =
      _GoToGeneratePassword;

  // TODO(Kuro): Uncomment this when GP deployed
  // const factory AccountsNavigationState.showBottomMenu() = _ShowBottomMenu;

  const factory AccountsNavigationState.showSnackBar({
    required String snackBarMessage,
  }) = _ShowSnackBar;

  const factory AccountsNavigationState.showDialog(ErrorType dialogType) =
      _ShowDialog;
}

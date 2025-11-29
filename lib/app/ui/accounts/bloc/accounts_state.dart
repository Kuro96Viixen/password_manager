import 'package:equatable/equatable.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/model/error_type.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

final class AccountsState extends Equatable {
  const AccountsState({
    required this.accountsList,
    required this.screenState,
    required this.selectedAccount,
    required this.navigationEvent,
    required this.bottomMenuEvent,
    required this.exportedSnackBarEvent,
    required this.importedSnackBarEvent,
    required this.dialogEvent,
  });

  factory AccountsState.initial() => const AccountsState(
    accountsList: [],
    screenState: AccountsScreenStateLoading(),
    selectedAccount: null,
    navigationEvent: UIEvent<String>(consumed: true),
    bottomMenuEvent: UIEvent<void>(consumed: true),
    exportedSnackBarEvent: UIEvent<void>(consumed: true),
    importedSnackBarEvent: UIEvent<void>(consumed: true),
    dialogEvent: UIEvent<ErrorType>(consumed: true),
  );

  final List<AccountData> accountsList;
  final AccountsScreenState screenState;
  final AccountData? selectedAccount;
  final UIEvent<String> navigationEvent;
  final UIEvent<void> bottomMenuEvent;
  final UIEvent<void> exportedSnackBarEvent;
  final UIEvent<void> importedSnackBarEvent;
  final UIEvent<ErrorType> dialogEvent;

  @override
  List<Object?> get props => [
    accountsList,
    screenState,
    selectedAccount,
    navigationEvent,
    bottomMenuEvent,
    exportedSnackBarEvent,
    importedSnackBarEvent,
    dialogEvent,
  ];

  AccountsState copyWith({
    List<AccountData>? accountsList,
    AccountsScreenState? screenState,
    AccountData? selectedAccount,
    UIEvent<String>? navigationEvent,
    UIEvent<void>? bottomMenuEvent,
    UIEvent<void>? exportedSnackBarEvent,
    UIEvent<void>? importedSnackBarEvent,
    UIEvent<ErrorType>? dialogEvent,
  }) {
    return AccountsState(
      accountsList: accountsList ?? this.accountsList,
      screenState: screenState ?? this.screenState,
      selectedAccount: selectedAccount,
      navigationEvent: navigationEvent ?? this.navigationEvent,
      bottomMenuEvent: bottomMenuEvent ?? this.bottomMenuEvent,
      exportedSnackBarEvent:
          exportedSnackBarEvent ?? this.exportedSnackBarEvent,
      importedSnackBarEvent:
          importedSnackBarEvent ?? this.importedSnackBarEvent,
      dialogEvent: dialogEvent ?? this.dialogEvent,
    );
  }
}

sealed class AccountsScreenState extends Equatable {
  const AccountsScreenState();

  @override
  List<Object?> get props => [];
}

final class AccountsScreenStateLoading extends AccountsScreenState {
  const AccountsScreenStateLoading();
}

final class AccountsScreenStateLoaded extends AccountsScreenState {
  const AccountsScreenStateLoaded({required this.searchText});

  final String searchText;

  @override
  List<Object?> get props => [searchText];
}

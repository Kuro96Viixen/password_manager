import 'package:equatable/equatable.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

final class DuplicatedPasswordCheckerState extends Equatable {
  const DuplicatedPasswordCheckerState({
    required this.accountsList,
    required this.differentAccountsPercentage,
    required this.screenState,
  });

  factory DuplicatedPasswordCheckerState.initial() =>
      const DuplicatedPasswordCheckerState(
        accountsList: {},
        differentAccountsPercentage: 0,
        screenState: Loading(),
      );

  final Map<int, List<AccountData>> accountsList;
  final int differentAccountsPercentage;
  final DuplicatedPasswordCheckerScreenState screenState;

  @override
  List<Object?> get props => [
    accountsList,
    differentAccountsPercentage,
    screenState,
  ];

  DuplicatedPasswordCheckerState copyWith({
    Map<int, List<AccountData>>? accountsList,
    int? differentAccountsPercentage,
    DuplicatedPasswordCheckerScreenState? screenState,
  }) {
    return DuplicatedPasswordCheckerState(
      accountsList: accountsList ?? this.accountsList,
      differentAccountsPercentage:
          differentAccountsPercentage ?? this.differentAccountsPercentage,
      screenState: screenState ?? this.screenState,
    );
  }
}

sealed class DuplicatedPasswordCheckerScreenState extends Equatable {
  const DuplicatedPasswordCheckerScreenState();

  @override
  List<Object?> get props => [];
}

final class Loading extends DuplicatedPasswordCheckerScreenState {
  const Loading();
}

final class Success extends DuplicatedPasswordCheckerScreenState {
  const Success();
}

final class Unique extends DuplicatedPasswordCheckerScreenState {
  const Unique();
}

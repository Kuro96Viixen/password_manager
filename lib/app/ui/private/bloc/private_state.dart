import 'package:equatable/equatable.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

final class PrivateState extends Equatable {
  const PrivateState({
    required this.accountsList,
    required this.screenState,
    required this.navigationEvent,
  });

  factory PrivateState.initial() => const PrivateState(
    accountsList: [],
    screenState: PrivateScreenStateLoading(),
    navigationEvent: UIEvent(consumed: true),
  );

  final List<AccountData> accountsList;
  final PrivateScreenState screenState;
  final UIEvent<AccountData> navigationEvent;

  @override
  List<Object?> get props => [accountsList, screenState, navigationEvent];

  PrivateState copyWith({
    List<AccountData>? accountsList,
    PrivateScreenState? screenState,
    UIEvent<AccountData>? navigationEvent,
  }) {
    return PrivateState(
      accountsList: accountsList ?? this.accountsList,
      screenState: screenState ?? this.screenState,
      navigationEvent: navigationEvent ?? this.navigationEvent,
    );
  }
}

sealed class PrivateScreenState extends Equatable {
  const PrivateScreenState();

  @override
  List<Object?> get props => [];
}

final class PrivateScreenStateLoading extends PrivateScreenState {
  const PrivateScreenStateLoading();
}

final class PrivateScreenStateLoaded extends PrivateScreenState {
  const PrivateScreenStateLoaded({required this.searchText});

  final String searchText;

  @override
  List<Object?> get props => [searchText];
}

import 'package:equatable/equatable.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

final class DetailsState extends Equatable {
  const DetailsState({
    required this.passwordString,
    required this.accountData,
    required this.accountPosition,
    required this.screenState,
    required this.modifyEvent,
    required this.goBackEvent,
    required this.copySnackBarEvent,
    required this.popUpEvent,
  });

  factory DetailsState.initial() => DetailsState(
    passwordString: null,
    accountData: AccountData.empty(),
    accountPosition: 0,
    screenState: const Loading(),
    modifyEvent: const UIEvent(consumed: true),
    goBackEvent: const UIEvent(consumed: true),
    copySnackBarEvent: const UIEvent(consumed: true),
    popUpEvent: const UIEvent(consumed: true),
  );

  final String? passwordString;
  final AccountData accountData;
  final int accountPosition;
  final DetailsScreenState screenState;
  final UIEvent<AccountData> modifyEvent;
  final UIEvent<void> goBackEvent;
  final UIEvent<void> copySnackBarEvent;
  final UIEvent<void> popUpEvent;

  @override
  List<Object?> get props => [
    passwordString,
    accountData,
    accountPosition,
    screenState,
    modifyEvent,
    goBackEvent,
    copySnackBarEvent,
    popUpEvent,
  ];

  DetailsState copyWith({
    String? passwordString,
    AccountData? accountData,
    int? accountPosition,
    DetailsScreenState? screenState,
    UIEvent<AccountData>? modifyEvent,
    UIEvent<void>? goBackEvent,
    UIEvent<void>? copySnackBarEvent,
    UIEvent<void>? popUpEvent,
  }) {
    return DetailsState(
      passwordString: passwordString ?? this.passwordString,
      accountData: accountData ?? this.accountData,
      accountPosition: accountPosition ?? this.accountPosition,
      screenState: screenState ?? this.screenState,
      modifyEvent: modifyEvent ?? this.modifyEvent,
      goBackEvent: goBackEvent ?? this.goBackEvent,
      copySnackBarEvent: copySnackBarEvent ?? this.copySnackBarEvent,
      popUpEvent: popUpEvent ?? this.popUpEvent,
    );
  }
}

sealed class DetailsScreenState extends Equatable {
  const DetailsScreenState();

  @override
  List<Object?> get props => [];
}

final class Loading extends DetailsScreenState {
  const Loading();
}

final class Loaded extends DetailsScreenState {
  const Loaded();
}

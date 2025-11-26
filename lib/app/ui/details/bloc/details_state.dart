import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

part 'details_state.freezed.dart';

@freezed
sealed class DetailsState with _$DetailsState {
  const factory DetailsState({
    required String? passwordString,
    required AccountData accountData,
    required int accountPosition,
    required DetailsScreenState screenState,
    required UIEvent<AccountData> modifyEvent,
    required UIEvent<void> goBackEvent,
    required UIEvent<void> copySnackBarEvent,
    required UIEvent<void> popUpEvent,
  }) = _DetailsState;

  factory DetailsState.initial() => DetailsState(
    passwordString: null,
    accountData: AccountData.empty(),
    accountPosition: 0,
    screenState: const DetailsScreenState.loading(),
    modifyEvent: const UIEvent(consumed: true),
    goBackEvent: const UIEvent(consumed: true),
    copySnackBarEvent: const UIEvent(consumed: true),
    popUpEvent: const UIEvent(consumed: true),
  );
}

@freezed
sealed class DetailsScreenState with _$DetailsScreenState {
  const factory DetailsScreenState.loading() = Loading;

  const factory DetailsScreenState.loaded() = Loaded;
}

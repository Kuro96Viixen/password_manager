import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';

part 'private_state.freezed.dart';

@freezed
sealed class PrivateState with _$PrivateState {
  const factory PrivateState({
    required List<AccountData> accountsList,
    required PrivateScreenState screenState,
    required UIEvent<AccountData> navigationEvent,
  }) = _PrivateState;

  factory PrivateState.initial() => const PrivateState(
        accountsList: [],
        screenState: PrivateScreenState.loading(),
        navigationEvent: UIEvent(consumed: true),
      );
}

@freezed
sealed class PrivateScreenState with _$PrivateScreenState {
  const factory PrivateScreenState.loading() = Loading;

  const factory PrivateScreenState.loaded({required String searchText}) =
      Loaded;
}

part of 'private_bloc.dart';

@freezed
class PrivateState with _$PrivateState {
  const factory PrivateState({
    required List<AccountData> accountsList,
    required PrivateScreenState screenState,
    PrivateNavigationState? navigationState,
  }) = _PrivateState;

  factory PrivateState.initial() => const PrivateState(
        accountsList: [],
        screenState: PrivateScreenState.loading(),
      );
}

@freezed
class PrivateScreenState with _$PrivateScreenState {
  const factory PrivateScreenState.loading() = _Loading;

  const factory PrivateScreenState.loaded({required String searchText}) =
      _Loaded;
}

@freezed
class PrivateNavigationState with _$PrivateNavigationState {
  const factory PrivateNavigationState.goToDetails({
    required AccountData accountData,
  }) = _GoToDetails;
}

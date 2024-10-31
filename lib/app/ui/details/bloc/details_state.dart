part of 'details_bloc.dart';

@freezed
class DetailsState with _$DetailsState {
  const factory DetailsState({
    required String passwordString,
    required AccountData accountData,
    required int accountPosition,
    DetailsNavigationState? navigationState,
  }) = _DetailsState;

  factory DetailsState.initial() => DetailsState(
        passwordString: Texts.hiddenPasswordText,
        accountData: AccountData.empty(),
        accountPosition: 0,
        navigationState: null,
      );
}

@freezed
class DetailsNavigationState with _$DetailsNavigationState {
  const factory DetailsNavigationState.goBack() = _GoBack;

  const factory DetailsNavigationState.goToModify() = _GoToModify;

  const factory DetailsNavigationState.showPopUp() = _ShowPopUp;

  const factory DetailsNavigationState.showSnackBar(String snackBarMessage) =
      _ShowSnackBar;
}

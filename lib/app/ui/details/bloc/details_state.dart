part of 'details_bloc.dart';

@freezed
class DetailsState with _$DetailsState {
  const factory DetailsState({
    required String passwordString,
    DetailsNavigationState? navigationState,
  }) = _DetailsState;

  factory DetailsState.initial() => DetailsState(
        passwordString: Texts.hiddenPasswordText,
        navigationState: null,
      );
}

@freezed
class DetailsNavigationState with _$DetailsNavigationState {
  const factory DetailsNavigationState.goBack() = _GoBack;

  const factory DetailsNavigationState.goToModify() = _goToModify;

  const factory DetailsNavigationState.showSnackBar(String snackBarMessage) =
      _ShowSnackBar;
}

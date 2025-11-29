part of 'details_view.dart';

Future<void> _showDeleteDialog(
  BuildContext context,
  AccountData accountData,
  DetailsState state,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      context.read<DetailsBloc>().add(
        const MarkPopUpAsConsumed(),
      );

      return DeleteDialog(
        title: AppLocalizations.of(
          context,
        )!.deleteDialogTitle,
        body:
            AppLocalizations.of(
              context,
            )!.deleteDialogBody(
              state.accountData.name,
            ),
        advice: AppLocalizations.of(
          context,
        )!.deleteDialogAdvice,
        onPressedConfirm: () {
          dialogContext.pop();

          context.read<DetailsBloc>().add(
            DeleteAccount(accountData),
          );
        },
        confirmButtonText: AppLocalizations.of(
          context,
        )!.deleteDialogConfirm,
        cancelButtonText: AppLocalizations.of(
          context,
        )!.deleteDialogCancel,
      );
    },
  );
}

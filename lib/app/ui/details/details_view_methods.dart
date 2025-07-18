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
            const DetailsEvent.markPopUpAsConsumed(),
          );

      return DeleteDialog(
        title: Texts.deleteDialogTitle,
        body: Texts.deleteDialogBody
            .replaceAll('{account}', state.accountData.name),
        advice: Texts.deleteDialogAdvice,
        onPressedConfirm: () {
          dialogContext.pop();

          context
              .read<DetailsBloc>()
              .add(DetailsEvent.deleteAccount(accountData));
        },
        confirmButtonText: Texts.deleteDialogConfirm,
        cancelButtonText: Texts.deleteDialogCancel,
      );
    },
  );
}

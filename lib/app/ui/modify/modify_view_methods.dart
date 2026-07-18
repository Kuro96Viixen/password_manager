part of 'modify_view.dart';

Future<void> _showInsecurePasswordDialog(
  BuildContext context,
  AccountData? accountData,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      context.read<ModifyBloc>().add(
        const MarkPopUpAsConsumed(),
      );

      return InfoDialog(
        title: AppLocalizations.of(
          context,
        )!.passwordStrengthWeakSaveTitle,
        body: AppLocalizations.of(
          context,
        )!.passwordStrengthWeakSaveDisclaimer,
        onPressedConfirm: () {
          dialogContext.pop();

          context.read<ModifyBloc>().add(
            SaveAccount(accountData),
          );
        },
        confirmButtonText: AppLocalizations.of(
          context,
        )!.passwordStrengthWeakSaveAnyway,
        cancelButtonText: AppLocalizations.of(
          context,
        )!.passwordStrengthWeakSaveReturn,
      );
    },
  );
}

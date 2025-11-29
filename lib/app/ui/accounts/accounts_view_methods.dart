part of 'accounts_view.dart';

void _showBottomMenu(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext bottomMenuContext) {
      context.read<AccountsBloc>().add(
        const AccountsMarkBottomMenuAsConsumed(),
      );

      return SafeArea(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                AppLocalizations.of(
                  context,
                )!.duplicatedPasswordCheckerSettingsDisclaimer,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text(
                  AppLocalizations.of(
                    context,
                  )!.duplicatedPasswordCheckerSettings,
                ),
                onPressed: () {
                  context
                    ..goWithRoute(
                      DuplicatedPasswordCheckerView.routeName,
                    )
                    ..pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                AppLocalizations.of(
                  context,
                )!.importExportDisclaimer,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text(
                  AppLocalizations.of(
                    context,
                  )!.exportAccounts,
                ),
                onPressed: () {
                  context.pop();

                  context.read<AccountsBloc>().add(
                    const AccountsExportAccounts(),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                child: Text(
                  AppLocalizations.of(
                    context,
                  )!.importAccounts,
                ),
                onPressed: () {
                  context.pop();

                  context.read<AccountsBloc>().add(
                    const AccountsImportAccounts(),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _showDialog(BuildContext context, ErrorType errorType) {
  showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(
            context,
          )!.dialogTitle,
          textAlign: TextAlign.center,
        ),
        content: Text(
          errorType == const ErrorType.pickFileException()
              ? AppLocalizations.of(
                  context,
                )!.dialogPickFileExceptionText
              : AppLocalizations.of(
                  context,
                )!.dialogPickFolderExceptionText,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: Text(
              AppLocalizations.of(
                context,
              )!.dialogButtonText,
            ),
          ),
        ],
      );
    },
  );
}

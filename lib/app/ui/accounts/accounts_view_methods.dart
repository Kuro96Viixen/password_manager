part of 'accounts_view.dart';

void _showBottomMenu(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext bottomMenuContext) {
      context.read<AccountsBloc>().add(
        const AccountsEvent.markBottomMenuAsConsumed(),
      );

      return SafeArea(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                Texts.duplicatedPasswordCheckerSettingsDisclaimer,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text(
                  Texts.duplicatedPasswordCheckerSettings,
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
                Texts.importExportDisclaimer,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text(Texts.exportAccounts),
                onPressed: () {
                  context.pop();

                  context.read<AccountsBloc>().add(
                    const AccountsEvent.exportAccounts(),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                child: Text(Texts.importAccounts),
                onPressed: () {
                  context.pop();

                  context.read<AccountsBloc>().add(
                    const AccountsEvent.importAccounts(),
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
          Texts.dialogTitle,
          textAlign: TextAlign.center,
        ),
        content: Text(
          errorType == const ErrorType.pickFileException()
              ? Texts.dialogPickFileExceptionText
              : Texts.dialogPickFolderExceptionText,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: Text(Texts.dialogButtonText),
          ),
        ],
      );
    },
  );
}

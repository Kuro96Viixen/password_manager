import 'package:flutter/material.dart';
import 'package:password_manager/l10n/app_localizations.dart';

class DuplicatedPasswordsCheckerLoadingBody extends StatelessWidget {
  const DuplicatedPasswordsCheckerLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            AppLocalizations.of(
              context,
            )!.duplicatedPasswordCheckerViewLoading,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

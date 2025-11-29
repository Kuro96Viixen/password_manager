import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/l10n/app_localizations.dart';

class DuplicatedPasswordsCheckerUniqueBody extends StatelessWidget {
  const DuplicatedPasswordsCheckerUniqueBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(
              context,
            )!.duplicatedPasswordCheckerViewUniqueCongrats,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          Text(
            AppLocalizations.of(
              context,
            )!.duplicatedPasswordCheckerViewUniqueBody,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              AppLocalizations.of(
                context,
              )!.duplicatedPasswordCheckerViewUniqueGoBack,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

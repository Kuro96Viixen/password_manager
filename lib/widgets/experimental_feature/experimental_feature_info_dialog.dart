import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/links.dart';
import 'package:password_manager/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperimentalFeatureInfoDialog extends StatelessWidget {
  const ExperimentalFeatureInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(
          context,
        )!.experimentalFeatureInfoDialogTitle,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.only(left: 24, top: 24, right: 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(
              context,
            )!.experimentalFeatureInfoDialogBody,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () => launchUrl(Uri.parse(Links.googlePlayLink)),
            child: Text(
              AppLocalizations.of(
                context,
              )!.experimentalFeatureInfoDialogPlayStore,
            ),
          ),
          TextButton(
            onPressed: () => launchUrl(Uri.parse(Links.gitHubLink)),
            child: Text(
              AppLocalizations.of(
                context,
              )!.experimentalFeatureInfoDialogGitHub,
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            AppLocalizations.of(
              context,
            )!.experimentalFeatureInfoDialogConfirm,
          ),
        ),
      ],
    );
  }
}

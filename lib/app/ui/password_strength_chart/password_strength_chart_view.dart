import 'package:flutter/material.dart';
import 'package:password_manager/l10n/generated/app_localizations.dart';
import 'package:password_manager/widgets/password_strength/widgets/password_strength_chart.dart';

class PasswordStrengthChartView extends StatelessWidget {
  static const routeName = 'PasswordStrengthChartViewRoute';

  const PasswordStrengthChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.passwordStrengthCrackChartTitle,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: PasswordStrengthChart(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                AppLocalizations.of(
                  context,
                )!.passwordStrengthCrackChartDisclaimer,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

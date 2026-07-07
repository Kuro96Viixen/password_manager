import 'package:flutter/material.dart';
import 'package:password_manager/app/core/extension/password_strength_extension.dart';
import 'package:password_manager/app/domain/model/password_strength.dart';
import 'package:password_manager/l10n/generated/app_localizations.dart';

class PasswordStrengthChecker extends StatelessWidget {
  final PasswordStrength strength;

  const PasswordStrengthChecker({
    required this.strength,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = strength.statusColor;
    final widthPercentage = strength.widthPercentage;

    final localizations = AppLocalizations.of(context)!;
    final strengthString = switch (strength) {
      PasswordStrength.unset => '',
      PasswordStrength.weak => localizations.passwordStrengthWeak,
      PasswordStrength.medium => localizations.passwordStrengthMedium,
      PasswordStrength.strong => localizations.passwordStrengthStrong,
      PasswordStrength.secure => localizations.passwordStrengthSecure,
    };

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          height: 20,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: statusColor,
              width: 2,
            ),
          ),
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  width: constraints.maxWidth * widthPercentage,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              );
            },
          ),
        ),
        if (strengthString.isNotEmpty) Text(strengthString),
      ],
    );
  }
}

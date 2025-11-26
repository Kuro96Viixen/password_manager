import 'package:flutter/material.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/l10n/app_localizations.dart';

class AccountTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final void Function(String) onChangedText;
  final bool isPasswordHidden;
  final VoidCallback? onPressed;

  const AccountTextField({
    required this.label,
    required this.initialValue,
    required this.onChangedText,
    super.key,
    this.isPasswordHidden = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChangedText,
      decoration: InputDecoration(
        labelText: label,
        hintText:
            label ==
                AppLocalizations.of(
                  context,
                )!.passwordLengthTextFieldLabel
            ? AppLocalizations.of(
                context,
              )!.passwordLengthTextFieldHint
            : null,
        suffixIcon:
            label ==
                AppLocalizations.of(
                  context,
                )!.passwordTextFieldLabel
            ? IconButton(
                icon: Icon(
                  isPasswordHidden
                      ? CommonIcons.seePassword
                      : CommonIcons.hidePassword,
                ),
                onPressed: onPressed,
                tooltip: isPasswordHidden
                    ? AppLocalizations.of(
                        context,
                      )!.seePasswordTooltip
                    : AppLocalizations.of(
                        context,
                      )!.hidePasswordTooltip,
              )
            : null,
      ),
      autocorrect: false,
      enableSuggestions: false,
      initialValue: initialValue,
      obscureText:
          label ==
              AppLocalizations.of(
                context,
              )!.passwordTextFieldLabel &&
          isPasswordHidden,
      keyboardType:
          label ==
              AppLocalizations.of(
                context,
              )!.passwordLengthTextFieldLabel
          ? TextInputType.number
          : label ==
                AppLocalizations.of(
                  context,
                )!.usernameTextFieldLabel
          ? TextInputType.emailAddress
          : TextInputType.name,
    );
  }
}

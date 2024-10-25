import 'package:flutter/material.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/texts.dart';

class AccountTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final Function(String) onChangedText;
  final bool isPasswordHidden;
  final VoidCallback? onPressed;

  const AccountTextField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChangedText,
    this.isPasswordHidden = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChangedText,
      decoration: InputDecoration(
        labelText: label,
        hintText: label == Texts.passwordLengthTextFieldLabel
            ? Texts.passwordLengthTextFieldHint
            : null,
        suffixIcon: label == Texts.passwordTextFieldLabel
            ? IconButton(
                icon: Icon(
                  isPasswordHidden
                      ? CommonIcons.seePassword
                      : CommonIcons.hidePassword,
                ),
                onPressed: onPressed,
                tooltip: isPasswordHidden
                    ? Texts.seePasswordTooltip
                    : Texts.hidePasswordTooltip,
              )
            : null,
      ),
      autocorrect: false,
      enableSuggestions: false,
      initialValue: initialValue,
      maxLines: 1,
      obscureText: label == Texts.passwordTextFieldLabel && isPasswordHidden,
      keyboardType: label == Texts.passwordLengthTextFieldLabel
          ? TextInputType.number
          : label == Texts.usernameTextFieldLabel
              ? TextInputType.emailAddress
              : TextInputType.name,
    );
  }
}

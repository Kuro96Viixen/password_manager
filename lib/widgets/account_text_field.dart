import 'package:flutter/material.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/texts.dart';

class AccountTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback? onPressed;

  const AccountTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPasswordVisible = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: label == Texts.passwordLengthTextFieldLabel
            ? Texts.passwordLengthTextFieldHint
            : null,
        suffixIcon: label == Texts.passwordTextFieldLabel
            ? IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? CommonIcons.hidePassword
                      : CommonIcons.seePassword,
                ),
                onPressed: onPressed,
                tooltip: isPasswordVisible
                    ? Texts.hidePasswordTooltip
                    : Texts.seePasswordTooltip,
              )
            : null,
      ),
      autocorrect: false,
      enableSuggestions: false,
      controller: controller,
      maxLines: 1,
      obscureText: label == Texts.passwordTextFieldLabel && !isPasswordVisible,
      keyboardType: label == Texts.passwordLengthTextFieldLabel
          ? TextInputType.number
          : label == Texts.usernameTextFieldLabel
              ? TextInputType.emailAddress
              : TextInputType.name,
    );
  }
}

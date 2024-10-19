import 'package:flutter/material.dart';
import 'package:password_manager/constants/texts.dart';

class AccountField extends StatelessWidget {
  final String text;
  final bool viewPassword;

  const AccountField({
    super.key,
    required this.text,
    this.viewPassword = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      viewPassword ? text : Texts.hiddenPasswordText,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 20.0,
      ),
    );
  }
}

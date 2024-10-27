import 'package:flutter/material.dart';

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
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 20.0,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AccountField extends StatelessWidget {
  final String text;
  final bool viewPassword;

  const AccountField({
    required this.text,
    super.key,
    this.viewPassword = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey, fontSize: 20),
    );
  }
}

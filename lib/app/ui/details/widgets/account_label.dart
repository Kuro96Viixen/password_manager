import 'package:flutter/material.dart';

class AccountLabel extends StatelessWidget {
  final String text;

  const AccountLabel({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.purple[100],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

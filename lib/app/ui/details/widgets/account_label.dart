import 'package:flutter/material.dart';

class AccountLabel extends StatelessWidget {
  final String text;

  const AccountLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Text(
          text,
          style: TextStyle(
            color: Colors.purple[100],
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}

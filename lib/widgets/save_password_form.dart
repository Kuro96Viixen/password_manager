import 'package:flutter/material.dart';
import 'package:password_manager/constants/texts.dart';

class SavePasswordForm extends StatelessWidget {
  final bool isPrivate;
  final Function(bool?) checkBoxAction;
  final VoidCallback onPressedButton;

  const SavePasswordForm({
    super.key,
    required this.isPrivate,
    required this.checkBoxAction,
    required this.onPressedButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CheckboxListTile(
            value: isPrivate,
            onChanged: checkBoxAction,
            title: Text(Texts.isPrivateAccountCheckBoxTitle),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: onPressedButton,
            child: Text(Texts.saveAccountButton),
          ),
        ],
      ),
    );
  }
}

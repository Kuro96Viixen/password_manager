import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onPressedConfirm;
  final String confirmButtonText;
  final String cancelButtonText;

  const InfoDialog({
    required this.title,
    required this.body,
    required this.onPressedConfirm,
    required this.confirmButtonText,
    required this.cancelButtonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(body, textAlign: TextAlign.center),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        Column(
          children: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                cancelButtonText,
              ),
            ),
            TextButton(
              onPressed: onPressedConfirm,
              child: Text(
                confirmButtonText,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

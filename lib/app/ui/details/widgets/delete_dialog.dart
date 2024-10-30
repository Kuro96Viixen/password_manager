import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteDialog extends StatefulWidget {
  final String title;
  final String body;
  final String advice;
  final VoidCallback onPressedConfirm;
  final String confirmButtonText;
  final String cancelButtonText;

  const DeleteDialog({
    super.key,
    required this.title,
    required this.body,
    required this.advice,
    required this.onPressedConfirm,
    required this.confirmButtonText,
    required this.cancelButtonText,
  });

  @override
  DeleteDialogState createState() => DeleteDialogState();
}

class DeleteDialogState extends State<DeleteDialog> {
  int _remainingSeconds = 5; // Initial countdown time
  Timer? _timer;
  bool _isEnabled = false; // Button is initially disabled

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the dialog is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
          _isEnabled = true; // Enable the button when the timer finishes
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.body,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            widget.advice,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                widget.cancelButtonText,
              ),
            ),
            TextButton(
              onPressed: _isEnabled ? widget.onPressedConfirm : null,
              child: Text(
                _isEnabled
                    ? widget.confirmButtonText
                    : '${widget.confirmButtonText} ($_remainingSeconds)',
                style: _isEnabled
                    ? TextStyle(color: Theme.of(context).colorScheme.error)
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

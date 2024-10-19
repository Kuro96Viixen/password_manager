import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/widgets/account_text_field.dart';

class RandomPasswordForm extends StatelessWidget {
  final TextEditingController passwordLengthController;
  final bool hasSpanishCharacters;
  final Function(bool?) onPressedSpanish;
  final bool hasNumbers;
  final Function(bool?) onPressedNumbers;
  final bool hasSymbols;
  final Function(bool?) onPressedSymbols;
  final String randomPassword;
  final VoidCallback onPressedButton;

  const RandomPasswordForm({
    super.key,
    required this.passwordLengthController,
    required this.hasSpanishCharacters,
    required this.onPressedSpanish,
    required this.hasNumbers,
    required this.onPressedNumbers,
    required this.hasSymbols,
    required this.onPressedSymbols,
    required this.randomPassword,
    required this.onPressedButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountTextField(
          label: Texts.passwordLengthTextFieldLabel,
          controller: passwordLengthController,
        ),
        const SizedBox(height: 8.0),
        CheckboxListTile(
          value: hasSpanishCharacters,
          onChanged: onPressedSpanish,
          title: Text(
            Texts.spanishCheckBoxTitle,
          ),
        ),
        const SizedBox(height: 8.0),
        CheckboxListTile(
          value: hasNumbers,
          onChanged: onPressedNumbers,
          title: Text(
            Texts.numbersCheckBoxTitle,
          ),
        ),
        CheckboxListTile(
          value: hasSymbols,
          onChanged: onPressedSymbols,
          title: Text(
            Texts.symbolsCheckBoxTitle,
          ),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: onPressedButton,
          child: Text(Texts.generateRandomPasswordButton),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Visibility(
          visible: randomPassword != '',
          child: GestureDetector(
            onLongPress: () =>
                Clipboard.setData(ClipboardData(text: randomPassword)).then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    Texts.copiedToClipboard,
                  ),
                ),
              ),
            ),
            child: Text(
              Texts.randomPasswordText + randomPassword,
              style: const TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

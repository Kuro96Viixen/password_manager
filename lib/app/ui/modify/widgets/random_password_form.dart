import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_bloc.dart';
import 'package:password_manager/app/ui/modify/widgets/account_text_field.dart';

class RandomPasswordForm extends StatelessWidget {
  final bool hasSpanishCharacters;
  final bool hasNumbersCharacters;
  final bool hasSymbolsCharacters;
  final String randomPassword;

  const RandomPasswordForm({
    required this.hasSpanishCharacters,
    required this.hasNumbersCharacters,
    required this.hasSymbolsCharacters,
    required this.randomPassword,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountTextField(
          label: Texts.passwordLengthTextFieldLabel,
          initialValue: '',
          onChangedText: (randomPasswordLength) =>
              context.read<ModifyBloc>().add(
                    ModifyEvent.onRandomPasswordLengthChanged(
                      randomPasswordLength,
                    ),
                  ),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          value: hasSpanishCharacters,
          onChanged: (hasSpanishCharacters) => context.read<ModifyBloc>().add(
                ModifyEvent.hasSpanishCharacters(hasSpanishCharacters: hasSpanishCharacters ?? false),
              ),
          title: Text(Texts.spanishCheckBoxTitle),
        ),
        CheckboxListTile(
          value: hasNumbersCharacters,
          onChanged: (hasNumbersCharacters) => context.read<ModifyBloc>().add(
                ModifyEvent.hasNumbersCharacters(hasNumbersCharacters: hasNumbersCharacters ?? false),
              ),
          title: Text(Texts.numbersCheckBoxTitle),
        ),
        CheckboxListTile(
          value: hasSymbolsCharacters,
          onChanged: (hasSymbolsCharacters) => context.read<ModifyBloc>().add(
                ModifyEvent.hasSymbolsCharacters(hasSymbolsCharacters: hasSymbolsCharacters ?? false),
              ),
          title: Text(Texts.symbolsCheckBoxTitle),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Remove focus on TextField
            FocusScope.of(context).unfocus();

            context
                .read<ModifyBloc>()
                .add(const ModifyEvent.generateRandomPassword());
          },
          child: Text(Texts.generateRandomPasswordButton),
        ),
        const SizedBox(
          height: 16,
        ),
        Visibility(
          visible: randomPassword != '',
          child: GestureDetector(
            onLongPress: () => context
                .read<ModifyBloc>()
                .add(ModifyEvent.copyPassword(randomPassword)),
            child: Text(
              Texts.randomPasswordText + randomPassword,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_bloc.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_event.dart';
import 'package:password_manager/app/ui/modify/widgets/account_text_field.dart';
import 'package:password_manager/l10n/app_localizations.dart';

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
          label: AppLocalizations.of(
            context,
          )!.passwordLengthTextFieldLabel,
          initialValue: '',
          onChangedText: (randomPasswordLength) =>
              context.read<ModifyBloc>().add(
                OnRandomPasswordLengthChanged(
                  randomPasswordLength,
                ),
              ),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          value: hasSpanishCharacters,
          onChanged: (hasSpanishCharacters) => context.read<ModifyBloc>().add(
            HasSpanishCharacters(
              hasSpanishCharacters: hasSpanishCharacters ?? false,
            ),
          ),
          title: Text(
            AppLocalizations.of(
              context,
            )!.spanishCheckBoxTitle,
          ),
        ),
        CheckboxListTile(
          value: hasNumbersCharacters,
          onChanged: (hasNumbersCharacters) => context.read<ModifyBloc>().add(
            HasNumbersCharacters(
              hasNumbersCharacters: hasNumbersCharacters ?? false,
            ),
          ),
          title: Text(
            AppLocalizations.of(
              context,
            )!.numbersCheckBoxTitle,
          ),
        ),
        CheckboxListTile(
          value: hasSymbolsCharacters,
          onChanged: (hasSymbolsCharacters) => context.read<ModifyBloc>().add(
            HasSymbolsCharacters(
              hasSymbolsCharacters: hasSymbolsCharacters ?? false,
            ),
          ),
          title: Text(
            AppLocalizations.of(
              context,
            )!.symbolsCheckBoxTitle,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Remove focus on TextField
            FocusScope.of(context).unfocus();

            context.read<ModifyBloc>().add(
              const GenerateRandomPassword(),
            );
          },
          child: Text(
            AppLocalizations.of(
              context,
            )!.generateRandomPasswordButton,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Visibility(
          visible: randomPassword != '',
          child: GestureDetector(
            onLongPress: () => context.read<ModifyBloc>().add(
              const CopyPassword(),
            ),
            child: Text(
              AppLocalizations.of(
                context,
              )!.randomPasswordText(randomPassword),
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

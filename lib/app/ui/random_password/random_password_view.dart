import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/ui/modify/widgets/account_text_field.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_bloc.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_event.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_state.dart';

class RandomPasswordView extends StatelessWidget {
  static const routeName = 'RandomPasswordViewRoute';

  const RandomPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uiModulesDi<RandomPasswordBloc>(),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  Texts.randomPasswordViewTitle,
                  style: const TextStyle(fontSize: 18),
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(4),
                  child: Divider(height: 4),
                ),
              ),
              body: BlocConsumer<RandomPasswordBloc, RandomPasswordState>(
                listenWhen: (previous, current) =>
                    previous.snackBarEvent != current.snackBarEvent,
                listener: (context, state) {
                  if (!state.snackBarEvent.consumed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.snackBarEvent.data!)),
                    );

                    context.read<RandomPasswordBloc>().add(
                          const RandomPasswordEvent
                              .markSnackBarEventAsConsumed(),
                        );
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AccountTextField(
                                    label: Texts.passwordLengthTextFieldLabel,
                                    initialValue: '',
                                    onChangedText: (randomPasswordLength) =>
                                        context.read<RandomPasswordBloc>().add(
                                              RandomPasswordEvent
                                                  .onRandomPasswordLengthChanged(
                                                randomPasswordLength,
                                              ),
                                            ),
                                  ),
                                  const SizedBox(height: 8),
                                  CheckboxListTile(
                                    value: state.hasSpanishCharacters,
                                    onChanged: (hasSpanishCharacters) => context
                                        .read<RandomPasswordBloc>()
                                        .add(
                                          RandomPasswordEvent
                                              .hasSpanishCharacters(
                                            hasSpanishCharacters:
                                                hasSpanishCharacters ?? false,
                                          ),
                                        ),
                                    title: Text(
                                      Texts.spanishCheckBoxTitle,
                                    ),
                                  ),
                                  CheckboxListTile(
                                    value: state.hasNumbersCharacters,
                                    onChanged: (hasNumbersCharacters) => context
                                        .read<RandomPasswordBloc>()
                                        .add(
                                          RandomPasswordEvent
                                              .hasNumbersCharacters(
                                            hasNumbersCharacters:
                                                hasNumbersCharacters ?? false,
                                          ),
                                        ),
                                    title: Text(Texts.numbersCheckBoxTitle),
                                  ),
                                  CheckboxListTile(
                                    value: state.hasSymbolsCharacters,
                                    onChanged: (hasSymbolsCharacters) => context
                                        .read<RandomPasswordBloc>()
                                        .add(
                                          RandomPasswordEvent
                                              .hasSymbolsCharacters(
                                            hasSymbolsCharacters:
                                                hasSymbolsCharacters ?? false,
                                          ),
                                        ),
                                    title: Text(Texts.symbolsCheckBoxTitle),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Remove focus on TextField
                                      FocusScope.of(context).unfocus();

                                      context.read<RandomPasswordBloc>().add(
                                            const RandomPasswordEvent
                                                .generateRandomPassword(),
                                          );
                                    },
                                    child: Text(
                                      Texts.generateRandomPasswordButton,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Visibility(
                                    visible: state.randomPassword != '',
                                    child: GestureDetector(
                                      onLongPress: () => context
                                          .read<RandomPasswordBloc>()
                                          .add(
                                            const RandomPasswordEvent
                                                .copyPassword(),
                                          ),
                                      child: Text(
                                        Texts.randomPasswordText +
                                            state.randomPassword,
                                        style: const TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          Texts.randomPasswordDisclaimer,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

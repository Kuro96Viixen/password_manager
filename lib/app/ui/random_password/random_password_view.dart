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
                  style: TextStyle(fontSize: 18),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(4.0),
                  child: Divider(
                    height: 4.0,
                  ),
                ),
              ),
              body: BlocConsumer<RandomPasswordBloc, RandomPasswordState>(
                listener: (context, state) {
                  state.navigationState?.when(
                    showSnackBar: (snackBarMessage) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          snackBarMessage,
                        ),
                      ),
                    ),
                  );
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  const SizedBox(height: 8.0),
                                  CheckboxListTile(
                                    value: state.hasSpanishCharacters,
                                    onChanged: (hasSpanishCharacters) =>
                                        context.read<RandomPasswordBloc>().add(
                                              RandomPasswordEvent
                                                  .hasSpanishCharacters(
                                                hasSpanishCharacters ?? false,
                                              ),
                                            ),
                                    title: Text(
                                      Texts.spanishCheckBoxTitle,
                                    ),
                                  ),
                                  CheckboxListTile(
                                    value: state.hasNumbersCharacters,
                                    onChanged: (hasNumbersCharacters) =>
                                        context.read<RandomPasswordBloc>().add(
                                              RandomPasswordEvent
                                                  .hasNumbersCharacters(
                                                hasNumbersCharacters ?? false,
                                              ),
                                            ),
                                    title: Text(
                                      Texts.numbersCheckBoxTitle,
                                    ),
                                  ),
                                  CheckboxListTile(
                                    value: state.hasSymbolsCharacters,
                                    onChanged: (hasSymbolsCharacters) =>
                                        context.read<RandomPasswordBloc>().add(
                                              RandomPasswordEvent
                                                  .hasSymbolsCharacters(
                                                hasSymbolsCharacters ?? false,
                                              ),
                                            ),
                                    title: Text(
                                      Texts.symbolsCheckBoxTitle,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
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
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Visibility(
                                    visible: state.randomPassword != '',
                                    child: GestureDetector(
                                      onLongPress: () => context
                                          .read<RandomPasswordBloc>()
                                          .add(
                                            RandomPasswordEvent.copyPassword(),
                                          ),
                                      child: Text(
                                        Texts.randomPasswordText +
                                            state.randomPassword,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                        ),
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
                          style: TextStyle(fontSize: 10),
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

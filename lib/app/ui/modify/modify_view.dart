import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_bloc.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_event.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_state.dart';
import 'package:password_manager/app/ui/modify/widgets/account_text_field.dart';
import 'package:password_manager/app/ui/modify/widgets/random_password_form.dart';
import 'package:password_manager/l10n/app_localizations.dart';

class ModifyView extends StatelessWidget {
  static const routeName = '/ModifyPageRoute';

  final AccountData? accountData;

  const ModifyView({
    required this.accountData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          uiModulesDi<ModifyBloc>()..add(ModifyEvent.started(accountData)),
      child: BlocConsumer<ModifyBloc, ModifyState>(
        listenWhen: (previous, current) {
          final hasGoBackEvent = previous.goBackEvent != current.goBackEvent;

          final hasCopySnackBarEvent =
              previous.copySnackBarEvent != current.copySnackBarEvent;

          return hasGoBackEvent || hasCopySnackBarEvent;
        },
        listener: (context, state) {
          if (!state.goBackEvent.consumed) {
            context.pop(true);
          }

          if (!state.copySnackBarEvent.consumed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.copiedToClipboard,
                ),
              ),
            );

            context.read<ModifyBloc>().add(
              const ModifyEvent.markCopySnackBarAsConsumed(),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  accountData == null
                      ? AppLocalizations.of(
                          context,
                        )!.addViewTitle
                      : AppLocalizations.of(
                          context,
                        )!.editViewTitle,
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(4),
                  child: Divider(height: 4),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Column(
                          children: [
                            AccountTextField(
                              label: AppLocalizations.of(
                                context,
                              )!.nameTextFieldLabel,
                              initialValue: accountData?.name ?? '',
                              onChangedText: (nameString) => context
                                  .read<ModifyBloc>()
                                  .add(ModifyEvent.onNameChanged(nameString)),
                            ),
                            AccountTextField(
                              label: AppLocalizations.of(
                                context,
                              )!.usernameTextFieldLabel,
                              initialValue: accountData?.username ?? '',
                              onChangedText: (usernameString) =>
                                  context.read<ModifyBloc>().add(
                                    ModifyEvent.onUsernameChanged(
                                      usernameString,
                                    ),
                                  ),
                            ),
                            const SizedBox(height: 8),
                            SwitchListTile(
                              value:
                                  state.screenState ==
                                  const ModifyScreenState.randomForm(),
                              onChanged: (isRandomPasswordForm) {
                                // Remove focus on TextField
                                FocusScope.of(context).unfocus();

                                context.read<ModifyBloc>().add(
                                  ModifyEvent.onChangePasswordForm(
                                    isRandomPasswordForm: isRandomPasswordForm,
                                  ),
                                );
                              },
                              title: Text(
                                AppLocalizations.of(
                                  context,
                                )!.useRandomPasswordSwitchTitle,
                              ),
                            ),
                            state.screenState.when(
                              passwordForm: () => AccountTextField(
                                label: AppLocalizations.of(
                                  context,
                                )!.passwordTextFieldLabel,
                                initialValue: '',
                                onChangedText: (passwordString) =>
                                    context.read<ModifyBloc>().add(
                                      ModifyEvent.onPasswordChanged(
                                        passwordString,
                                      ),
                                    ),
                                isPasswordHidden: state.isPasswordHidden,
                                onPressed: () => context.read<ModifyBloc>().add(
                                  const ModifyEvent.hidePassword(),
                                ),
                              ),
                              randomForm: () => RandomPasswordForm(
                                hasSpanishCharacters:
                                    state.hasSpanishCharacters,
                                hasNumbersCharacters:
                                    state.hasNumbersCharacters,
                                hasSymbolsCharacters:
                                    state.hasSymbolsCharacters,
                                randomPassword: state.randomPassword,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: state.canBeSaved,
                    child: Column(
                      children: [
                        CheckboxListTile(
                          value: state.isPrivateAccount,
                          onChanged: (isPrivateAccount) =>
                              context.read<ModifyBloc>().add(
                                ModifyEvent.setIsPrivateAccount(
                                  isPrivateAccount: isPrivateAccount ?? false,
                                ),
                              ),
                          title: Text(
                            AppLocalizations.of(
                              context,
                            )!.isPrivateAccountCheckBoxTitle,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => context.read<ModifyBloc>().add(
                            ModifyEvent.saveAccount(accountData),
                          ),
                          child: Text(
                            AppLocalizations.of(
                              context,
                            )!.saveAccountButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

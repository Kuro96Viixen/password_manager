import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/core/extension/context_extension.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/accounts/accounts_view.dart';
import 'package:password_manager/app/ui/details/details_view.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_bloc.dart';
import 'package:password_manager/app/ui/modify/widgets/account_text_field.dart';
import 'package:password_manager/app/ui/modify/widgets/random_password_form.dart';
import 'package:password_manager/app/ui/private/private_view.dart';

class ModifyView extends StatelessWidget {
  static const routeName = 'ModifyPageRoute';

  final AccountData? accountData;

  const ModifyView({required this.accountData, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          uiModulesDi<ModifyBloc>()..add(ModifyEvent.started(accountData)),
      child: BlocConsumer<ModifyBloc, ModifyState>(
        listener: (context, state) {
          state.navigationState?.when(
            goBack: () {
              if (context.previousRoute.contains(DetailsView.routeName)) {
                DetailsView.modifyCompleter.complete();
              }

              if (context.previousRoute.contains(PrivateView.routeName)) {
                PrivateView.modifyCompleter.complete();
              } else {
                AccountsView.modifyCompleter.complete();
              }

              context.pop();
            },
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
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  accountData == null
                      ? Texts.addViewTitle
                      : Texts.editViewTitle,
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
                              label: Texts.nameTextFieldLabel,
                              initialValue: accountData?.name ?? '',
                              onChangedText: (nameString) => context
                                  .read<ModifyBloc>()
                                  .add(ModifyEvent.onNameChanged(nameString)),
                            ),
                            AccountTextField(
                              label: Texts.usernameTextFieldLabel,
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
                              value: state.screenState ==
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
                                Texts.useRandomPasswordSwitchTitle,
                              ),
                            ),
                            state.screenState.when(
                              passwordForm: () => AccountTextField(
                                label: Texts.passwordTextFieldLabel,
                                initialValue: '',
                                onChangedText: (passwordString) =>
                                    context.read<ModifyBloc>().add(
                                          ModifyEvent.onPasswordChanged(
                                            passwordString,
                                          ),
                                        ),
                                isPasswordHidden: state.isPasswordHidden,
                                onPressed: () => context
                                    .read<ModifyBloc>()
                                    .add(const ModifyEvent.hidePassword()),
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
                          title: Text(Texts.isPrivateAccountCheckBoxTitle),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => context
                              .read<ModifyBloc>()
                              .add(ModifyEvent.saveAccount(accountData)),
                          child: Text(Texts.saveAccountButton),
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

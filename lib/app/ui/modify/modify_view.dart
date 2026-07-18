import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/core/extension/context_extension.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_bloc.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_event.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_state.dart';
import 'package:password_manager/app/ui/modify/widgets/account_text_field.dart';
import 'package:password_manager/app/ui/modify/widgets/random_password_form.dart';
import 'package:password_manager/app/ui/modify/widgets/user_password_form.dart';
import 'package:password_manager/app/ui/password_strength_chart/password_strength_chart_view.dart';
import 'package:password_manager/l10n/generated/app_localizations.dart';
import 'package:password_manager/widgets/info_dialog.dart';

part 'modify_view_methods.dart';

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
          uiModulesDi<ModifyBloc>()..add(ModifyStarted(accountData)),
      child: BlocConsumer<ModifyBloc, ModifyState>(
        listenWhen: (previous, current) {
          final hasGoBackEvent = previous.goBackEvent != current.goBackEvent;

          final hasCopySnackBarEvent =
              previous.copySnackBarEvent != current.copySnackBarEvent;

          final hasPopUpEvent = previous.popUpEvent != current.popUpEvent;

          return hasGoBackEvent || hasCopySnackBarEvent || hasPopUpEvent;
        },
        listener: (context, state) async {
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
              const MarkCopySnackBarAsConsumed(),
            );
          }

          if (!state.popUpEvent.consumed) {
            if (context.mounted) {
              await _showInsecurePasswordDialog(context, accountData);
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
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
                actions: [
                  IconButton(
                    onPressed: () => context.goWithRoute(
                      PasswordStrengthChartView.routeName,
                    ),
                    icon: Icon(CommonIcons.info),
                  ),
                ],
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(4),
                  child: Divider(height: 4),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              AccountTextField(
                                label: AppLocalizations.of(
                                  context,
                                )!.nameTextFieldLabel,
                                initialValue: accountData?.name ?? '',
                                onChangedText: (nameString) => context
                                    .read<ModifyBloc>()
                                    .add(OnNameChanged(nameString)),
                              ),
                              AccountTextField(
                                label: AppLocalizations.of(
                                  context,
                                )!.usernameTextFieldLabel,
                                initialValue: accountData?.username ?? '',
                                onChangedText: (usernameString) =>
                                    context.read<ModifyBloc>().add(
                                      OnUsernameChanged(
                                        usernameString,
                                      ),
                                    ),
                              ),
                              const SizedBox(height: 8),
                              SwitchListTile(
                                value: state.screenState == const RandomForm(),
                                onChanged: (isRandomPasswordForm) {
                                  // Remove focus on TextField
                                  FocusScope.of(context).unfocus();

                                  context.read<ModifyBloc>().add(
                                    OnChangePasswordForm(
                                      isRandomPasswordForm:
                                          isRandomPasswordForm,
                                    ),
                                  );
                                },
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.useRandomPasswordSwitchTitle,
                                ),
                              ),
                              switch (state.screenState) {
                                PasswordForm() => UserPasswordForm(
                                  passwordStrength: state.passwordStrength,
                                  isPasswordHidden: state.isPasswordHidden,
                                ),
                                RandomForm() => RandomPasswordForm(
                                  hasSpanishCharacters:
                                      state.hasSpanishCharacters,
                                  hasNumbersCharacters:
                                      state.hasNumbersCharacters,
                                  hasSymbolsCharacters:
                                      state.hasSymbolsCharacters,
                                  randomPassword: state.randomPassword,
                                  passwordStrength: state.passwordStrength,
                                ),
                              },
                              const SizedBox(height: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Visibility(
                visible: state.canBeSaved,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CheckboxListTile(
                      value: state.isPrivateAccount,
                      onChanged: (isPrivateAccount) =>
                          context.read<ModifyBloc>().add(
                            SetIsPrivateAccount(
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
                        OnSavedPressed(accountData),
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
            ),
          );
        },
      ),
    );
  }
}

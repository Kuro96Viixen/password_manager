import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/core/extension/context_extension.dart';
import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/accounts/accounts_view.dart';
import 'package:password_manager/app/ui/details/bloc/details_bloc.dart';
import 'package:password_manager/app/ui/details/widgets/account_field.dart';
import 'package:password_manager/app/ui/details/widgets/account_label.dart';
import 'package:password_manager/app/ui/details/widgets/delete_dialog.dart';
import 'package:password_manager/app/ui/modify/modify_view.dart';
import 'package:password_manager/app/ui/private/private_view.dart';
import 'package:password_manager/widgets/loader.dart';

class DetailsView extends StatelessWidget {
  static const routeName = 'DetailsPageRoute';

  static late Completer<void> modifyCompleter;

  final AccountData accountData;

  const DetailsView({
    super.key,
    required this.accountData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uiModulesDi<DetailsBloc>()
        ..add(
          DetailsEvent.started(accountData),
        ),
      child: BlocConsumer<DetailsBloc, DetailsState>(
        listener: (context, state) {
          state.navigationState?.when(
            goBack: () {
              if (context.previousRoute.contains(PrivateView.routeName)) {
                PrivateView.isFinishedEdition = true;
                PrivateView.modifyCompleter.complete();
              } else {
                AccountsView.isFinishedEdition = true;
                AccountsView.modifyCompleter.complete();
              }
              context.pop();
            },
            goToModify: (accountData) async {
              modifyCompleter = Completer<void>();

              context.goWithRoute(
                ModifyView.routeName,
                extra: accountData,
              );

              await modifyCompleter.future;

              if (context.mounted) {
                context.read<DetailsBloc>().add(
                      DetailsEvent.started(accountData),
                    );
              }
            },
            showPopUp: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return DeleteDialog(
                    title: Texts.deleteDialogTitle,
                    body: Texts.deleteDialogBody
                        .replaceAll('{account}', state.accountData.name),
                    advice: Texts.deleteDialogAdvice,
                    onPressedConfirm: () {
                      dialogContext.pop();

                      context
                          .read<DetailsBloc>()
                          .add(DetailsEvent.deleteAccount(accountData));
                    },
                    confirmButtonText: Texts.deleteDialogConfirm,
                    cancelButtonText: Texts.deleteDialogCancel,
                  );
                },
              );
            },
            showSnackBar: (snackBarMessage) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    snackBarMessage,
                  ),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: () => context
                      .read<DetailsBloc>()
                      .add(const DetailsEvent.pressedBack()),
                ),
                title: Text(
                  Texts.viewAccountViewTitle,
                ),
                actions: [
                  IconButton(
                    onPressed: () => context
                        .read<DetailsBloc>()
                        .add(const DetailsEvent.pressedDelete()),
                    icon: Icon(
                      CommonIcons.delete,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(4.0),
                  child: Divider(
                    height: 4.0,
                  ),
                ),
              ),
              body: Column(
                children: [
                  state.screenState.when(
                    loading: () => Loader(),
                    loaded: () => SizedBox(
                      height: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AccountLabel(
                          text: Texts.viewAccountNameLabel,
                        ),
                        AccountField(
                          text: state.accountData.name,
                        ),
                        AccountLabel(
                          text: Texts.viewAccountUsernameLabel,
                        ),
                        AccountField(
                          text: state.accountData.username,
                        ),
                        AccountLabel(
                          text: Texts.viewAccountPasswordLabel,
                        ),
                        GestureDetector(
                          onLongPress: () {
                            context.read<DetailsBloc>().add(
                                  DetailsEvent.copyPassword(
                                    Password(
                                      password: state.accountData.password,
                                      iv: state.accountData.passwordIV,
                                    ),
                                  ),
                                );
                          },
                          child: AccountField(
                            text: state.screenState.when(
                              loading: () => '',
                              loaded: () => state.passwordString,
                            ),
                            viewPassword: true,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Visibility(
                          visible:
                              state.passwordString == Texts.hiddenPasswordText,
                          child: Center(
                            child: ElevatedButton(
                              child: Text(Texts.viewAccountViewPassword),
                              onPressed: () => context.read<DetailsBloc>().add(
                                    DetailsEvent.revealPassword(
                                      Password(
                                        password: state.accountData.password,
                                        iv: state.accountData.passwordIV,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context
                    .read<DetailsBloc>()
                    .add(const DetailsEvent.pressedModify()),
                tooltip: Texts.viewAccountViewEditTooltip,
                child: Icon(CommonIcons.edit),
              ),
            ),
          );
        },
      ),
    );
  }
}

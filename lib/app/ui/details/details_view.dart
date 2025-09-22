import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/details/bloc/details_bloc.dart';
import 'package:password_manager/app/ui/details/bloc/details_event.dart';
import 'package:password_manager/app/ui/details/bloc/details_state.dart';
import 'package:password_manager/app/ui/details/widgets/account_field.dart';
import 'package:password_manager/app/ui/details/widgets/account_label.dart';
import 'package:password_manager/app/ui/details/widgets/delete_dialog.dart';
import 'package:password_manager/app/ui/modify/modify_view.dart';
import 'package:password_manager/widgets/loader.dart';

part 'details_view_methods.dart';

class DetailsView extends StatelessWidget {
  static const routeName = '/DetailsPageRoute';

  final AccountData accountData;

  const DetailsView({
    required this.accountData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uiModulesDi<DetailsBloc>()
        ..add(
          DetailsEvent.started(accountData),
        ),
      child: BlocConsumer<DetailsBloc, DetailsState>(
        listenWhen: (previous, current) {
          final hasModifyEvent = previous.modifyEvent != current.modifyEvent;

          final hasSnackBarEvent =
              previous.snackBarEvent != current.snackBarEvent;

          final hasPopUpEvent = previous.popUpEvent != current.popUpEvent;

          return hasModifyEvent || hasSnackBarEvent || hasPopUpEvent;
        },
        listener: (context, state) async {
          if (!state.modifyEvent.consumed) {
            final bloc = context.read<DetailsBloc>();

            final success = await context.push<bool>(
              ModifyView.routeName,
              extra: state.modifyEvent.data,
            );

            if (success != null && success) {
              bloc
                ..add(
                  const DetailsEvent.markModifyAsConsumed(),
                )
                ..add(DetailsEvent.started(accountData));
            }
          }

          if (!state.goBackEvent.consumed) {
            if (context.mounted) {
              context.pop(true);
            }
          }

          if (!state.snackBarEvent.consumed) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.snackBarEvent.data!,
                  ),
                ),
              );

              context.read<DetailsBloc>().add(
                const DetailsEvent.markSnackBarAsConsumed(),
              );
            }
          }

          if (!state.popUpEvent.consumed) {
            if (context.mounted) {
              await _showDeleteDialog(context, accountData, state);
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: PopScope(
              canPop: false,
              onPopInvokedWithResult: (bool didPop, Object? _) {
                if (didPop) {
                  return;
                }

                context.pop(true);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(Texts.viewAccountViewTitle),
                  leading: BackButton(
                    onPressed: () => context.pop(true),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => context.read<DetailsBloc>().add(
                        const DetailsEvent.pressedDelete(),
                      ),
                      icon: Icon(CommonIcons.delete),
                    ),
                  ],
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(4),
                    child: Divider(height: 4),
                  ),
                ),
                body: Column(
                  children: [
                    state.screenState.when(
                      loading: () => const Loader(),
                      loaded: () => const SizedBox(height: 4),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AccountLabel(text: Texts.viewAccountNameLabel),
                          AccountField(text: state.accountData.name),
                          AccountLabel(text: Texts.viewAccountUsernameLabel),
                          AccountField(text: state.accountData.username),
                          AccountLabel(text: Texts.viewAccountPasswordLabel),
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
                            ),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible:
                                state.passwordString ==
                                Texts.hiddenPasswordText,
                            child: Center(
                              child: ElevatedButton(
                                child: Text(Texts.viewAccountViewPassword),
                                onPressed: () =>
                                    context.read<DetailsBloc>().add(
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
                  onPressed: () => context.read<DetailsBloc>().add(
                    const DetailsEvent.pressedModify(),
                  ),
                  tooltip: Texts.viewAccountViewEditTooltip,
                  child: Icon(CommonIcons.edit),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

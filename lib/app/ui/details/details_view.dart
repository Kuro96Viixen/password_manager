import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/details/bloc/details_bloc.dart';
import 'package:password_manager/app/ui/details/bloc/details_event.dart';
import 'package:password_manager/app/ui/details/bloc/details_state.dart';
import 'package:password_manager/app/ui/details/widgets/account_field.dart';
import 'package:password_manager/app/ui/details/widgets/account_label.dart';
import 'package:password_manager/app/ui/details/widgets/delete_dialog.dart';
import 'package:password_manager/app/ui/modify/modify_view.dart';
import 'package:password_manager/l10n/app_localizations.dart';
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
          DetailsStarted(accountData),
        ),
      child: BlocConsumer<DetailsBloc, DetailsState>(
        listenWhen: (previous, current) {
          final hasModifyEvent = previous.modifyEvent != current.modifyEvent;

          final hasCopySnackBarEvent =
              previous.copySnackBarEvent != current.copySnackBarEvent;

          final hasPopUpEvent = previous.popUpEvent != current.popUpEvent;

          return hasModifyEvent || hasCopySnackBarEvent || hasPopUpEvent;
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
                  const MarkModifyAsConsumed(),
                )
                ..add(DetailsStarted(accountData));
            }
          }

          if (!state.goBackEvent.consumed) {
            if (context.mounted) {
              context.pop(true);
            }
          }

          if (!state.copySnackBarEvent.consumed) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(
                      context,
                    )!.copiedToClipboard,
                  ),
                ),
              );

              context.read<DetailsBloc>().add(
                const MarkCopySnackBarAsConsumed(),
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
                  title: Text(
                    AppLocalizations.of(
                      context,
                    )!.viewAccountViewTitle,
                  ),
                  leading: BackButton(
                    onPressed: () => context.pop(true),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => context.read<DetailsBloc>().add(
                        const PressedDelete(),
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
                    switch (state.screenState) {
                      Loading() => const Loader(),
                      Loaded() => const SizedBox(height: 4),
                    },
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AccountLabel(
                            text: AppLocalizations.of(
                              context,
                            )!.viewAccountNameLabel,
                          ),
                          AccountField(text: state.accountData.name),
                          AccountLabel(
                            text: AppLocalizations.of(
                              context,
                            )!.viewAccountUsernameLabel,
                          ),
                          AccountField(text: state.accountData.username),
                          AccountLabel(
                            text: AppLocalizations.of(
                              context,
                            )!.viewAccountPasswordLabel,
                          ),
                          GestureDetector(
                            onLongPress: () {
                              context.read<DetailsBloc>().add(
                                const CopyPassword(),
                              );
                            },
                            child: AccountField(
                              text: switch (state.screenState) {
                                Loading() => '',
                                Loaded() =>
                                  state.passwordString ??
                                      AppLocalizations.of(
                                        context,
                                      )!.hiddenPasswordText,
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible:
                                state.passwordString ==
                                AppLocalizations.of(
                                  context,
                                )!.hiddenPasswordText,
                            child: Center(
                              child: ElevatedButton(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.viewAccountViewPassword,
                                ),
                                onPressed: () =>
                                    context.read<DetailsBloc>().add(
                                      const RevealPassword(),
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
                    const PressedModify(),
                  ),
                  tooltip: AppLocalizations.of(
                    context,
                  )!.viewAccountViewEditTooltip,
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

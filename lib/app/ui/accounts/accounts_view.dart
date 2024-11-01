import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/core/extension/context_extension.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/domain/model/error_type.dart';
import 'package:password_manager/app/ui/accounts/bloc/accounts_bloc.dart';
import 'package:password_manager/app/ui/accounts/widgets/account_list_tile.dart';
import 'package:password_manager/app/ui/details/details_view.dart';
import 'package:password_manager/app/ui/modify/modify_view.dart';
import 'package:password_manager/widgets/custom_app_bar.dart';
import 'package:password_manager/widgets/loader.dart';

class AccountsView extends StatelessWidget {
  static const routeName = '/AccountsPageRoute';

  const AccountsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uiModulesDi<AccountsBloc>(),
      child: BlocConsumer<AccountsBloc, AccountsState>(
        listener: (context, state) {
          state.navigationState?.when(
            goToDetails: (accountData) => context.goWithRoute(
              DetailsView.routeName,
              extra: accountData,
            ),
            goToModify: () => context.goWithRoute(ModifyView.routeName),
            showBottomMenu: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext bottomMenuContext) {
                  return Wrap(
                    children: [
                      Center(
                        child: ElevatedButton(
                          child: Text(Texts.exportAccounts),
                          onPressed: () {
                            context.pop();

                            context
                                .read<AccountsBloc>()
                                .add(const AccountsEvent.exportAccounts());
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Center(
                        child: ElevatedButton(
                          child: Text(Texts.importAccounts),
                          onPressed: () {
                            context.pop();

                            context
                                .read<AccountsBloc>()
                                .add(const AccountsEvent.importAccounts());
                          },
                        ),
                      ),
                    ],
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
            showDialog: (errorType) {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text(
                      Texts.dialogTitle,
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      errorType == const ErrorType.pickFileException()
                          ? Texts.dialogPickFileExceptionText
                          : Texts.dialogPickFolderExceptionText,
                      textAlign: TextAlign.center,
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => dialogContext.pop(),
                        child: Text(Texts.dialogButtonText),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        builder: (context, state) {
          return FocusDetector(
            onFocusGained: () => context.read<AccountsBloc>().add(
                  const AccountsEvent.started(
                    String.fromEnvironment('encryption_key'),
                  ),
                ),
            child: SafeArea(
              child: Scaffold(
                appBar: CustomAppBar(
                  leading: (state.arePrivateAccounts)
                      ? BackButton(
                          onPressed: () {
                            // Remove focus on TextField
                            FocusScope.of(context).unfocus();

                            context.read<AccountsBloc>().add(
                                  const AccountsEvent.closePrivate(),
                                );
                          },
                        )
                      : null,
                  title: Text(
                    state.arePrivateAccounts
                        ? Texts.privateAccountsViewTitle
                        : Texts.accountsViewTitle,
                  ),
                  actions: (!state.arePrivateAccounts)
                      ? [
                          IconButton(
                            onPressed: () {
                              // Remove focus on TextField
                              FocusScope.of(context).unfocus();

                              context
                                  .read<AccountsBloc>()
                                  .add(const AccountsEvent.showPrivate());
                            },
                            icon: Icon(
                              CommonIcons.private,
                            ),
                            tooltip: Texts.showPrivateTooltip,
                          ),
                          IconButton(
                            onPressed: () {
                              // Remove focus on TextField
                              FocusManager.instance.primaryFocus!.unfocus();

                              context
                                  .read<AccountsBloc>()
                                  .add(const AccountsEvent.showSettings());
                            },
                            icon: Icon(
                              CommonIcons.settings,
                            ),
                            tooltip: Texts.settingsTooltip,
                          ),
                        ]
                      : null,
                ),
                body: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                    children: [
                      state.screenState.when(
                        loading: () => Loader(),
                        loaded: (_) => SizedBox(height: 4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: TextField(
                          onChanged: (searchText) =>
                              context.read<AccountsBloc>().add(
                                    AccountsEvent.searchAccount(searchText),
                                  ),
                          decoration: InputDecoration(
                            hintText: Texts.searchHintText,
                          ),
                        ),
                      ),
                      state.screenState.when(
                        loading: () => Container(),
                        loaded: (searchText) => Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => (state
                                        .accountsList[index].name
                                        .toLowerCase()
                                        .startsWith(searchText) &&
                                    ((!state.accountsList[index].private ==
                                            !state.arePrivateAccounts) ||
                                        (state.accountsList[index].private ==
                                            state.arePrivateAccounts)))
                                ? AccountListTile(
                                    index: index,
                                    account: state.accountsList[index],
                                  )
                                : Container(),
                            itemCount: state.accountsList.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => context.read<AccountsBloc>().add(
                        const AccountsEvent.pressedModify(),
                      ),
                  tooltip: Texts.addNewAccountTooltip,
                  child: Icon(
                    CommonIcons.add,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

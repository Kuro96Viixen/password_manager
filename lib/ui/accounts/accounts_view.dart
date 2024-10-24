import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/core/extension/context_extension.dart';
import 'package:password_manager/di/app_di.dart';
import 'package:password_manager/ui/accounts/bloc/accounts_bloc.dart';
import 'package:password_manager/ui/details/details_view.dart';
import 'package:password_manager/widgets/account_list_tile.dart';
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
            goToModify: () {
              // TODO Implement
            },
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
          );
        },
        builder: (context, state) {
          return FocusDetector(
            onFocusGained: () =>
                context.read<AccountsBloc>().add(const AccountsEvent.started()),
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  leading: (state.arePrivateAccounts)
                      ? BackButton(
                          onPressed: () => context.read<AccountsBloc>().add(
                                const AccountsEvent.closePrivate(),
                              ),
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
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              }

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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
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
                        loading: () => const Expanded(
                          child: Center(
                            child: Loader(
                              // TODO Change Color
                              color: Colors.purple,
                            ),
                          ),
                        ),
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

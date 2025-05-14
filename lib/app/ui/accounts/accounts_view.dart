import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/core/extension/context_extension.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/domain/model/error_type.dart';
import 'package:password_manager/app/ui/accounts/bloc/accounts_bloc.dart';
import 'package:password_manager/app/ui/accounts/bloc/accounts_event.dart';
import 'package:password_manager/app/ui/accounts/bloc/accounts_state.dart';
import 'package:password_manager/app/ui/accounts/widgets/account_list_tile.dart';
import 'package:password_manager/app/ui/details/details_view.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/duplicated_password_checker_view.dart';
import 'package:password_manager/app/ui/modify/modify_view.dart';
import 'package:password_manager/app/ui/private/private_view.dart';
import 'package:password_manager/app/ui/random_password/random_password_view.dart';
import 'package:password_manager/widgets/loader.dart';

class AccountsView extends StatelessWidget {
  static const routeName = '/AccountsPageRoute';

  static late Completer<void> modifyCompleter;
  static bool isFinishedEdition = false;

  const AccountsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uiModulesDi<AccountsBloc>()
        ..add(
          const AccountsEvent.started(
            String.fromEnvironment('encryption_key'),
          ),
        ),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(Texts.accountsViewTitle),
                actions: [
                  IconButton(
                    onPressed: () {
                      // Remove focus on TextField
                      FocusScope.of(context).unfocus();

                      context
                          .read<AccountsBloc>()
                          .add(const AccountsEvent.showPrivate());
                    },
                    icon: Icon(CommonIcons.private),
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
                    icon: Icon(CommonIcons.settings),
                    tooltip: Texts.settingsTooltip,
                  ),
                ],
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(4),
                  child: Divider(height: 4),
                ),
                // Kept this as I like the look it gives
                // flexibleSpace: Container(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       colors: <Color>[
                //         Colors.black,
                //         Colors.grey[900]!,
                //         Colors.grey[800]!,
                //       ],
                //     ),
                //   ),
                // ),
              ),
              body: BlocConsumer<AccountsBloc, AccountsState>(
                listener: (context, state) {
                  state.navigationState?.when(
                    goToPrivate: () =>
                        context.goWithRoute(PrivateView.routeName),
                    goToDetails: (accountData) async {
                      isFinishedEdition = false;
                      modifyCompleter = Completer<void>();

                      context.goWithRoute(
                        DetailsView.routeName,
                        extra: accountData,
                      );

                      while (!isFinishedEdition) {
                        await modifyCompleter.future;
                        modifyCompleter = Completer<void>();

                        if (context.mounted) {
                          context
                              .read<AccountsBloc>()
                              .add(const AccountsEvent.started(''));
                        }
                      }
                    },
                    goToModify: () async {
                      modifyCompleter = Completer<void>();

                      context.goWithRoute(ModifyView.routeName);

                      await modifyCompleter.future;

                      if (context.mounted) {
                        context
                            .read<AccountsBloc>()
                            .add(const AccountsEvent.started(''));
                      }
                    },
                    goToGeneratePassword: () => context.goWithRoute(
                      RandomPasswordView.routeName,
                    ),
                    showBottomMenu: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext bottomMenuContext) {
                          return Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  Texts
                                      .duplicatedPasswordCheckerSettingsDisclaimer,
                                  style: const TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  child: Text(
                                    Texts.duplicatedPasswordCheckerSettings,
                                  ),
                                  onPressed: () {
                                    context
                                      ..goWithRoute(
                                        DuplicatedPasswordCheckerView.routeName,
                                      )
                                      ..pop();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  Texts.importExportDisclaimer,
                                  style: const TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  child: Text(Texts.exportAccounts),
                                  onPressed: () {
                                    context.pop();

                                    context.read<AccountsBloc>().add(
                                          const AccountsEvent.exportAccounts(),
                                        );
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: ElevatedButton(
                                  child: Text(Texts.importAccounts),
                                  onPressed: () {
                                    context.pop();

                                    context.read<AccountsBloc>().add(
                                          const AccountsEvent.importAccounts(),
                                        );
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
                      showDialog<void>(
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
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Column(
                      children: [
                        state.screenState.when(
                          loading: () => const Loader(),
                          loaded: (_) => const SizedBox(height: 4),
                        ),
                        ListTile(
                          onTap: () =>
                              context.goWithRoute(RandomPasswordView.routeName),
                          leading: Icon(CommonIcons.randomPassword),
                          title: Text(
                            Texts.randomPasswordListTile,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                          trailing: Icon(CommonIcons.next),
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
                          loading: Container.new,
                          loaded: (searchText) => Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) => state
                                      .accountsList[index].name
                                      .toLowerCase()
                                      .startsWith(searchText)
                                  ? AccountListTile(
                                      account: state.accountsList[index],
                                      onTap: () {
                                        // Remove focus on TextField
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();

                                        context.read<AccountsBloc>().add(
                                              AccountsEvent.pressedAccount(
                                                index,
                                              ),
                                            );
                                      },
                                    )
                                  : Container(),
                              separatorBuilder: (context, index) => state
                                      .accountsList[index].name
                                      .toLowerCase()
                                      .startsWith(searchText)
                                  ? const Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  : Container(),
                              itemCount: state.accountsList.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.read<AccountsBloc>().add(
                      const AccountsEvent.pressedModify(),
                    ),
                tooltip: Texts.addNewAccountTooltip,
                child: Icon(CommonIcons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}

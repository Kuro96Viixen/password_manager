import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/core/extension/context_extension.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/ui/accounts/widgets/account_list_tile.dart';
import 'package:password_manager/app/ui/details/details_view.dart';
import 'package:password_manager/app/ui/private/bloc/private_bloc.dart';
import 'package:password_manager/widgets/loader.dart';

class PrivateView extends StatelessWidget {
  static const routeName = 'PrivatePageRoute';

  static late Completer<void> modifyCompleter;
  static bool isFinishedEdition = false;

  const PrivateView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          uiModulesDi<PrivateBloc>()..add(const PrivateEvent.started()),
      child: BlocConsumer<PrivateBloc, PrivateState>(
        listener: (context, state) {
          state.navigationState?.when(
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
                  context.read<PrivateBloc>().add(const PrivateEvent.started());
                }
              }
            },
          );
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  Texts.privateAccountsViewTitle,
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(4),
                  child: Divider(height: 4),
                ),
              ),
              body: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  children: [
                    state.screenState.when(
                      loading: () => const Loader(),
                      loaded: (_) => const SizedBox(height: 4),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: TextField(
                        onChanged: (searchText) =>
                            context.read<PrivateBloc>().add(
                                  PrivateEvent.searchAccount(searchText),
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
                          itemBuilder: (context, index) => (state
                                      .accountsList[index].name
                                      .toLowerCase()
                                      .startsWith(searchText) &&
                                  state.accountsList[index].private)
                              ? AccountListTile(
                                  account: state.accountsList[index],
                                  onTap: () {
                                    // Remove focus on TextField
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();

                                    context.read<PrivateBloc>().add(
                                          PrivateEvent.pressedAccount(index),
                                        );
                                  },
                                )
                              : Container(),
                          separatorBuilder: (context, index) => (state
                                      .accountsList[index].name
                                      .toLowerCase()
                                      .startsWith(searchText) &&
                                  state.accountsList[index].private)
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
              ),
            ),
          );
        },
      ),
    );
  }
}

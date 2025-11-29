import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/ui/accounts/widgets/account_list_tile.dart';
import 'package:password_manager/app/ui/details/details_view.dart';
import 'package:password_manager/app/ui/private/bloc/private_bloc.dart';
import 'package:password_manager/app/ui/private/bloc/private_event.dart';
import 'package:password_manager/app/ui/private/bloc/private_state.dart';
import 'package:password_manager/l10n/app_localizations.dart';
import 'package:password_manager/widgets/loader.dart';

class PrivateView extends StatelessWidget {
  static const routeName = 'PrivatePageRoute';

  const PrivateView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          uiModulesDi<PrivateBloc>()..add(const PrivateStarted()),
      child: BlocConsumer<PrivateBloc, PrivateState>(
        listenWhen: (previous, current) =>
            previous.navigationEvent != current.navigationEvent,
        listener: (context, state) async {
          if (!state.navigationEvent.consumed) {
            final bloc = context.read<PrivateBloc>();

            final success = await context.push<bool>(
              DetailsView.routeName,
              extra: state.navigationEvent.data,
            );

            if (success != null && success) {
              bloc
                ..add(const PrivateStarted())
                ..add(const MarkNavigationEventAsConsumed());
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(
                    context,
                  )!.privateAccountsViewTitle,
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
                    switch (state.screenState) {
                      PrivateScreenStateLoading() => const Loader(),
                      PrivateScreenStateLoaded() => const SizedBox(height: 4),
                    },
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: TextField(
                        onChanged: (searchText) =>
                            context.read<PrivateBloc>().add(
                              PrivateSearchAccount(searchText),
                            ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(
                            context,
                          )!.searchHintText,
                        ),
                      ),
                    ),
                    switch (state.screenState) {
                      PrivateScreenStateLoading() => Container(),
                      PrivateScreenStateLoaded(:final searchText) => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              state.accountsList[index].name
                                  .toLowerCase()
                                  .startsWith(searchText)
                              ? AccountListTile(
                                  account: state.accountsList[index],
                                  onTap: () {
                                    // Remove focus on TextField
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();

                                    context.read<PrivateBloc>().add(
                                      PrivatePressedAccount(index),
                                    );
                                  },
                                )
                              : Container(),
                          separatorBuilder: (context, index) =>
                              state.accountsList[index].name
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
                    },
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

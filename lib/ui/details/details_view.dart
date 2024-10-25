import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/core/extension/context_extension.dart';
import 'package:password_manager/di/app_di.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/ui/details/bloc/details_bloc.dart';
import 'package:password_manager/ui/details/widgets/account_field.dart';
import 'package:password_manager/ui/details/widgets/account_label.dart';
import 'package:password_manager/ui/modify/modify_view.dart';

class DetailsView extends StatelessWidget {
  static const routeName = 'DetailsPageRoute';

  final AccountData accountData;

  const DetailsView({
    super.key,
    required this.accountData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uiModulesDi<DetailsBloc>(),
      child: BlocConsumer<DetailsBloc, DetailsState>(
        listener: (context, state) {
          state.navigationState?.when(
            goBack: () => context.pop(),
            // TODO Check extra
            goToModify: () => context.goWithRoute(ModifyView.routeName),
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
            onFocusGained: () => context.read<DetailsBloc>().add(
                  const DetailsEvent.started(),
                ),
            child: SafeArea(
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
                          .add(DetailsEvent.deleteAccount(accountData)),
                      icon: Icon(
                        CommonIcons.delete,
                      ),
                    ),
                  ],
                ),
                body: Container(
                  padding: const EdgeInsets.all(
                    16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AccountLabel(
                        text: Texts.viewAccountNameLabel,
                      ),
                      AccountField(
                        text: accountData.name,
                      ),
                      AccountLabel(
                        text: Texts.viewAccountUsernameLabel,
                      ),
                      AccountField(
                        text: accountData.username,
                      ),
                      AccountLabel(
                        text: Texts.viewAccountPasswordLabel,
                      ),
                      GestureDetector(
                        onLongPress: () {
                          context.read<DetailsBloc>().add(
                                DetailsEvent.copyPassword(
                                  accountData.password,
                                ),
                              );
                        },
                        child: AccountField(
                          text: state.passwordString,
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
                                    accountData.password,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => context
                      .read<DetailsBloc>()
                      .add(const DetailsEvent.pressedModify()),
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

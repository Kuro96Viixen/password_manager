import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/routes.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/utils/widgets.dart';

class AccountsView extends StatefulWidget {
  const AccountsView({super.key});

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
  List<Account> accounts = Utils.accounts;

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () => setState(() => accounts = Utils.accounts),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              Texts.accountsViewTitle,
            ),
            actions: [
              IconButton(
                onPressed: () => Utils.authenticate(
                  Texts.fingerprintPrivateAuthTitle,
                ).then(
                  (authenticated) {
                    if (authenticated) {
                      Navigator.of(context).pushNamed(Routes.private);
                    }
                  },
                ),
                icon: Icon(
                  CommonIcons.private,
                  color: Colors.white,
                ),
                tooltip: Texts.showPrivateTooltip,
              ),
              IconButton(
                onPressed: () => showSettings(),
                icon: Icon(CommonIcons.settings),
              ),
            ],
          ),
          body: ListView.separated(
            itemBuilder: (context, index) => (!accounts[index].private)
                ? CustomWidgets.listTile(
                    context,
                    index,
                    accounts[index],
                  )
                : Container(),
            separatorBuilder: (context, index) => (!accounts[index].private)
                ? Divider(height: 1, color: Theme.of(context).disabledColor)
                : Container(),
            itemCount: accounts.length,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, Routes.addEdit),
            tooltip: Texts.addNewAccountTooltip,
            child: Icon(CommonIcons.add),
          ),
        ),
      ),
    );
  }

  void showSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          height: 120.0,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.button(
                Texts.exportAccounts,
                () => Utils.exportAccounts().then(
                  (_) => Navigator.of(context).pop(),
                ),
              ),
              CustomWidgets.spacer(),
              CustomWidgets.button(
                Texts.importAccounts,
                () => Utils.importAccounts().then(
                  (_) {
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

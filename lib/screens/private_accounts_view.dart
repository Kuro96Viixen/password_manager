import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/routes.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/utils/widgets.dart';

class PrivateAccountsView extends StatefulWidget {
  const PrivateAccountsView({super.key});

  @override
  State<PrivateAccountsView> createState() => _PrivateAccountsViewState();
}

class _PrivateAccountsViewState extends State<PrivateAccountsView> {
  List<Account> accounts = Utils.accounts;

  String search = '';

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () => setState(() => accounts = Utils.accounts),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: CustomWidgets.backButton(context),
            title: Text(
              Texts.privateAccountsViewTitle,
            ),
          ),
          body: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: CustomWidgets.searchTextField(
                      (searchText) => setState(() => search = searchText)),
                ),
                ListView.separated(
                  itemBuilder: (context, index) => (accounts[index].private &&
                          accounts[index].name.toLowerCase().startsWith(search))
                      ? CustomWidgets.accountListTile(
                          context,
                          index,
                          accounts[index],
                        )
                      : Container(),
                  separatorBuilder: (context, index) => (accounts[index]
                              .private &&
                          accounts[index].name.toLowerCase().startsWith(search))
                      ? Divider(
                          height: 1, color: Theme.of(context).disabledColor)
                      : Container(),
                  itemCount: accounts.length,
                ),
              ],
            ),
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
}

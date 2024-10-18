import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    List<Account> accounts = Utils.accounts;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CustomWidgets.backButton(context),
          title: Text(
            Texts.privateAccountsViewTitle,
          ),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => (accounts[index].private)
              ? CustomWidgets.listTile(context, index, accounts[index])
              : Container(),
          separatorBuilder: (context, index) => (accounts[index].private)
              ? Divider(height: 1, color: Theme.of(context).disabledColor)
              : Container(),
          itemCount: accounts.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, Routes.addEdit).then(
            (_) => setState(
              () {},
            ),
          ),
          tooltip: Texts.addNewAccountTooltip,
          child: Icon(CommonIcons.add),
        ),
      ),
    );
  }
}

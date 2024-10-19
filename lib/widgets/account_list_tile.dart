import 'package:flutter/material.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/routes.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/screens/view_account_view.dart';

class AccountListTile extends StatelessWidget {
  final int index;
  final Account account;

  const AccountListTile({
    super.key,
    required this.index,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        Routes.view,
        arguments: ViewAccountViewArguments(
          index,
          account,
        ),
      ),
      leading: Icon(
        CommonIcons.account,
      ),
      title: Text(
        account.name,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      trailing: Icon(
        CommonIcons.next,
      ),
    );
  }
}

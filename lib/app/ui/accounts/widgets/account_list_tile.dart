import 'package:flutter/material.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

class AccountListTile extends StatelessWidget {
  final AccountData account;
  final VoidCallback? onTap;

  const AccountListTile({
    required this.account,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(CommonIcons.account),
      title: Text(
        account.name,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      trailing: Icon(CommonIcons.next),
    );
  }
}

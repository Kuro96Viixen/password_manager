import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/accounts/bloc/accounts_bloc.dart';

class AccountListTile extends StatelessWidget {
  final int index;
  final AccountData account;

  const AccountListTile({
    super.key,
    required this.index,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Remove focus on TextField
        FocusManager.instance.primaryFocus!.unfocus();

        context.read<AccountsBloc>().add(
              AccountsEvent.pressedAccount(index),
            );
      },
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

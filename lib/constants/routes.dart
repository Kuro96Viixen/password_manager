import 'package:flutter/material.dart';
import 'package:password_manager/screens/accounts_view.dart';
import 'package:password_manager/screens/add_edit_view.dart';
import 'package:password_manager/screens/private_accounts_view.dart';
import 'package:password_manager/screens/view_account_view.dart';

class Routes {
  static const String accounts = 'Accounts';
  static const String private = 'Private';
  static const String view = 'View';
  static const String addEdit = 'AddEdit';

  static Route<dynamic> routes(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case accounts:
        return MaterialPageRoute(
          builder: (context) => const AccountsView(),
        );
      case private:
        return MaterialPageRoute(
          builder: (context) => const PrivateAccountsView(),
        );
      case view:
        return MaterialPageRoute(
          builder: (context) =>
              ViewAccountView(arguments as ViewAccountViewArguments),
        );
      case addEdit:
        return MaterialPageRoute(
          builder: (context) => AddEditView(
            arguments: arguments as EditArguments?,
          ),
        );
      // case settings:break;
      default:
        return MaterialPageRoute(
          builder: (context) => const AccountsView(),
        );
    }
  }
}

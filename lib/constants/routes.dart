import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/ui/accounts/accounts_view.dart';
import 'package:password_manager/ui/add_edit_view.dart';
import 'package:password_manager/ui/view_account_view.dart';

GoRoute _editView() => GoRoute(
      path: 'AddEdit',
      builder: (context, state) => const AccountsView(),
      routes: const [],
    );

List<GoRoute> allAppRoutes = [
  GoRoute(
    path: AccountsView.routeName,
    builder: (context, state) => const AccountsView(),
    routes: [
      GoRoute(
        path: 'View',
        builder: (context, state) => const AccountsView(),
        routes: [
          _editView(),
        ],
      ),
      _editView(),
    ],
  ),
];

class Routes {
  static const String view = 'View';
  static const String addEdit = 'AddEdit';

  static Route<dynamic> routes(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case AccountsView.routeName:
        return MaterialPageRoute(
          builder: (context) => const AccountsView(),
        );
      case view:
        return MaterialPageRoute(
          builder: (context) => ViewAccountView(
            arguments as ViewAccountViewArguments,
          ),
        );
      case addEdit:
        return MaterialPageRoute(
          builder: (context) => AddEditView(
            arguments: arguments as EditArguments?,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const AccountsView(),
        );
    }
  }
}

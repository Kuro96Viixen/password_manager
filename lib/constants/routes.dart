import 'package:go_router/go_router.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/ui/accounts/accounts_view.dart';
import 'package:password_manager/ui/details/details_view.dart';

AccountData? accountData;

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
        path: DetailsView.routeName,
        builder: (context, state) {
          if (state.extra is AccountData) {
            accountData = state.extra as AccountData?;
          }

          return DetailsView(accountData: accountData!);
        },
        routes: [
          _editView(),
        ],
      ),
      _editView(),
    ],
  ),
];

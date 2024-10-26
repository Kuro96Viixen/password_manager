import 'package:go_router/go_router.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/ui/accounts/accounts_view.dart';
import 'package:password_manager/ui/details/details_view.dart';
import 'package:password_manager/ui/modify/modify_view.dart';

AccountData? accountData;

GoRoute _editView() => GoRoute(
      path: ModifyView.routeName,
      builder: (context, state) {
        if (state.extra is AccountData) {
          accountData = state.extra as AccountData;
        }

        return ModifyView(
          accountData: accountData,
        );
      },
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

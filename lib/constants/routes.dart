import 'package:go_router/go_router.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/ui/accounts/accounts_view.dart';
import 'package:password_manager/ui/details/details_view.dart';
import 'package:password_manager/ui/modify/modify_view.dart';

GoRoute _editView() => GoRoute(
      path: ModifyView.routeName,
      builder: (context, state) {
        // Added this statement here, as is giving an issue if:
        /// Open Account > Edit Account > Close edition > Close Account > ...
        /// ... > Add new Account *previous account displayed* > ...
        /// ... > Add password > Save *Exception thrown as trying to find index*
        AccountData? accountData;

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
          AccountData? accountData;

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

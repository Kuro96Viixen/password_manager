import 'package:go_router/go_router.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/ui/accounts/accounts_view.dart';
import 'package:password_manager/app/ui/details/details_view.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/duplicated_password_checker_view.dart';
import 'package:password_manager/app/ui/modify/modify_view.dart';
import 'package:password_manager/app/ui/private/private_view.dart';
import 'package:password_manager/app/ui/random_password/random_password_view.dart';

GoRoute _detailsView() => GoRoute(
      path: DetailsView.routeName,
      builder: (context, state) {
        AccountData? accountData;

        if (state.extra is AccountData) {
          accountData = state.extra as AccountData?;
        }

        return DetailsView(accountData: accountData!);
      },
      routes: [
        _modifyView(),
      ],
    );

GoRoute _modifyView() => GoRoute(
      path: ModifyView.routeName,
      builder: (context, state) {
        // Added this statement here, as is giving an issue if:
        /// Open Account > Edit Account > Close edition > Close Account > ...
        /// ... > Add new Account *previous account displayed* > ...
        /// ... > Add password > Save *Exception thrown as trying to find index*
        AccountData? accountData;

        if (state.extra is AccountData) {
          accountData = state.extra! as AccountData;
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
        path: PrivateView.routeName,
        builder: (context, state) => const PrivateView(),
        routes: [
          _detailsView(),
        ],
      ),
      _detailsView(),
      _modifyView(),
      GoRoute(
        path: RandomPasswordView.routeName,
        builder: (context, state) => const RandomPasswordView(),
      ),
      GoRoute(
        path: DuplicatedPasswordCheckerView.routeName,
        builder: (context, state) => const DuplicatedPasswordCheckerView(),
      ),
    ],
  ),
];

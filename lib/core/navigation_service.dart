import 'package:go_router/go_router.dart';

abstract class NavigationService {
  String getCurrentRoute();
}

class GoRouterNavigationService implements NavigationService {
  final GoRouter _goRouter;

  GoRouterNavigationService(this._goRouter);

  @override
  String getCurrentRoute() {
    return _goRouter.routeInformationProvider.value.uri.toString();
  }
}

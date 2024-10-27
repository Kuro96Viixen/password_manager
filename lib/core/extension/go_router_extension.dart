import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  /// Navigate back to a specific route
  ///
  /// [ancestorPath]: The path to navigate back
  void popUntilPath(String ancestorPath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation
            .split('/')
            .last !=
        ancestorPath) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }
}

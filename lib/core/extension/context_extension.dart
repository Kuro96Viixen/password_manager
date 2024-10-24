import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

extension ContextExtension on BuildContext {
  // Get the actual route
  String get previousRoute => GoRouterState.of(this).uri.toString();

  /// Navigate to a location with the previous route as prefix
  ///
  /// [pageName]: The name of the page to navigate to
  /// [extra]: Extra data to pass to the page
  ///
  /// Use this to add a page to the stack,
  /// to be able to navigate back with back button
  void goWithRoute(String pageName, {Object? extra}) {
    final String previousRoute = this.previousRoute;

    go('$previousRoute/$pageName', extra: extra);
  }
}

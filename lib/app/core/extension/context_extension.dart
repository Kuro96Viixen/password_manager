import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/app/core/extension/go_router_extension.dart';

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

  /// Navigate back to a specific route
  ///
  /// [ancestorPath]: The path to navigate back
  void popUntilPath(String ancestorPath) {
    GoRouter.of(this).popUntilPath(ancestorPath);
  }

  /// Check if the device is with the DarkMode enabled
  bool get isDarkMode {
    // TODO: review this when adding Light theme
    // context.isDarkMode
    final brightness = MediaQuery.of(this).platformBrightness;

    return brightness == Brightness.dark;
  }
}

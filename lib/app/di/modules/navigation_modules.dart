part of 'package:password_manager/app/di/app_di.dart';

final navigationModulesDi = GetIt.instance;

void _navigationModulesInit() {
  final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AccountsView.routeName,
    routes: allAppRoutes,
    errorBuilder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.redAccent,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Colors.white,
                size: 100,
              ),
              const SizedBox(height: 16),
              Text(
                'Route not found: ${state.error}',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );

  navigationModulesDi
    ..registerLazySingleton<GoRouter>(() => router)
    ..registerLazySingleton<NavigationService>(
      () => GoRouterNavigationService(navigationModulesDi()),
    );
}

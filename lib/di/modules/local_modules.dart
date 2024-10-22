part of 'package:password_manager/di/app_di.dart';

final localModulesDi = GetIt.instance;

void _localModulesInit() {
  localModulesDi.registerLazySingleton<MemoryDataSource>(
    () => MemoryDataSourceImpl(),
  );
}

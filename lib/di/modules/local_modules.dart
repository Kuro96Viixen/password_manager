part of 'package:password_manager/di/app_di.dart';

final localModulesDi = GetIt.instance;

void _localModulesInit() {
  localModulesDi.registerLazySingleton<MemoryDataSource>(
    () => MemoryDataSourceImpl(),
  );

  localModulesDi.registerLazySingleton<FilePickerService>(
    () => FilePickerServiceImpl(),
  );

  localModulesDi.registerLazySingleton<LocalAuthService>(
    () => LocalAuthServiceImpl(),
  );

  localModulesDi.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(),
  );
}

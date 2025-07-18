part of 'package:password_manager/app/di/app_di.dart';

final GetIt localModulesDi = GetIt.instance;

void _localModulesInit() {
  localModulesDi
    ..registerLazySingleton<MemoryDataSource>(
      MemoryDataSourceImpl.new,
    )
    ..registerLazySingleton<FilePickerService>(
      FilePickerServiceImpl.new,
    )
    ..registerLazySingleton<LocalAuthService>(
      LocalAuthServiceImpl.new,
    )
    ..registerLazySingleton<SecureStorageService>(
      SecureStorageServiceImpl.new,
    )
    ..registerLazySingleton<EncryptionService>(
      EncryptionServiceImpl.new,
    );
}

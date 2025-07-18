part of 'package:password_manager/app/di/app_di.dart';

final GetIt repositoryModulesDi = GetIt.instance;

void _repositoryModulesDi() {
  repositoryModulesDi.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      memoryDataSource: repositoryModulesDi(),
      filePickerService: repositoryModulesDi(),
      localAuthService: repositoryModulesDi(),
      secureStorageService: repositoryModulesDi(),
      encryptionService: repositoryModulesDi(),
    ),
  );
}

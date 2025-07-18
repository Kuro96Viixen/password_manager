part of 'package:password_manager/app/di/app_di.dart';

final GetIt domainModulesDi = GetIt.instance;

void _domainModulesInit() {
  // Register UseCases here

  domainModulesDi
    ..registerFactory(
      () => GetAccountsDataUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => SetAccountsDataUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => GetAccountsDataFromStorageUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => SetAccountsDataOnStorageUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => GetAuthenticationUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => ExportAccountsUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => ImportAccountsUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => InitializeEncryptionUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => EncryptPasswordUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => DecryptPasswordUseCase(domainModulesDi()),
    )
    ..registerFactory(
      () => EncryptForDuplicateUseCase(domainModulesDi()),
    );
}

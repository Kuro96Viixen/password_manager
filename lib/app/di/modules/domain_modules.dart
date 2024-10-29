part of 'package:password_manager/app/di/app_di.dart';

final domainModulesDi = GetIt.instance;

void _domainModulesInit() {
  // Register UseCases here

  domainModulesDi.registerFactory(
    () => GetAccountsDataUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => SetAccountsDataUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => GetAccountsDataFromStorageUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => SetAccountsDataOnStorageUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => GetAuthenticationUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => ExportAccountsUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => ImportAccountsUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => InitializeEncryptionUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => EncryptPasswordUseCase(domainModulesDi()),
  );

  domainModulesDi.registerFactory(
    () => DecryptPasswordUseCase(domainModulesDi()),
  );
}

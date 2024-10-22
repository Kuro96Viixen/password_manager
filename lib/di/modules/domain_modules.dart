part of 'package:password_manager/di/app_di.dart';

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
}

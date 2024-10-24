part of 'package:password_manager/di/app_di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  // TODO Blocs as:
  // uiModulesDi.registerFactory(
  //   () => Bloc(
  //     param: param,
  //   ),
  // );

  uiModulesDi.registerFactory(
    () => AccountsBloc(
      getAccountsDataUseCase: uiModulesDi(),
      setAccountsDataUseCase: uiModulesDi(),
      getAccountsDataFromStorageUseCase: uiModulesDi(),
    ),
  );

  uiModulesDi.registerFactory(
    () => DetailsBloc(
      getAccountsDataUseCase: uiModulesDi(),
      setAccountsDataUseCase: uiModulesDi(),
      setAccountsDataOnStorageUseCase: uiModulesDi(),
    ),
  );
}

part of 'package:password_manager/app/di/app_di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  // INFO Blocs as:
  // uiModulesDi.registerFactory(
  //   () => Bloc(
  //     param: param,
  //   ),
  // );

  uiModulesDi
    ..registerFactory(
      () => AccountsBloc(
        getAccountsDataUseCase: uiModulesDi(),
        setAccountsDataUseCase: uiModulesDi(),
        getAccountsDataFromStorageUseCase: uiModulesDi(),
        setAccountsDataOnStorageUseCase: uiModulesDi(),
        getAuthenticationUseCase: uiModulesDi(),
        exportAccountsUseCase: uiModulesDi(),
        importAccountsUseCase: uiModulesDi(),
        initializeEncryptionUseCase: uiModulesDi(),
      ),
    )
    ..registerFactory(
      () => PrivateBloc(
        getAccountsDataUseCase: uiModulesDi(),
      ),
    )
    ..registerFactory(
      () => DetailsBloc(
        getAccountsDataUseCase: uiModulesDi(),
        setAccountsDataUseCase: uiModulesDi(),
        setAccountsDataOnStorageUseCase: uiModulesDi(),
        getAuthenticationUseCase: uiModulesDi(),
        decryptPasswordUseCase: uiModulesDi(),
      ),
    )
    ..registerFactory(
      () => ModifyBloc(
        getAccountsDataUseCase: uiModulesDi(),
        setAccountsDataUseCase: uiModulesDi(),
        setAccountsDataOnStorageUseCase: uiModulesDi(),
        encryptPasswordUseCase: uiModulesDi(),
      ),
    )
    ..registerFactory(
      RandomPasswordBloc.new,
    )
    ..registerFactory(
      () => DuplicatedPasswordCheckerBloc(
        getAccountsDataUseCase: uiModulesDi(),
        decryptPasswordUseCase: uiModulesDi(),
        encryptForDuplicateUseCase: uiModulesDi(),
      ),
    );
}

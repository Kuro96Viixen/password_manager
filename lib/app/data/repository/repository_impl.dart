import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/data/repository/data_source/memory_data_source.dart';
import 'package:password_manager/app/data/repository/mapper/account_data_mapper.dart';
import 'package:password_manager/app/data/repository/services/encryption_service.dart';
import 'package:password_manager/app/data/repository/services/file_picker_service.dart';
import 'package:password_manager/app/data/repository/services/local_auth_service.dart';
import 'package:password_manager/app/data/repository/services/secure_storage_service.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/model/error_type.dart';
import 'package:password_manager/app/domain/model/result.dart';
import 'package:password_manager/app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final MemoryDataSource memoryDataSource;

  final FilePickerService filePickerService;
  final LocalAuthService localAuthService;
  final SecureStorageService secureStorageService;
  final EncryptionService encryptionService;

  RepositoryImpl({
    required this.memoryDataSource,
    required this.filePickerService,
    required this.localAuthService,
    required this.secureStorageService,
    required this.encryptionService,
  });

  @override
  Future<AccountsData> getAccountsData() async {
    final accountsList = await memoryDataSource.getAccountsData();

    return accountsList.toAccountsData();
  }

  @override
  Future<void> setAccountsData(AccountsData accountsData) async {
    await memoryDataSource.setAccountData(accountsData.toAccountsDataEntity());
  }

  @override
  Future<String?> getAccountsDataFromStorage() async {
    return await secureStorageService.read();
  }

  @override
  Future<void> setAccountsDataOnStorage(String encodedAccountsData) async {
    await secureStorageService.write(encodedAccountsData);
  }

  @override
  Future<bool> authenticate() async {
    return await localAuthService.authenticate();
  }

  @override
  Future<Result<String>> exportAccounts(AccountsData accountsData) async {
    try {
      final filePath = await memoryDataSource.exportAccounts(
        accountsData.toAccountsDataEntity(),
        filePickerService,
      );

      return Result.success(data: filePath);
    } catch (error) {
      return const Result.failure(errorType: ErrorType.pickFolderException());
    }
  }

  @override
  Future<Result<AccountsData>> importAccounts() async {
    try {
      final importedAccounts = await memoryDataSource.importAccounts(
        filePickerService,
      );

      return Result.success(data: importedAccounts.toAccountsData());
    } catch (error) {
      return const Result.failure(errorType: ErrorType.pickFileException());
    }
  }

  @override
  Future<void> initializeEncryption(String keyValue) async {
    await encryptionService.initialize(keyValue);
  }

  @override
  Future<Password> encrypt(String password) async {
    return await encryptionService.encrypt(password);
  }

  @override
  Future<String> decrypt(Password password) async {
    return await encryptionService.decrypt(password);
  }
}

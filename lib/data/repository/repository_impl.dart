import 'package:password_manager/data/repository/data_source/memory_data_source.dart';
import 'package:password_manager/data/repository/mapper/account_data_mapper.dart';
import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/model/result.dart';
import 'package:password_manager/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final MemoryDataSource memoryDataSource;

  RepositoryImpl({
    required this.memoryDataSource,
  });

  @override
  Future<Result<AccountsData>> getAccountsData() async {
    try {
      final accountsList = await memoryDataSource.getAccountsData();

      return Result.success(data: accountsList.toAccountsData());
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<void> setAccountsData(AccountsData accountsData) async {
    try {
      await memoryDataSource
          .setAccountData(accountsData.toAccountsDataEntity());
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<String?> getAccountsDataFromStorage() async {
    return memoryDataSource.getAccountsDataFromStorage();
  }

  @override
  Future<void> setAccountsDataOnStorage(String encodedAccountsData) async {
    memoryDataSource.setAccountsDataOnStorage(encodedAccountsData);
  }
}

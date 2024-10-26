import 'package:password_manager/data/repository/model/account_data_entity.dart';

abstract class MemoryDataSource {
  Future<AccountsDataEntity> getAccountsData();

  Future<void> setAccountData(AccountsDataEntity accountsDataEntity);

  // TODO Can be moved?
  Future<String?> getAccountsDataFromStorage();

  Future<void> setAccountsDataOnStorage(String encodedAccountsData);

  Future<bool> authenticate();

  Future<void> exportAccounts(AccountsDataEntity accountData);

  Future<AccountsDataEntity> importAccounts();
}

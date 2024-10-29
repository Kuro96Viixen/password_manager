import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/model/result.dart';

abstract class Repository {
  Future<void> setAccountsData(AccountsData accountsData);

  Future<AccountsData> getAccountsData();

  Future<String?> getAccountsDataFromStorage();

  Future<void> setAccountsDataOnStorage(String accountsData);

  Future<bool> authenticate();

  Future<Result<void>> exportAccounts(AccountsData accountsData);

  Future<Result<AccountsData>> importAccounts();
}

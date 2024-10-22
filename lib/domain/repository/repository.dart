import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/model/result.dart';

abstract class Repository {
  Future<void> setAccountsData(AccountsData accountsData);

  Future<Result<AccountsData>> getAccountsData();

  Future<String?> getAccountsDataFromStorage();

  Future<void> setAccountsDataOnStorage(String accountsData);
}

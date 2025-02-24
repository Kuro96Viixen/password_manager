import 'package:password_manager/app/data/repository/model/account_data_entity.dart';

abstract class MemoryDataSource {
  Future<AccountsDataEntity> getAccountsData();

  Future<void> setAccountData(AccountsDataEntity accountsDataEntity);
  //
  // Future<String> exportAccounts(
  //   AccountsDataEntity accountData,
  //   FilePickerService filePicker,
  // );
  //
  // Future<AccountsDataEntity> importAccounts(FilePickerService filePicker);
}

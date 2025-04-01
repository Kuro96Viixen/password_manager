import 'package:password_manager/app/data/repository/model/account_data_entity.dart';
import 'package:password_manager/app/data/repository/services/file_picker_service.dart';

abstract class MemoryDataSource {
  Future<AccountsDataEntity> getAccountsData();

  Future<void> setAccountData(AccountsDataEntity accountsDataEntity);

  Future<String> exportAccounts(
    AccountsDataEntity accountData,
    FilePickerService filePicker,
  );

  Future<AccountsDataEntity> importAccounts(FilePickerService filePicker);
}

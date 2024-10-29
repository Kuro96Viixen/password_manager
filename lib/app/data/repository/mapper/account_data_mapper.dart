import 'package:password_manager/app/data/repository/model/account_data_entity.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

extension AccountsDataEntityExtension on AccountsDataEntity {
  AccountsData toAccountsData() => AccountsData(
        accountsList: accountsList.map((e) => e.toAccountData()).toList(),
      );
}

extension AccountDataEntityExtension on AccountDataEntity {
  AccountData toAccountData() => AccountData(
        name: name,
        username: username,
        password: password,
        private: private,
      );
}

extension AccountsDataExtension on AccountsData {
  AccountsDataEntity toAccountsDataEntity() => AccountsDataEntity(
        accountsList: accountsList.map((e) => e.toAccountDataEntity()).toList(),
      );
}

extension AccountDataExtension on AccountData {
  AccountDataEntity toAccountDataEntity() => AccountDataEntity(
        name: name,
        username: username,
        password: password,
        private: private,
      );
}

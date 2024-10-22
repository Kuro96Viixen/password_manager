import 'package:password_manager/data/memory_data_source/model/account_data_memory_entity.dart';
import 'package:password_manager/data/repository/model/account_data_entity.dart';

extension AccountsDataMemoryEntityExtension on AccountsDataMemoryEntity {
  AccountsDataEntity toAccountsDataEntity() => AccountsDataEntity(
        accountsList: accountsList.map((e) => e.toAccountDataEntity()).toList(),
      );
}

extension AccountDataMemoryEntityExtension on AccountDataMemoryEntity {
  AccountDataEntity toAccountDataEntity() => AccountDataEntity(
        name: name,
        username: username,
        password: password,
        private: private,
      );
}

extension AccountsDataEntityExtension on AccountsDataEntity {
  AccountsDataMemoryEntity toAccountsDataMemoryEntity() =>
      AccountsDataMemoryEntity(
        accountsList: accountsList
            .map(
              (e) => e.toAccountDataMemoryEntity(),
            )
            .toList(),
      );
}

extension AccountDataEntityExtension on AccountDataEntity {
  AccountDataMemoryEntity toAccountDataMemoryEntity() =>
      AccountDataMemoryEntity(
        name: name,
        username: username,
        password: password,
        private: private,
      );
}

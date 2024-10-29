import 'package:password_manager/app/data/memory_data_source/model/account_data_memory_entity.dart';
import 'package:password_manager/app/data/repository/model/account_data_entity.dart';

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

  String toCSV() => '$name,$username,$password,$private\n';
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

  AccountDataEntity fromCSV(String csv) => AccountDataEntity(
        name: csv.split(',')[0],
        username: csv.split(',')[1],
        password: csv.split(',')[2],
        private: csv.split(',')[3] == 'true',
      );
}

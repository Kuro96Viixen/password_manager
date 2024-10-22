import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/data/memory_data_source/mapper/account_data_memory_entity_mapper.dart';
import 'package:password_manager/data/memory_data_source/model/account_data_memory_entity.dart';
import 'package:password_manager/data/repository/data_source/memory_data_source.dart';
import 'package:password_manager/data/repository/model/account_data_entity.dart';
import 'package:password_manager/utils/encrypt.dart';

class MemoryDataSourceImpl implements MemoryDataSource {
  AccountsDataMemoryEntity? _accountsDataMemoryEntity;

  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<AccountsDataEntity> getAccountsData() async {
    return _accountsDataMemoryEntity != null
        ? _accountsDataMemoryEntity!.toAccountsDataEntity()
        : AccountsDataMemoryEntity.empty().toAccountsDataEntity();
  }

  @override
  Future<void> setAccountData(
    AccountsDataEntity accountsDataEntity,
  ) async {
    _accountsDataMemoryEntity = accountsDataEntity.toAccountsDataMemoryEntity();
  }

  // TODO Can be moved?
  @override
  Future<String?> getAccountsDataFromStorage() {
    return _secureStorage.read(key: Encryption.secureStorageKey);
  }

  @override
  Future<void> setAccountsDataOnStorage(String encodedAccountsData) async {
    _secureStorage.write(
      key: Encryption.secureStorageKey,
      value: encodedAccountsData,
    );
  }
}

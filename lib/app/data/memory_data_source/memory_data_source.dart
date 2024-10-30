import 'dart:io';
import 'dart:typed_data';

import 'package:password_manager/app/data/memory_data_source/mapper/account_data_memory_entity_mapper.dart';
import 'package:password_manager/app/data/memory_data_source/model/account_data_memory_entity.dart';
import 'package:password_manager/app/data/repository/data_source/memory_data_source.dart';
import 'package:password_manager/app/data/repository/model/account_data_entity.dart';
import 'package:password_manager/app/data/repository/services/file_picker_service.dart';

class MemoryDataSourceImpl implements MemoryDataSource {
  AccountsDataMemoryEntity? _accountsDataMemoryEntity;

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

  @override
  Future<String> exportAccounts(
    AccountsDataEntity accountsData,
    FilePickerService filePicker,
  ) async {
    _accountsDataMemoryEntity = accountsData.toAccountsDataMemoryEntity();

    String accountsCsv = '';

    for (AccountDataMemoryEntity account
        in _accountsDataMemoryEntity!.accountsList) {
      accountsCsv += account.toCSV();
    }

    String? filePath = await filePicker.saveFile(
      Uint8List.fromList(accountsCsv.codeUnits),
    );

    if (filePath == null) {
      // If permission denied or closed picker
      throw Exception();
    }

    return filePath;
  }

  @override
  Future<AccountsDataEntity> importAccounts(
    FilePickerService filePicker,
  ) async {
    String? filePath = await filePicker.pickFile();

    if (filePath == null) {
      // If permission denied or closed picker
      throw Exception();
    }

    File file = File(filePath);

    List<String> accountsImport = await file.readAsLines();

    List<AccountDataMemoryEntity> importedAccountsList = [];

    for (String accountCsv in accountsImport) {
      importedAccountsList.add(
        AccountDataEntity.empty()
            .fromCSV(accountCsv)
            .toAccountDataMemoryEntity(),
      );
    }

    return AccountsDataMemoryEntity(accountsList: importedAccountsList)
        .toAccountsDataEntity();
  }
}

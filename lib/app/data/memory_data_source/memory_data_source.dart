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

    final accountsCsv = StringBuffer();

    for (final account in _accountsDataMemoryEntity!.accountsList) {
      accountsCsv.write(account.toCSV());
    }

    final filePath = await filePicker.saveFile(
      Uint8List.fromList(accountsCsv.toString().codeUnits),
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
    final filePath = await filePicker.pickFile();

    if (filePath == null) {
      // If permission denied or closed picker
      throw Exception();
    }

    final file = File(filePath);

    final accountsImportBytes = await file.readAsBytes();

    final accountsImport =
        String.fromCharCodes(accountsImportBytes).split('\n');

    final importedAccountsList = <AccountDataMemoryEntity>[];

    for (final accountCsv in accountsImport) {
      if (accountCsv == '') continue;

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

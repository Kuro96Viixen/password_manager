import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/data/memory_data_source/mapper/account_data_memory_entity_mapper.dart';
import 'package:password_manager/data/memory_data_source/model/account_data_memory_entity.dart';
import 'package:password_manager/data/repository/data_source/memory_data_source.dart';
import 'package:password_manager/data/repository/model/account_data_entity.dart';
import 'package:password_manager/utils/encrypt.dart';
import 'package:permission_handler/permission_handler.dart';

class MemoryDataSourceImpl implements MemoryDataSource {
  AccountsDataMemoryEntity? _accountsDataMemoryEntity;

  final _secureStorage = const FlutterSecureStorage();
  final _auth = LocalAuthentication();

  final _documentsFolder = '/storage/emulated/0/Documents/';
  final _filenameName = 'accounts.csv';
  final _deviceInfo = DeviceInfoPlugin();

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

  @override
  Future<bool> authenticate() async {
    final authenticated = await _auth.authenticate(
      localizedReason: Texts.fingerprintPrivateAuthTitle,
      // authMessages: [
      //   AndroidAuthMessages(
      //     signInTitle: Texts.fingerprintDialogTitle,
      //     biometricHint: Texts.fingerprintDialogSubtitle,
      //   ),
      // ],
      options: const AuthenticationOptions(
        stickyAuth: true,
        useErrorDialogs: false,
      ),
    );

    return authenticated;
  }

  @override
  Future<void> exportAccounts(AccountsDataEntity accountsData) async {
    _accountsDataMemoryEntity = accountsData.toAccountsDataMemoryEntity();

    Directory documents = Directory(_documentsFolder);
    String filename = _filenameName;
    String filePath = documents.path + filename;

    File file = File(filePath);

    String accountsCsv = '';

    for (AccountDataMemoryEntity account
        in _accountsDataMemoryEntity!.accountsList) {
      accountsCsv += account.toCSV();
    }

    final deviceInfo = await _deviceInfo.androidInfo;

    if (deviceInfo.version.sdkInt >= 30) {
      await Permission.manageExternalStorage.request().then(
        (status) {
          if (status == PermissionStatus.granted) {
            file.writeAsString(accountsCsv);
          }
        },
      );
    } else {
      await Permission.storage.request().then(
        (status) {
          if (status == PermissionStatus.granted) {
            file.writeAsString(accountsCsv);
          }
        },
      );
    }
  }

  @override
  Future<AccountsDataEntity> importAccounts() async {
    final deviceInfo = await _deviceInfo.androidInfo;

    Directory documents = Directory(_documentsFolder);
    String filename = _filenameName;
    String filePath = documents.path + filename;

    File file = File(filePath);

    List<String> accountsImport = [];

    if (deviceInfo.version.sdkInt >= 30) {
      await Permission.manageExternalStorage.request().then(
        (status) async {
          if (status == PermissionStatus.granted) {
            accountsImport = await file.readAsLines();
          }
        },
      );
    } else {
      await Permission.storage.request().then(
        (status) async {
          if (status == PermissionStatus.granted) {
            accountsImport = await file.readAsLines();
          }
        },
      );
    }

    List<AccountDataMemoryEntity> importedAccountsList = [];

    for (String accountCsv in accountsImport) {
      importedAccountsList.add(AccountDataEntity.empty()
          .fromCSV(accountCsv)
          .toAccountDataMemoryEntity());
    }

    return AccountsDataMemoryEntity(accountsList: importedAccountsList)
        .toAccountsDataEntity();
  }
}

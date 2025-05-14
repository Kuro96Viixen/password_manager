import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/app/data/repository/services/secure_storage_service.dart';

class SecureStorageServiceImpl implements SecureStorageService {
  final _accountsSecureStorageKey = 'AccountsSecureStorage';
  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> read() async {
    return _secureStorage.read(key: _accountsSecureStorageKey);
  }

  @override
  Future<void> write(String encodedAccountsData) async {
    await _secureStorage.write(
      key: _accountsSecureStorageKey,
      value: encodedAccountsData,
    );
  }
}

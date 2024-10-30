abstract class SecureStorageService {
  Future<String?> read();

  Future<void> write(String encodedAccountsData);
}

import 'package:encrypt/encrypt.dart';

abstract class EncryptionService {
  Future<void> initialize(String keyValue);

  Future<String> encrypt(String password);

  Future<String> decrypt(String encryptedPassword, IV passwordIV);
}

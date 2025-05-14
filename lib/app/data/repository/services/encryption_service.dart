import 'package:encrypt/encrypt.dart';
import 'package:password_manager/app/core/model/password.dart';

abstract class EncryptionService {
  Future<void> initialize();

  Future<Password> encrypt(String password);

  Future<String> decrypt(Password password);

  Future<String> encryptForDuplicate(String password, IV iv);
}

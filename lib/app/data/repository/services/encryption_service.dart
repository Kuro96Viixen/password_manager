import 'package:password_manager/app/core/model/password.dart';

abstract class EncryptionService {
  Future<void> initialize(String keyValue);

  Future<Password> encrypt(String password);

  Future<String> decrypt(Password password);
}

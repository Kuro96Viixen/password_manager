import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/data/repository/services/encryption_service.dart';

class EncryptionServiceImpl implements EncryptionService {
  late Encrypter _encryptor;

  @override
  Future<void> initialize(String keyValue) async {
    _encryptor = Encrypter(
      AES(
        Key(Uint8List.fromList(keyValue.codeUnits)),
        mode: AESMode.cbc,
      ),
    );
  }

  @override
  Future<Password> encrypt(String passwordToEncrypt) async {
    final iv = IV.fromLength(16);

    final encryptedPassword =
        _encryptor.encrypt(passwordToEncrypt, iv: iv).base64;

    final password = Password(password: encryptedPassword, iv: iv.base64);

    return password;
  }

  @override
  Future<String> decrypt(Password password) async {
    final iv = IV.fromBase64(password.iv);

    final decryptedPassword = _encryptor.decrypt64(password.password, iv: iv);

    return decryptedPassword;
  }

  @override
  Future<String> encryptForDuplicate(String password, IV iv) async {
    final encryptedPassword = _encryptor.encrypt(password, iv: iv).base64;

    return encryptedPassword;
  }
}

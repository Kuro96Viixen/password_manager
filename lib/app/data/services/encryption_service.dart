import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:password_manager/app/data/repository/services/encryption_service.dart';

class EncryptionServiceImpl implements EncryptionService {
  late Encrypter _encrypter;

  @override
  Future<void> initialize(String keyValue) async {
    _encrypter = Encrypter(
      AES(
        Key(Uint8List.fromList(keyValue.codeUnits)),
        mode: AESMode.cbc,
      ),
    );
  }

  @override
  Future<String> encrypt(String password) async {
    final iv = IV.fromLength(16);

    String encryptedPassword = _encrypter.encrypt(password, iv: iv).base64;

    return encryptedPassword;
  }

  @override
  Future<String> decrypt(String password, IV passwordIV) async {
    String decryptedPassword = _encrypter.decrypt64(password, iv: passwordIV);

    return decryptedPassword;
  }
}

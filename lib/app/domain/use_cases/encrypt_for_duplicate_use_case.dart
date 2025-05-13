import 'package:encrypt/encrypt.dart';
import 'package:password_manager/app/domain/repository/repository.dart';

class EncryptForDuplicateUseCase {
  final Repository repository;

  EncryptForDuplicateUseCase(this.repository);

  Future<String> call(String password, IV iv) async {
    return await repository.encryptForDuplicate(password, iv);
  }
}

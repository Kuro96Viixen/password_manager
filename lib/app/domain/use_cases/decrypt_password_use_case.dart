import 'package:encrypt/encrypt.dart';
import 'package:password_manager/app/domain/repository/repository.dart';

class DecryptPasswordUseCase {
  final Repository repository;

  DecryptPasswordUseCase(this.repository);

  Future<String> call(String password, IV passwordIV) async {
    return await repository.decrypt(password, passwordIV);
  }
}

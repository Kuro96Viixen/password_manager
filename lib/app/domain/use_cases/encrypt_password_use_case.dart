import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/domain/repository/repository.dart';

class EncryptPasswordUseCase {
  final Repository repository;

  EncryptPasswordUseCase(this.repository);

  Future<Password> call(String password) async {
    return await repository.encrypt(password);
  }
}

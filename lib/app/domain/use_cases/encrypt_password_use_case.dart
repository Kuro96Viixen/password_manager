import 'package:password_manager/app/domain/repository/repository.dart';

class EncryptPasswordUseCase {
  final Repository repository;

  EncryptPasswordUseCase(this.repository);

  Future<String> call(String password) async {
    return await repository.encrypt(password);
  }
}

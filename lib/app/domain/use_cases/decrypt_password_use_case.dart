import 'package:password_manager/app/core/model/password.dart';
import 'package:password_manager/app/domain/repository/repository.dart';

class DecryptPasswordUseCase {
  final Repository repository;

  DecryptPasswordUseCase(this.repository);

  Future<String> call(Password password) async {
    return repository.decrypt(password);
  }
}

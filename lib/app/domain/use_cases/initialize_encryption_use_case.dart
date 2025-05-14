import 'package:password_manager/app/domain/repository/repository.dart';

class InitializeEncryptionUseCase {
  final Repository _repository;

  InitializeEncryptionUseCase(this._repository);

  Future<void> call() async {
    await _repository.initializeEncryption();
  }
}

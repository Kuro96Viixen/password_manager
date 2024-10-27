import 'package:password_manager/domain/repository/repository.dart';

class GetAuthenticationUseCase {
  final Repository _repository;

  GetAuthenticationUseCase(this._repository);

  Future<bool> call() async {
    return _repository.authenticate();
  }
}

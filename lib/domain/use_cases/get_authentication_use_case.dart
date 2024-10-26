import 'package:password_manager/domain/model/result.dart';
import 'package:password_manager/domain/repository/repository.dart';

class GetAuthenticationUseCase {
  final Repository _repository;

  GetAuthenticationUseCase(this._repository);

  Future<Result<bool>> call() async {
    return _repository.authenticate();
  }
}

import 'package:password_manager/domain/repository/repository.dart';

class GetAccountsDataFromStorageUseCase {
  final Repository _repository;

  GetAccountsDataFromStorageUseCase(this._repository);

  Future<String?> call() async {
    return _repository.getAccountsDataFromStorage();
  }
}
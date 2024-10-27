import 'package:password_manager/domain/repository/repository.dart';

class SetAccountsDataOnStorageUseCase {
  final Repository _repository;

  SetAccountsDataOnStorageUseCase(this._repository);

  Future<void> call(String accountsData) async {
    return _repository.setAccountsDataOnStorage(accountsData);
  }
}

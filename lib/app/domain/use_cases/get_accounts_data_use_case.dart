import 'package:password_manager/app/domain/model/accounts_data.dart';
import 'package:password_manager/app/domain/repository/repository.dart';

class GetAccountsDataUseCase {
  final Repository _repository;

  GetAccountsDataUseCase(this._repository);

  Future<AccountsData> call() async {
    return _repository.getAccountsData();
  }
}

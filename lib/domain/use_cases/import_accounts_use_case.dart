import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/model/result.dart';
import 'package:password_manager/domain/repository/repository.dart';

class ImportAccountsUseCase {
  final Repository _repository;

  ImportAccountsUseCase(this._repository);

  Future<Result<AccountsData>> call() async {
    return _repository.importAccounts();
  }
}

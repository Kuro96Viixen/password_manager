import 'package:password_manager/domain/model/accounts_data.dart';
import 'package:password_manager/domain/model/result.dart';
import 'package:password_manager/domain/repository/repository.dart';

class ExportAccountsUseCase {
  final Repository _repository;

  ExportAccountsUseCase(this._repository);

  Future<Result<void>> call(AccountsData accountsData) async {
    return _repository.exportAccounts(accountsData);
  }
}

import 'package:equatable/equatable.dart';

final class AccountsDataEntity extends Equatable {
  const AccountsDataEntity({required this.accountsList});

  factory AccountsDataEntity.empty() => const AccountsDataEntity(
        accountsList: [],
      );

  final List<AccountDataEntity> accountsList;

  @override
  List<Object?> get props => [accountsList];
}

final class AccountDataEntity extends Equatable {
  const AccountDataEntity({
    required this.name,
    required this.username,
    required this.password,
    required this.passwordIV,
    required this.private,
  });

  factory AccountDataEntity.empty() => const AccountDataEntity(
        name: '',
        username: '',
        password: '',
        passwordIV: '',
        private: false,
      );

  final String name;
  final String username;
  final String password;
  final String passwordIV;
  final bool private;

  @override
  List<Object?> get props => [name, username, password, passwordIV, private];
}

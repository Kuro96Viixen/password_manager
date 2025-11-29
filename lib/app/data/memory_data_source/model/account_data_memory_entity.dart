import 'package:equatable/equatable.dart';

final class AccountsDataMemoryEntity extends Equatable {
  const AccountsDataMemoryEntity({required this.accountsList});

  factory AccountsDataMemoryEntity.empty() =>
      const AccountsDataMemoryEntity(accountsList: []);

  final List<AccountDataMemoryEntity> accountsList;

  @override
  List<Object?> get props => [accountsList];

  AccountsDataMemoryEntity copyWith({
    List<AccountDataMemoryEntity>? accountsList,
  }) {
    return AccountsDataMemoryEntity(
      accountsList: accountsList ?? this.accountsList,
    );
  }
}

final class AccountDataMemoryEntity extends Equatable {
  const AccountDataMemoryEntity({
    required this.name,
    required this.username,
    required this.password,
    required this.passwordIV,
    required this.private,
  });

  final String name;
  final String username;
  final String password;
  final String passwordIV;
  final bool private;

  @override
  List<Object?> get props => [name, username, password, passwordIV, private];
}

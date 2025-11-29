import 'package:equatable/equatable.dart';

final class AccountsData extends Equatable {
  const AccountsData({required this.accountsList});

  final List<AccountData> accountsList;

  @override
  List<Object?> get props => [accountsList];

  AccountsData copyWith({
    List<AccountData>? accountsList,
  }) {
    return AccountsData(
      accountsList: accountsList ?? this.accountsList,
    );
  }
}

final class AccountData extends Equatable {
  const AccountData({
    required this.name,
    required this.username,
    required this.password,
    required this.passwordIV,
    required this.private,
  });

  factory AccountData.empty() => const AccountData(
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

import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_data.freezed.dart';

@freezed
sealed class AccountsData with _$AccountsData {
  const factory AccountsData({required List<AccountData> accountsList}) =
      _AccountsData;
}

@freezed
sealed class AccountData with _$AccountData {
  const factory AccountData({
    required String name,
    required String username,
    required String password,
    required String passwordIV,
    required bool private,
  }) = _AccountData;

  factory AccountData.empty() => const AccountData(
    name: '',
    username: '',
    password: '',
    passwordIV: '',
    private: false,
  );
}

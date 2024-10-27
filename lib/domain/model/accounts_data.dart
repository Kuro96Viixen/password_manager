import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_data.freezed.dart';

@freezed
class AccountsData with _$AccountsData {
  const factory AccountsData({
    required List<AccountData> accountsList,
  }) = _AccountsData;
}

@freezed
class AccountData with _$AccountData {
  const factory AccountData({
    required String name,
    required String username,
    required String password,
    required bool private,
  }) = _AccountData;

  factory AccountData.empty() => const AccountData(
        name: '',
        username: '',
        password: '',
        private: false,
      );
}

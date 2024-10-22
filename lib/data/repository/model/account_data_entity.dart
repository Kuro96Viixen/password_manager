import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_data_entity.freezed.dart';

@freezed
class AccountsDataEntity with _$AccountsDataEntity {
  const factory AccountsDataEntity({
    required List<AccountDataEntity> accountsList,
  }) = _AccountsDataEntity;

  factory AccountsDataEntity.empty() => const AccountsDataEntity(
        accountsList: [],
      );
}

@freezed
class AccountDataEntity with _$AccountDataEntity {
  const factory AccountDataEntity({
    required String name,
    required String username,
    required String password,
    required bool private,
  }) = _AccountDataEntity;

  factory AccountDataEntity.empty() => const AccountDataEntity(
        name: '',
        username: '',
        password: '',
        private: false,
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_data_memory_entity.freezed.dart';

@freezed
sealed class AccountsDataMemoryEntity with _$AccountsDataMemoryEntity {
  const factory AccountsDataMemoryEntity({
    required List<AccountDataMemoryEntity> accountsList,
  }) = _AccountsDataMemoryEntity;

  factory AccountsDataMemoryEntity.empty() =>
      const AccountsDataMemoryEntity(accountsList: []);
}

@freezed
sealed class AccountDataMemoryEntity with _$AccountDataMemoryEntity {
  const factory AccountDataMemoryEntity({
    required String name,
    required String username,
    required String password,
    required String passwordIV,
    required bool private,
  }) = _AccountDataMemoryEntity;
}

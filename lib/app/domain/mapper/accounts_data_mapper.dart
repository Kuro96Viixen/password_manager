import 'dart:convert';

import 'package:password_manager/app/domain/model/accounts_data.dart';

extension AccountsDataExtension on AccountsData {
  String toStore() => jsonEncode(accountsList.map((e) => e.toJson()).toList());
}

extension AccountDataExtension on AccountData {
  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'password': password,
        'passwordIV': passwordIV,
        'private': private,
      };

  AccountData fromJson(Map<String, dynamic> json) => AccountData(
        name: json['name'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
        passwordIV: json['passwordIV'] as String,
        private: json['private'] as bool,
      );
}

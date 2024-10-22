import 'dart:convert';

import 'package:password_manager/domain/model/accounts_data.dart';

extension AccountsDataExtension on AccountsData {
  String toStore() => jsonEncode(accountsList.map((e) => e.toJson()).toList());
}

extension AccountDataExtension on AccountData {
  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'password': password,
        'private': private,
      };

  String toCSV() => '$name,$username,$password,$private\n';

  AccountData fromJson(Map<String, dynamic> json) => AccountData(
        name: json['name'],
        username: json['username'],
        password: json['password'],
        private: json['private'],
      );

  AccountData fromCSV(String csv) => AccountData(
        name: csv.split(',')[0],
        username: csv.split(',')[1],
        password: csv.split(',')[2],
        private: csv.split(',')[3] == 'true',
      );
}

class Account {
  String name;
  String username;
  String password;
  bool private;

  Account({
    required this.name,
    required this.username,
    required this.password,
    required this.private,
  });

  @override
  String toString() =>
      'name: $name, username: $username, password: $password, private: $private';

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "password": password,
        "private": private,
      };

  Account.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        username = json['username'],
        password = json['password'],
        private = json['private'];

  String toCSV() => '$name,$username,$password,$private';

  Account fromCSV(String csv) {
    List splitted = csv.split(',');
    return Account(
      name: splitted[0],
      username: splitted[1],
      password: splitted[2],
      private: splitted[3] == 'true',
    );
  }
}

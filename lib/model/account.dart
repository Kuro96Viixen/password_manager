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

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'password': password,
        'private': private,
      };

  Account.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        username = json['username'],
        password = json['password'],
        private = json['private'];

  String toCSV() => '$name,$username,$password,$private\n';

  Account.fromCSV(String csv)
      : name = csv.split(',')[0],
        username = csv.split(',')[1],
        password = csv.split(',')[2],
        private = csv.split(',')[3] == 'true';
}

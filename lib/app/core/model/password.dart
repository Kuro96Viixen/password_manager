import 'package:equatable/equatable.dart';

final class Password extends Equatable {
  const Password({
    required this.password,
    required this.iv,
  });

  final String password;
  final String iv;

  @override
  List<Object?> get props => [password, iv];
}

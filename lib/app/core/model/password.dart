import 'package:freezed_annotation/freezed_annotation.dart';

part 'password.freezed.dart';

@freezed
sealed class Password with _$Password {
  const factory Password({
    required String password,
    required String iv,
  }) = _Password;
}

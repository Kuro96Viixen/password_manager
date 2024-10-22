import 'package:freezed_annotation/freezed_annotation.dart';

part 'errors.freezed.dart';

@freezed
class ErrorStatus with _$ErrorStatus {
  const factory ErrorStatus.unknown() = _Unknown;
}

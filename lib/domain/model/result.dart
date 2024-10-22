import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/domain/model/errors.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.failure({
    required ErrorStatus error,
    String? message,
  }) = _Failure<T>;

  const factory Result.success({
    required T data,
  }) = _Success<T>;
}

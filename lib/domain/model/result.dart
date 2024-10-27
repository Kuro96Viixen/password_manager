import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/domain/model/error_type.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.failure({
    ErrorType? errorType,
  }) = _Failure<T>;

  const factory Result.success({
    required T data,
  }) = _Success<T>;
}

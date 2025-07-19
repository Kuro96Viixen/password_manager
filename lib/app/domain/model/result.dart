import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:password_manager/app/domain/model/error_type.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.failure({
    ErrorType? errorType,
  }) = Failure<T>;

  const factory Result.success({
    required T data,
  }) = Success<T>;
}

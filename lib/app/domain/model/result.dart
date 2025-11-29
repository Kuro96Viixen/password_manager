import 'package:equatable/equatable.dart';
import 'package:password_manager/app/domain/model/error_type.dart';

sealed class Result<T> extends Equatable {
  const Result();

  const factory Result.failure({ErrorType? errorType}) = Failure<T>;
  const factory Result.success({required T data}) = Success<T>;

  @override
  List<Object?> get props => [];
}

final class Failure<T> extends Result<T> {
  const Failure({this.errorType});

  final ErrorType? errorType;

  @override
  List<Object?> get props => [errorType];
}

final class Success<T> extends Result<T> {
  const Success({required this.data});

  final T data;

  @override
  List<Object?> get props => [data];
}

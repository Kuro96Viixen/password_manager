import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_type.freezed.dart';

@freezed
sealed class ErrorType with _$ErrorType {
  const factory ErrorType.pickFileException() = _PickFileException;

  const factory ErrorType.pickFolderException() = _PickFolderException;
}

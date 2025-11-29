import 'package:equatable/equatable.dart';

final class ErrorType extends Equatable {
  const ErrorType._();

  const factory ErrorType.pickFileException() = ErrorTypePickFileException;
  const factory ErrorType.pickFolderException() = ErrorTypePickFolderException;

  @override
  List<Object?> get props => [];
}

final class ErrorTypePickFileException extends ErrorType {
  const ErrorTypePickFileException() : super._();
}

final class ErrorTypePickFolderException extends ErrorType {
  const ErrorTypePickFolderException() : super._();
}

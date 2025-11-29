import 'package:equatable/equatable.dart';

sealed class DuplicatedPasswordCheckerEvent extends Equatable {
  const DuplicatedPasswordCheckerEvent();

  @override
  List<Object?> get props => [];
}

final class DuplicatedPasswordCheckerStarted
    extends DuplicatedPasswordCheckerEvent {
  const DuplicatedPasswordCheckerStarted();
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'duplicated_password_checker_event.freezed.dart';

@freezed
sealed class DuplicatedPasswordCheckerEvent
    with _$DuplicatedPasswordCheckerEvent {
  const factory DuplicatedPasswordCheckerEvent.started() = Started;
}

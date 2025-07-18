import 'package:freezed_annotation/freezed_annotation.dart';

part 'private_event.freezed.dart';

@freezed
class PrivateEvent with _$PrivateEvent {
  const factory PrivateEvent.started() = Started;

  // Account List Tile
  const factory PrivateEvent.pressedAccount(int accountIndex) = PressedAccount;

  // Search Bar
  const factory PrivateEvent.searchAccount(String searchString) = SearchAccount;

  // Event Consumer
  const factory PrivateEvent.markNavigationEventAsConsumed() =
      MarkNavigationEventAsConsumed;
}

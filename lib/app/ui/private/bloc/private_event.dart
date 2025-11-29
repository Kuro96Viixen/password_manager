import 'package:equatable/equatable.dart';

sealed class PrivateEvent extends Equatable {
  const PrivateEvent();

  @override
  List<Object?> get props => [];
}

final class PrivateStarted extends PrivateEvent {
  const PrivateStarted();
}

// Account List Tile
final class PrivatePressedAccount extends PrivateEvent {
  const PrivatePressedAccount(this.accountIndex);

  final int accountIndex;

  @override
  List<Object?> get props => [accountIndex];
}

// Search Bar
final class PrivateSearchAccount extends PrivateEvent {
  const PrivateSearchAccount(this.searchString);

  final String searchString;

  @override
  List<Object?> get props => [searchString];
}

// Event Consumer
final class MarkNavigationEventAsConsumed extends PrivateEvent {
  const MarkNavigationEventAsConsumed();
}

import 'package:equatable/equatable.dart';
import 'package:password_manager/app/domain/model/accounts_data.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

final class DetailsStarted extends DetailsEvent {
  const DetailsStarted(this.accountData);

  final AccountData accountData;

  @override
  List<Object?> get props => [accountData];
}

// AppBar Buttons Pressed
final class PressedDelete extends DetailsEvent {
  const PressedDelete();
}

// Delete Account Pop-Up Button
final class DeleteAccount extends DetailsEvent {
  const DeleteAccount(this.accountData);

  final AccountData accountData;

  @override
  List<Object?> get props => [accountData];
}

// Passwords Events
final class RevealPassword extends DetailsEvent {
  const RevealPassword();
}

final class CopyPassword extends DetailsEvent {
  const CopyPassword();
}

// Modify Button
final class PressedModify extends DetailsEvent {
  const PressedModify();
}

// Event Consumer
// No need to consume goBackEvent as it will close the page
// final class MarkGoBackAsConsumed extends DetailsEvent {
//   const MarkGoBackAsConsumed();
// }
final class MarkModifyAsConsumed extends DetailsEvent {
  const MarkModifyAsConsumed();
}

final class MarkCopySnackBarAsConsumed extends DetailsEvent {
  const MarkCopySnackBarAsConsumed();
}

final class MarkPopUpAsConsumed extends DetailsEvent {
  const MarkPopUpAsConsumed();
}

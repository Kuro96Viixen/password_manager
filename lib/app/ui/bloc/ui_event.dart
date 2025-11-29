import 'package:equatable/equatable.dart';

/// A generic wrapper for managing one-time UI events, such as showing a
/// SnackBar, a dialog, or performing a navigation action.
///
/// ## The Problem This Solves
///
/// In state-driven architectures like BLoC, a state can persist and be read
/// multiple times by the UI (e.g., after a screen rotation). If a state like
/// `ApiFailure` is used to trigger a SnackBar, the SnackBar would reappear
/// every time the UI rebuilds, which is unintended behavior.
///
/// ## The Solution
///
/// `UIEvent` wraps the event data (e.g., an error message) along with a
/// [consumed] boolean flag. The UI listens for changes to this object and only
/// reacts if the event has not yet been consumed (`consumed == false`).
///
/// Once the UI has processed the event (e.g., displayed the SnackBar), it
/// notifies the BLoC to mark the event as consumed. This is achieved by
/// emitting a new state where the `UIEvent`'s `consumed` property is set to `true`.
///
/// ## Typical Usage
///
/// 1. **In the BLoC State:**
///    ```dart
///    final class MyState extends Equatable {
///      const MyState({
///        // ... other state fields
///        this.errorMessage = const UIEvent(consumed: true),
///      });
///
///      final UIEvent<String> errorMessage;
///
///      @override
///      List<Object?> get props => [errorMessage, ...];
///    }
///    ```
///
/// 2. **In the BLoC (emitting an event):**
///    ```dart
///    emit(state.copyWith(errorMessage: UIEvent(data: 'Invalid credentials')));
///    ```
///
/// 3. **In the UI (`BlocListener`):**
///    ```dart
///    BlocListener<MyBloc, MyState>(
///      listenWhen: (prev, curr) => !curr.errorMessage.consumed,
///      listener: (context, state) {
///        ScaffoldMessenger.of(context).showSnackBar(...);
///        // Notify the BLoC to mark the event as consumed
///        context.read<MyBloc>().add(MarkErrorMessageAsConsumed());
///      },
///      child: ...
///    )
///    ```
///
/// 4. **In the BLoC (marking as consumed):**
///    ```dart
///    void _onMarkErrorMessageAsConsumed(
///      MarkErrorMessageAsConsumed event,
///      Emitter<MyState> emit,
///    ) {
///      emit(state.copyWith(errorMessage: state.errorMessage.asConsumed()));
///    }
///    ```
///
/// @param T The type of data held by the event. This can be `void` if the
///          event only needs to signal an occurrence without carrying data.
final class UIEvent<T> extends Equatable {
  /// Creates an instance of [UIEvent].
  ///
  /// [data] holds the information associated with the event (e.g., an error
  /// message). It can be null.
  ///
  /// [consumed] indicates whether the UI has already processed this event.
  /// It defaults to `false`, signifying a new, unprocessed event.
  const UIEvent({
    this.data,
    this.consumed = false,
  });

  final T? data;
  final bool consumed;

  @override
  List<Object?> get props => [data, consumed];

  /// Returns a new instance of [UIEvent] with the [consumed] flag
  /// set to `true`.
  ///
  /// This is a convenience method to simplify marking an event as consumed
  /// within the BLoC, ensuring immutability.
  ///
  /// Usage: `emit(state.copyWith(myEvent: state.myEvent.asConsumed()));`
  UIEvent<T> asConsumed() => UIEvent(data: data, consumed: true);
}

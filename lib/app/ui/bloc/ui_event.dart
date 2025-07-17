import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_event.freezed.dart';

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
///    @freezed
///    class MyState with _$MyState {
///      factory MyState({
///        // ... other state fields
///        @Default(UIEvent()) UIEvent<String> errorMessage,
///      }) = _MyState;
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
///    on<MarkErrorMessageAsConsumed>((event, emit) {
///      emit(state.copyWith(errorMessage: state.errorMessage.asConsumed()));
///    });
///    ```
///
/// @param T The type of data held by the event. This can be `void` if the
///          event only needs to signal an occurrence without carrying data.
@freezed
class UIEvent<T> with _$UIEvent<T> {
  /// Creates an instance of [UIEvent].
  ///
  /// [data] holds the information associated with the event (e.g., an error
  /// message). It can be null.
  ///
  /// [consumed] indicates whether the UI has already processed this event.
  /// It defaults to `false`, signifying a new, unprocessed event.
  const factory UIEvent({
    T? data,
    @Default(false) bool consumed,
  }) = _UIEvent;

  /// A private constructor to allow adding extension methods.
  const UIEvent._();

  /// Returns a new instance of [UIEvent] with the [consumed] flag
  /// set to `true`.
  ///
  /// This is a convenience method to simplify marking an event as consumed
  /// within the BLoC, ensuring immutability.
  ///
  /// Usage: `emit(state.copyWith(myEvent: state.myEvent.asConsumed()));`
  UIEvent<T> asConsumed() => copyWith(consumed: true);
}

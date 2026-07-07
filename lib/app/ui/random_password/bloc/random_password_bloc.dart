import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/validation.dart';
import 'package:password_manager/app/domain/use_cases/calculate_password_strength_use_case.dart';
import 'package:password_manager/app/domain/use_cases/generate_random_password_use_case.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_event.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_state.dart';

class RandomPasswordBloc
    extends Bloc<RandomPasswordEvent, RandomPasswordState> {
  final GenerateRandomPasswordUseCase generateRandomPasswordUseCase;
  // Password Strength Use Case
  final CalculatePasswordStrengthUseCase calculatePasswordStrengthUseCase;

  RandomPasswordBloc({
    required this.generateRandomPasswordUseCase,
    required this.calculatePasswordStrengthUseCase,
  }) : super(RandomPasswordState.initial()) {
    on<OnRandomPasswordLengthChanged>(_onOnRandomPasswordLengthChanged);
    on<HasSpanishCharacters>(_onHasSpanishCharacters);
    on<HasNumbersCharacters>(_onHasNumbersCharacters);
    on<HasSymbolsCharacters>(_onHasSymbolsCharacters);
    on<GenerateRandomPassword>(_onGenerateRandomPassword);
    on<CopyPassword>(_onCopyPassword);
    on<MarkCopySnackBarEventAsConsumed>(_onMarkCopySnackBarEventAsConsumed);
  }

  void _onOnRandomPasswordLengthChanged(
    OnRandomPasswordLengthChanged event,
    Emitter<RandomPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        randomPasswordLength:
            int.tryParse(event.randomPasswordLengthString) ??
            kDefaultPasswordLength,
      ),
    );
  }

  void _onHasSpanishCharacters(
    HasSpanishCharacters event,
    Emitter<RandomPasswordState> emit,
  ) {
    emit(state.copyWith(hasSpanishCharacters: event.hasSpanishCharacters));
  }

  void _onHasNumbersCharacters(
    HasNumbersCharacters event,
    Emitter<RandomPasswordState> emit,
  ) {
    emit(state.copyWith(hasNumbersCharacters: event.hasNumbersCharacters));
  }

  void _onHasSymbolsCharacters(
    HasSymbolsCharacters event,
    Emitter<RandomPasswordState> emit,
  ) {
    emit(state.copyWith(hasSymbolsCharacters: event.hasSymbolsCharacters));
  }

  void _onGenerateRandomPassword(
    GenerateRandomPassword event,
    Emitter<RandomPasswordState> emit,
  ) {
    final randomPassword = generateRandomPasswordUseCase(
      length: state.randomPasswordLength,
      hasSpanishCharacters: state.hasSpanishCharacters,
      hasNumbersCharacters: state.hasNumbersCharacters,
      hasSymbolsCharacters: state.hasSymbolsCharacters,
    );

    final passwordStrength = calculatePasswordStrengthUseCase(randomPassword);

    emit(
      state.copyWith(
        randomPassword: randomPassword,
        randomPasswordStrength: passwordStrength,
      ),
    );
  }

  void _onCopyPassword(CopyPassword event, Emitter<RandomPasswordState> emit) {
    Clipboard.setData(ClipboardData(text: state.randomPassword));

    emit(
      state.copyWith(
        copySnackBarEvent: const UIEvent(),
      ),
    );
  }

  void _onMarkCopySnackBarEventAsConsumed(
    MarkCopySnackBarEventAsConsumed event,
    Emitter<RandomPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        copySnackBarEvent: state.copySnackBarEvent.asConsumed(),
      ),
    );
  }
}

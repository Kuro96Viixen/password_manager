import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/ui/bloc/ui_event.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_event.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_state.dart';
import 'package:password_manager/utils/utils.dart';

class RandomPasswordBloc
    extends Bloc<RandomPasswordEvent, RandomPasswordState> {
  RandomPasswordBloc() : super(RandomPasswordState.initial()) {
    on<RandomPasswordEvent>((event, emit) {
      switch (event) {
        case OnRandomPasswordLengthChanged(
            randomPasswordLengthString: final randomPasswordLength
          ):
          emit(
            state.copyWith(
              randomPasswordLength: int.tryParse(randomPasswordLength) ?? 10,
            ),
          );
        case HasSpanishCharacters(
            hasSpanishCharacters: final hasSpanishCharacters
          ):
          emit(state.copyWith(hasSpanishCharacters: hasSpanishCharacters));
        case HasNumbersCharacters(
            hasNumbersCharacters: final hasNumbersCharacters
          ):
          emit(state.copyWith(hasNumbersCharacters: hasNumbersCharacters));
        case HasSymbolsCharacters(
            hasSymbolsCharacters: final hasSymbolsCharacters
          ):
          emit(state.copyWith(hasSymbolsCharacters: hasSymbolsCharacters));
        case GenerateRandomPassword():
          final randomPassword = Utils.generateRandomPassword(
            length: state.randomPasswordLength,
            hasSpanishCharacters: state.hasSpanishCharacters,
            hasNumbersCharacters: state.hasNumbersCharacters,
            hasSymbolsCharacters: state.hasSymbolsCharacters,
          );

          emit(
            state.copyWith(
              randomPassword: randomPassword,
            ),
          );
        case CopyPassword():
          Clipboard.setData(ClipboardData(text: state.randomPassword));

          emit(
            state.copyWith(
              snackBarEvent: UIEvent(
                data: Texts.copiedToClipboard,
              ),
            ),
          );
        case MarkSnackBarEventAsConsumed():
          emit(state.copyWith(snackBarEvent: state.snackBarEvent.asConsumed()));
      }
    });
  }
}

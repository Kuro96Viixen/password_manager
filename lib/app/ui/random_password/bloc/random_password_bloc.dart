import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_event.dart';
import 'package:password_manager/app/ui/random_password/bloc/random_password_state.dart';
import 'package:password_manager/utils/utils.dart';

class RandomPasswordBloc
    extends Bloc<RandomPasswordEvent, RandomPasswordState> {
  RandomPasswordBloc() : super(RandomPasswordState.initial()) {
    on<RandomPasswordEvent>((event, emit) {
      event.when(
        onRandomPasswordLengthChanged: (randomPasswordLength) {
          emit(
            state.copyWith(
              randomPasswordLength: int.tryParse(randomPasswordLength) ?? 10,
            ),
          );
        },
        hasSpanishCharacters: (hasSpanishCharacters) {
          emit(state.copyWith(hasSpanishCharacters: hasSpanishCharacters));
        },
        hasNumbersCharacters: (hasNumbersCharacters) {
          emit(state.copyWith(hasNumbersCharacters: hasNumbersCharacters));
        },
        hasSymbolsCharacters: (hasSymbolsCharacters) {
          emit(state.copyWith(hasSymbolsCharacters: hasSymbolsCharacters));
        },
        generateRandomPassword: () {
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
        },
        copyPassword: () {
          Clipboard.setData(ClipboardData(text: state.randomPassword));

          emit(
            state.copyWith(
              navigationState: RandomPasswordNavigationState.showSnackBar(
                Texts.copiedToClipboard,
              ),
            ),
          );

          emit(state.copyWith(navigationState: null));
        },
      );
    });
  }
}

import 'dart:math';

class GenerateRandomPasswordUseCase {
  String call({
    required int length,
    required bool hasSpanishCharacters,
    required bool hasNumbersCharacters,
    required bool hasSymbolsCharacters,
  }) {
    // Name can be somethingPool for funny themed variables
    const lowerCaseTrack = 'abcdefghijklmnopqrstuvwxyz';
    const upperCaseTrack = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const spanishTrack = 'ñÑ';
    const numbersTrack = '0123456789';
    const symbolsTrack = r'!@#$%*()?_=<>/[]+-';

    // Names can be lifeguards and finalDeepEnd for funny themed variables
    final director = Random.secure();
    final remix = <String>[];

    // Name can be aquaticCenter for funny themed variables
    var playlist = '$lowerCaseTrack$upperCaseTrack';

    remix
      ..add(lowerCaseTrack[director.nextInt(lowerCaseTrack.length)])
      ..add(upperCaseTrack[director.nextInt(upperCaseTrack.length)]);

    if (hasSpanishCharacters) {
      playlist += spanishTrack;
      remix.add(spanishTrack[director.nextInt(spanishTrack.length)]);
    }
    if (hasNumbersCharacters) {
      playlist += numbersTrack;
      remix.add(numbersTrack[director.nextInt(numbersTrack.length)]);
    }
    if (hasSymbolsCharacters) {
      playlist += symbolsTrack;
      remix.add(symbolsTrack[director.nextInt(symbolsTrack.length)]);
    }

    if (remix.length >= length) {
      remix.shuffle(director);
      return remix.sublist(0, length).join();
    }

    final remainingLength = length - remix.length;
    for (var i = 0; i < remainingLength; i++) {
      remix.add(playlist[director.nextInt(playlist.length)]);
    }

    remix.shuffle(director);

    // Mr. Worldwide
    return remix.join();
  }
}

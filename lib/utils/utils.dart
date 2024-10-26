import 'dart:math';

class Utils {
  static String generateRandomPassword({
    required int length,
    required bool hasSpanishCharacters,
    required bool hasNumbersCharacters,
    required bool hasSymbolsCharacters,
  }) {
    const lowerCaseChars = 'abcdefghijklmnopqrstuvwxyz';
    const upperCaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const spanishCharacters = 'ñÑ';
    const numbersCharacters = '0123456789';
    const symbolsCharacters = '@#%*<>\$@?/()[]=+';

    String chars = '$lowerCaseChars$upperCaseChars';
    if (hasSpanishCharacters) chars += spanishCharacters;
    if (hasNumbersCharacters) chars += numbersCharacters;
    if (hasSymbolsCharacters) chars += symbolsCharacters;

    chars = (chars.split('')..shuffle()).join('');

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);

      return chars[indexRandom];
    }).join('');
  }
}

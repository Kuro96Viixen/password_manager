import 'package:password_manager/app/core/constants/validation.dart';
import 'package:password_manager/app/domain/model/password_strength.dart';

class CalculatePasswordStrengthUseCase {
  PasswordStrength call(String text) {
    if (text.isEmpty) {
      return PasswordStrength.unset;
    }

    if (text.length < kDefaultPasswordLength) {
      return PasswordStrength.weak;
    }

    var counter = 0;
    if (text.contains(RegExp('[a-zñ]'))) counter++;
    if (text.contains(RegExp('[A-ZÑ]'))) counter++;
    if (text.contains(RegExp('[0-9]'))) counter++;
    if (text.contains(RegExp(r'[!@#$%*()?_=<>/[\]+-]'))) counter++;

    return switch (counter) {
      1 => PasswordStrength.weak,
      2 => PasswordStrength.medium,
      3 => PasswordStrength.strong,
      4 => PasswordStrength.secure,
      _ => PasswordStrength.weak,
    };
  }
}

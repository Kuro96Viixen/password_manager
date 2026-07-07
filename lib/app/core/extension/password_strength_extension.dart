import 'package:flutter/material.dart';
import 'package:password_manager/app/domain/model/password_strength.dart';

extension PasswordStrengthExtension on PasswordStrength {
  /// The color for every status.
  Color get statusColor => switch (this) {
    PasswordStrength.unset => Colors.grey.shade300,
    PasswordStrength.weak => Colors.red,
    PasswordStrength.medium => Colors.orange,
    PasswordStrength.strong => Colors.green,
    PasswordStrength.secure => const Color(0xFF0B6C0E),
  };

  /// The percentual width of every status.
  double get widthPercentage => switch (this) {
    PasswordStrength.unset => 0,
    PasswordStrength.weak => 0.15,
    PasswordStrength.medium => 0.4,
    PasswordStrength.strong => 0.75,
    PasswordStrength.secure => 1.0,
  };
}

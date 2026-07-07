import 'package:password_manager/widgets/password_strength/model/year_magnitude.dart';

sealed class PasswordValue {
  const PasswordValue();
}

class NumberValue extends PasswordValue {
  const NumberValue(this.value);

  final int value;
}

class InstantlyValue extends PasswordValue {
  const InstantlyValue();
}

class MinutesValue extends PasswordValue {
  const MinutesValue(this.value);

  final int value;
}

class HoursValue extends PasswordValue {
  const HoursValue(this.value);

  final int value;
}

class DaysValue extends PasswordValue {
  const DaysValue(this.value);

  final int value;
}

class WeeksValue extends PasswordValue {
  const WeeksValue(this.value);

  final int value;
}

class MonthsValue extends PasswordValue {
  const MonthsValue(this.value);

  final int value;
}

class YearsValue extends PasswordValue {
  const YearsValue(
    this.value, {
    this.magnitude = YearMagnitude.none,
  });

  final int value;
  final YearMagnitude magnitude;
}

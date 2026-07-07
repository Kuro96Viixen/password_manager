import 'package:password_manager/widgets/password_strength/model/password_cell_color.dart';
import 'package:password_manager/widgets/password_strength/model/password_value.dart';
import 'package:password_manager/widgets/password_strength/model/year_magnitude.dart';

class PasswordTableCell {
  const PasswordTableCell({
    required this.value,
    required this.color,
  });

  final PasswordValue value;
  final PasswordCellColor color;

  factory PasswordTableCell.number(int value) {
    return PasswordTableCell(
      value: NumberValue(value),
      color: PasswordCellColor.blue,
    );
  }

  factory PasswordTableCell.instant() {
    return const PasswordTableCell(
      value: InstantlyValue(),
      color: PasswordCellColor.purple,
    );
  }

  factory PasswordTableCell.minutes(int value) {
    return PasswordTableCell(
      value: MinutesValue(value),
      color: PasswordCellColor.red,
    );
  }

  factory PasswordTableCell.hours(int value) {
    return PasswordTableCell(
      value: HoursValue(value),
      color: PasswordCellColor.red,
    );
  }

  factory PasswordTableCell.days(int value) {
    return PasswordTableCell(
      value: DaysValue(value),
      color: PasswordCellColor.red,
    );
  }

  factory PasswordTableCell.weeks(int value) {
    return PasswordTableCell(
      value: WeeksValue(value),
      color: PasswordCellColor.red,
    );
  }

  factory PasswordTableCell.months(int value) {
    return PasswordTableCell(
      value: MonthsValue(value),
      color: PasswordCellColor.red,
    );
  }

  factory PasswordTableCell.years(
    int value, {
    YearMagnitude magnitude = YearMagnitude.none,
    PasswordCellColor color = PasswordCellColor.green,
  }) {
    return PasswordTableCell(
      value: YearsValue(
        value,
        magnitude: magnitude,
      ),
      color: color,
    );
  }
}

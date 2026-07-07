import 'package:password_manager/widgets/password_strength/model/password_cell_color.dart';
import 'package:password_manager/widgets/password_strength/model/password_table_cell.dart';
import 'package:password_manager/widgets/password_strength/model/year_magnitude.dart';

final passwordTableRows = <List<PasswordTableCell>>[
  // 4
  [
    PasswordTableCell.number(4),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
  ],

  // 5
  [
    PasswordTableCell.number(5),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
  ],

  // 6
  [
    PasswordTableCell.number(6),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.minutes(17),
  ],

  // 7
  [
    PasswordTableCell.number(7),
    PasswordTableCell.instant(),
    PasswordTableCell.instant(),
    PasswordTableCell.hours(2),
    PasswordTableCell.hours(9),
    PasswordTableCell.hours(20),
  ],

  // 8
  [
    PasswordTableCell.number(8),
    PasswordTableCell.instant(),
    PasswordTableCell.minutes(30),
    PasswordTableCell.days(5),
    PasswordTableCell.weeks(3),
    PasswordTableCell.months(2),
  ],

  // 9
  [
    PasswordTableCell.number(9),
    PasswordTableCell.instant(),
    PasswordTableCell.hours(13),
    PasswordTableCell.months(9),
    PasswordTableCell.years(4, color: PasswordCellColor.orange),
    PasswordTableCell.years(11, color: PasswordCellColor.orange),
  ],

  // 10
  [
    PasswordTableCell.number(10),
    PasswordTableCell.instant(),
    PasswordTableCell.weeks(2),
    PasswordTableCell.years(40, color: PasswordCellColor.orange),
    PasswordTableCell.years(232, color: PasswordCellColor.orange),
    PasswordTableCell.years(779, color: PasswordCellColor.orange),
  ],

  // 11
  [
    PasswordTableCell.number(11),
    PasswordTableCell.instant(),
    PasswordTableCell.years(1, color: PasswordCellColor.red),
    PasswordTableCell.years(
      2,
      magnitude: YearMagnitude.thousand,
      color: PasswordCellColor.orange,
    ),
    PasswordTableCell.years(
      14,
      magnitude: YearMagnitude.thousand,
      color: PasswordCellColor.orange,
    ),
    PasswordTableCell.years(
      54,
      magnitude: YearMagnitude.thousand,
      color: PasswordCellColor.orange,
    ),
  ],

  // 12
  [
    PasswordTableCell.number(12),
    PasswordTableCell.hours(2),
    PasswordTableCell.years(26, color: PasswordCellColor.orange),
    PasswordTableCell.years(
      107,
      magnitude: YearMagnitude.thousand,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(
      889,
      magnitude: YearMagnitude.thousand,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(
      3,
      magnitude: YearMagnitude.million,
      color: PasswordCellColor.yellow,
    ),
  ],

  // 13
  [
    PasswordTableCell.number(13),
    PasswordTableCell.days(1),
    PasswordTableCell.years(684, color: PasswordCellColor.orange),
    PasswordTableCell.years(
      5,
      magnitude: YearMagnitude.million,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(
      55,
      magnitude: YearMagnitude.million,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(
      267,
      magnitude: YearMagnitude.million,
      color: PasswordCellColor.yellow,
    ),
  ],

  // 14
  [
    PasswordTableCell.number(14),
    PasswordTableCell.weeks(1),
    PasswordTableCell.years(
      17,
      magnitude: YearMagnitude.thousand,
      color: PasswordCellColor.orange,
    ),
    PasswordTableCell.years(
      291,
      magnitude: YearMagnitude.million,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(
      3,
      magnitude: YearMagnitude.billion,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(18, magnitude: YearMagnitude.billion),
  ],

  // 15
  [
    PasswordTableCell.number(15),
    PasswordTableCell.months(3),
    PasswordTableCell.years(
      462,
      magnitude: YearMagnitude.thousand,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(15, magnitude: YearMagnitude.billion),
    PasswordTableCell.years(212, magnitude: YearMagnitude.billion),
    PasswordTableCell.years(1, magnitude: YearMagnitude.trillion),
  ],

  // 16
  [
    PasswordTableCell.number(16),
    PasswordTableCell.years(3, color: PasswordCellColor.orange),
    PasswordTableCell.years(
      12,
      magnitude: YearMagnitude.million,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(788, magnitude: YearMagnitude.billion),
    PasswordTableCell.years(13, magnitude: YearMagnitude.trillion),
    PasswordTableCell.years(91, magnitude: YearMagnitude.trillion),
  ],

  // 17
  [
    PasswordTableCell.number(17),
    PasswordTableCell.years(28, color: PasswordCellColor.orange),
    PasswordTableCell.years(
      312,
      magnitude: YearMagnitude.million,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(40, magnitude: YearMagnitude.trillion),
    PasswordTableCell.years(815, magnitude: YearMagnitude.trillion),
    PasswordTableCell.years(6, magnitude: YearMagnitude.quadrillion),
  ],

  // 18
  [
    PasswordTableCell.number(18),
    PasswordTableCell.years(276, color: PasswordCellColor.orange),
    PasswordTableCell.years(
      8,
      magnitude: YearMagnitude.billion,
      color: PasswordCellColor.yellow,
    ),
    PasswordTableCell.years(2, magnitude: YearMagnitude.quadrillion),
    PasswordTableCell.years(50, magnitude: YearMagnitude.quadrillion),
    PasswordTableCell.years(449, magnitude: YearMagnitude.quadrillion),
  ],
];

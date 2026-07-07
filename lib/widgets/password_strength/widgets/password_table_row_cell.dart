import 'package:flutter/material.dart';
import 'package:password_manager/l10n/generated/app_localizations.dart';
import 'package:password_manager/widgets/password_strength/model/password_cell_color.dart';
import 'package:password_manager/widgets/password_strength/model/password_table_cell.dart';
import 'package:password_manager/widgets/password_strength/model/password_value.dart';
import 'package:password_manager/widgets/password_strength/model/year_magnitude.dart';

class PasswordTableRowCell extends StatelessWidget {
  final PasswordTableCell cell;

  const PasswordTableRowCell({required this.cell, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 150,
      alignment: Alignment.center,
      color: _backgroundColor(),
      padding: const EdgeInsets.all(8),
      child: Text(
        _localizedText(context, cell.value),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  String _localizedText(
    BuildContext context,
    PasswordValue value,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return switch (value) {
      NumberValue(:final value) => value.toString(),

      InstantlyValue() => l10n.passwordStrengthCrackChartInstantly,

      MinutesValue(:final value) => l10n.passwordStrengthCrackChartMinutes(
        value,
      ),

      HoursValue(:final value) => l10n.passwordStrengthCrackChartHours(value),

      DaysValue(:final value) => l10n.passwordStrengthCrackChartDays(value),

      WeeksValue(:final value) => l10n.passwordStrengthCrackChartWeeks(value),

      MonthsValue(:final value) => l10n.passwordStrengthCrackChartMonths(value),

      YearsValue(:final value, :final magnitude) => _yearsText(
        l10n,
        value,
        magnitude,
      ),
    };
  }

  String _yearsText(
    AppLocalizations l10n,
    int value,
    YearMagnitude magnitude,
  ) {
    return switch (magnitude) {
      YearMagnitude.none => l10n.passwordStrengthCrackChartYears(value),

      YearMagnitude.thousand => l10n.passwordStrengthCrackChartThousandYears(
        value,
      ),

      YearMagnitude.million => l10n.passwordStrengthCrackChartMillionYears(
        value,
      ),

      YearMagnitude.billion => l10n.passwordStrengthCrackChartBillionYears(
        value,
      ),

      YearMagnitude.trillion => l10n.passwordStrengthCrackChartTrillionYears(
        value,
      ),

      YearMagnitude.quadrillion =>
        l10n.passwordStrengthCrackChartQuadrillionYears(value),
    };
  }

  Color _backgroundColor() {
    return switch (cell.color) {
      PasswordCellColor.purple => const Color(0xFF9558A9),

      PasswordCellColor.red => const Color(0xFFE31837),

      PasswordCellColor.orange => const Color(0xFFFF8A1D),

      PasswordCellColor.yellow => const Color(0xFFFFB81C),

      PasswordCellColor.green => const Color(0xFF0CAD4D),

      PasswordCellColor.blue => const Color(0xFF3D567A),
    };
  }
}

import 'package:flutter/material.dart';
import 'package:password_manager/l10n/generated/app_localizations.dart';
import 'package:password_manager/widgets/password_strength/data/password_strength_table_rows.dart';
import 'package:password_manager/widgets/password_strength/widgets/password_table_row_cell.dart';

class PasswordStrengthChart extends StatelessWidget {
  const PasswordStrengthChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final headers = <String>[
      l10n.passwordStrengthCrackChartHeaderChars,
      l10n.passwordStrengthCrackChartHeaderNumbersOnly,
      l10n.passwordStrengthCrackChartHeaderLowercaseOnly,
      l10n.passwordStrengthCrackChartHeaderUpperLowercaseOnly,
      l10n.passwordStrengthCrackChartHeaderNumbersUpperLowercaseOnly,
      l10n.passwordStrengthCrackChartHeaderNumbersUpperLowercaseSymbols,
    ];

    return Table(
      // Equivalent to your 160px column width
      columnWidths: {
        for (int i = 0; i < headers.length; i++) i: const FixedColumnWidth(160),
      },

      children: [
        // Header row
        TableRow(
          children: headers.map((header) {
            return Container(
              height: 100,
              width: 160,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                header,
                textAlign: TextAlign.center,
                maxLines: 4,
                softWrap: true,
              ),
            );
          }).toList(),
        ),

        // Data rows
        ...passwordTableRows.map(
          (row) {
            return TableRow(
              children: row.map((cell) {
                return Container(
                  alignment: Alignment.center,
                  child: PasswordTableRowCell(cell: cell),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

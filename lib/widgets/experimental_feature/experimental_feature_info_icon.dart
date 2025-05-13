import 'package:flutter/material.dart';
import 'package:password_manager/app/core/constants/icons.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/widgets/experimental_feature/experimental_feature_info_dialog.dart';

class ExperimentalFeatureInfoIcon extends StatelessWidget {
  const ExperimentalFeatureInfoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) =>
            const ExperimentalFeatureInfoDialog(),
      ),
      icon: Icon(CommonIcons.info),
      tooltip: Texts.experimentalFeatureInfoTooltip,
    );
  }
}

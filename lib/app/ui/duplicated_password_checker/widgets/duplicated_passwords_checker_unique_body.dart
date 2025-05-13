import 'package:flutter/material.dart';
import 'package:password_manager/app/core/constants/texts.dart';

class DuplicatedPasswordsCheckerUniqueBody extends StatelessWidget {
  const DuplicatedPasswordsCheckerUniqueBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Texts.duplicatedPasswordCheckerViewSuccessDisclaimer,
      ),
    );
  }
}

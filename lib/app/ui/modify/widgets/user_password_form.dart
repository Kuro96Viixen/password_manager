import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/domain/model/password_strength.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_bloc.dart';
import 'package:password_manager/app/ui/modify/bloc/modify_event.dart';
import 'package:password_manager/app/ui/modify/widgets/account_text_field.dart';
import 'package:password_manager/l10n/generated/app_localizations.dart';
import 'package:password_manager/widgets/password_strength/widgets/password_strength_checker.dart';

class UserPasswordForm extends StatelessWidget {
  final bool isPasswordHidden;

  final PasswordStrength passwordStrength;

  const UserPasswordForm({
    required this.isPasswordHidden,
    required this.passwordStrength,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountTextField(
          label: AppLocalizations.of(
            context,
          )!.passwordTextFieldLabel,
          initialValue: '',
          onChangedText: (passwordString) => context.read<ModifyBloc>().add(
            OnPasswordChanged(
              passwordString,
            ),
          ),
          isPasswordHidden: isPasswordHidden,
          onPressed: () => context.read<ModifyBloc>().add(
            const HidePassword(),
          ),
        ),
        const SizedBox(height: 8),
        PasswordStrengthChecker(strength: passwordStrength),
      ],
    );
  }
}

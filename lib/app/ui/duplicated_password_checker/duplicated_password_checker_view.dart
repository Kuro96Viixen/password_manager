import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_bloc.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_event.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_state.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/widgets/duplicated_password_checker_success_body.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/widgets/duplicated_passwords_checker_loading_body.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/widgets/duplicated_passwords_checker_unique_body.dart';
import 'package:password_manager/l10n/app_localizations.dart';
import 'package:password_manager/widgets/confetti/confetti.dart';
import 'package:password_manager/widgets/confetti/confetti_options.dart';
import 'package:password_manager/widgets/confetti/confetti_star.dart';
import 'package:password_manager/widgets/experimental_feature/experimental_feature_info_icon.dart';

part 'duplicated_password_checker_methods.dart';

class DuplicatedPasswordCheckerView extends StatelessWidget {
  static String routeName = 'DuplicatedPasswordCheckerViewRoute';

  const DuplicatedPasswordCheckerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          uiModulesDi<DuplicatedPasswordCheckerBloc>()
            ..add(const DuplicatedPasswordCheckerEvent.started()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(
              context,
            )!.duplicatedPasswordCheckerViewTitle,
          ),
          actions: const [
            ExperimentalFeatureInfoIcon(),
          ],
        ),
        body:
            BlocConsumer<
              DuplicatedPasswordCheckerBloc,
              DuplicatedPasswordCheckerState
            >(
              listener: (context, state) => state.screenState.maybeWhen(
                unique: () => shootingStars(context),
                orElse: DoNothingAction.new,
              ),
              builder: (context, state) => state.screenState.when(
                loading: DuplicatedPasswordsCheckerLoadingBody.new,
                success: () =>
                    DuplicatedPasswordCheckerSuccessBody(state: state),
                unique: DuplicatedPasswordsCheckerUniqueBody.new,
              ),
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/app/core/constants/texts.dart';
import 'package:password_manager/app/di/app_di.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_bloc.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_event.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_state.dart';

class DuplicatedPasswordCheckerView extends StatelessWidget {
  static String routeName = 'DuplicatedPasswordCheckerViewRoute';

  const DuplicatedPasswordCheckerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uiModulesDi<DuplicatedPasswordCheckerBloc>()
        ..add(
          DuplicatedPasswordCheckerEvent.started(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Texts.duplicatedPasswordCheckerViewTitle),
        ),
        body: BlocConsumer<DuplicatedPasswordCheckerBloc,
            DuplicatedPasswordCheckerState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return state.screenState.when(
              loading: () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      Texts.duplicatedPasswordCheckerViewLoading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              success: () => Center(child: Text('Success')),
            );
          },
        ),
      ),
    );
  }
}

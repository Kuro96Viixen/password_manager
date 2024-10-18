import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/encrypt.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/utils/widgets.dart';

class ViewAccountViewArguments {
  int index;
  Account account;

  ViewAccountViewArguments(this.index, this.account);
}

class ViewAccountView extends StatefulWidget {
  final ViewAccountViewArguments arguments;

  const ViewAccountView(this.arguments, {super.key});

  @override
  State<ViewAccountView> createState() => _ViewAccountViewState();
}

class _ViewAccountViewState extends State<ViewAccountView> {
  bool revealedPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CustomWidgets.backButton(context),
          title: Text(Texts.viewAccountViewTitle),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomWidgets.viewAccountLabel(Texts.viewAccountNameLabel),
              CustomWidgets.viewAccountField(widget.arguments.account.name),
              CustomWidgets.viewAccountLabel(Texts.viewAccountUsernameLabel),
              CustomWidgets.viewAccountField(widget.arguments.account.username),
              CustomWidgets.viewAccountLabel(Texts.viewAccountPasswordLabel),
              GestureDetector(
                onLongPress: () => ClipboardData(
                  text: revealedPassword
                      ? Encryption.decryptPassword(
                          widget.arguments.account.password,
                        )
                      : '',
                ),
                child: CustomWidgets.viewAccountField(
                  revealedPassword
                      ? Encryption.decryptPassword(
                          widget.arguments.account.password,
                        )
                      : Texts.hiddenPasswordText,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Visibility(
                visible: !revealedPassword,
                child: CustomWidgets.button(
                  Texts.viewAccountViewPassword,
                  () => Utils.authenticate(
                    Texts.fingerprintPasswordAuthTitle,
                  ).then(
                    (value) => setState(
                      () => revealedPassword = value,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Utils.navigateToEdit(
            context,
            widget.arguments.index,
            widget.arguments.account,
          ),
          tooltip: Texts.viewAccountViewEditTooltip,
          child: Icon(CommonIcons.edit),
        ),
      ),
    );
  }
}

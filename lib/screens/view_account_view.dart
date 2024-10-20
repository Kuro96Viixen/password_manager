import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/routes.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/screens/add_edit_view.dart';
import 'package:password_manager/utils/encrypt.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/widgets/account_field.dart';
import 'package:password_manager/widgets/account_label.dart';

class ViewAccountViewArguments {
  int index;
  Account account;

  ViewAccountViewArguments(
    this.index,
    this.account,
  );
}

class ViewAccountView extends StatefulWidget {
  final ViewAccountViewArguments arguments;

  const ViewAccountView(
    this.arguments, {
    super.key,
  });

  @override
  State<ViewAccountView> createState() => _ViewAccountViewState();
}

class _ViewAccountViewState extends State<ViewAccountView> {
  bool revealedPassword = false;

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () => setState(() => revealedPassword = false),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              Texts.viewAccountViewTitle,
            ),
            actions: [
              IconButton(
                onPressed: () async =>
                    await Utils.deleteAccount(widget.arguments.account).then(
                  (_) => Navigator.of(context).pop(),
                ),
                icon: Icon(
                  CommonIcons.delete,
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountLabel(
                  text: Texts.viewAccountNameLabel,
                ),
                AccountField(
                  text: widget.arguments.account.name,
                ),
                AccountLabel(
                  text: Texts.viewAccountUsernameLabel,
                ),
                AccountField(
                  text: widget.arguments.account.username,
                ),
                AccountLabel(
                  text: Texts.viewAccountPasswordLabel,
                ),
                GestureDetector(
                  onLongPress: () {
                    if (revealedPassword) {
                      Clipboard.setData(
                        ClipboardData(
                          text: Encryption.decryptPassword(
                            widget.arguments.account.password,
                          ),
                        ),
                      ).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              Texts.copiedToClipboard,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: AccountField(
                    text: Encryption.decryptPassword(
                      widget.arguments.account.password,
                    ),
                    viewPassword: revealedPassword,
                  ),
                ),
                const SizedBox(height: 8.0),
                Visibility(
                  visible: !revealedPassword,
                  child: Center(
                    child: ElevatedButton(
                      child: Text(Texts.viewAccountViewPassword),
                      onPressed: () => Utils.authenticate(
                        Texts.fingerprintPasswordAuthTitle,
                      ).then(
                        (verified) => (verified)
                            ? setState(
                                () => revealedPassword = true,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed(
              Routes.addEdit,
              arguments: EditArguments(
                widget.arguments.index,
                widget.arguments.account,
              ),
            ),
            tooltip: Texts.viewAccountViewEditTooltip,
            child: Icon(
              CommonIcons.edit,
            ),
          ),
        ),
      ),
    );
  }
}

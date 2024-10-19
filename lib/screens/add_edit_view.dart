import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/encrypt.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/utils/widgets.dart';

class EditArguments {
  int index;
  Account account;

  EditArguments(
    this.index,
    this.account,
  );
}

class AddEditView extends StatefulWidget {
  final EditArguments? arguments;

  const AddEditView({
    super.key,
    this.arguments,
  });

  @override
  State<AddEditView> createState() => _AddEditViewState();
}

class _AddEditViewState extends State<AddEditView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordLengthController = TextEditingController();

  bool isRandomPassword = false;

  String randomPassword = '';

  bool hasSpanish = true;
  bool hasNumbers = true;
  bool hasSymbols = true;

  bool isPrivate = false;

  bool viewPassword = true;

  @override
  void initState() {
    super.initState();

    if (widget.arguments != null) {
      nameController.text = widget.arguments!.account.name;
      usernameController.text = widget.arguments!.account.username;
      isPrivate = widget.arguments!.account.private;
    }

    nameController.addListener(
      () => setState(
        () {},
      ),
    );
    usernameController.addListener(
      () => setState(
        () {},
      ),
    );
    passwordController.addListener(
      () => setState(
        () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool viewSave = nameController.text != '' &&
        usernameController.text != '' &&
        (passwordController.text != '' || randomPassword != '');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CustomWidgets.backButton(context),
          title: Text(
            widget.arguments == null ? Texts.addViewTitle : Texts.editViewTitle,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                children: [
                  Column(
                    children: [
                      CustomWidgets.textField(
                          Texts.nameTextFieldLabel, nameController),
                      CustomWidgets.textField(
                          Texts.usernameTextFieldLabel, usernameController),
                      CustomWidgets.spacer(),
                      SwitchListTile(
                        value: isRandomPassword,
                        onChanged: (value) => setState(
                          () {
                            FocusScope.of(context).unfocus();

                            isRandomPassword = value;

                            passwordController.text = '';
                            randomPassword = '';
                          },
                        ),
                        title: Text(
                          Texts.useRandomPasswordSwitchTitle,
                        ),
                      ),
                      Visibility(
                        visible: !isRandomPassword,
                        child: CustomWidgets.textField(
                          Texts.passwordTextFieldLabel,
                          passwordController,
                          viewPassword: viewPassword,
                          pressedViewPassword: () => setState(
                            () => viewPassword = !viewPassword,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isRandomPassword,
                        child: _randomPasswordForm(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: viewSave,
              child: _bottomForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomForm() => Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Column(
          children: [
            CheckboxListTile(
              value: isPrivate,
              onChanged: (value) => setState(
                () => isPrivate = value!,
              ),
              title: Text(Texts.isPrivateAccountCheckBoxTitle),
            ),
            CustomWidgets.spacer(),
            CustomWidgets.button(
              Texts.saveAccountButton,
              () async => widget.arguments == null
                  ? await Utils.saveNewAccount(
                      Account(
                        name: nameController.text,
                        username: usernameController.text,
                        password: Encryption.encryptPassword(
                          isRandomPassword
                              ? randomPassword
                              : passwordController.text,
                        ),
                        private: isPrivate,
                      ),
                    ).then(
                      (_) => Navigator.of(context).pop(),
                    )
                  : await Utils.editAccount(
                      widget.arguments!.index,
                      Account(
                        name: nameController.text,
                        username: usernameController.text,
                        password: Encryption.encryptPassword(
                          isRandomPassword
                              ? randomPassword
                              : passwordController.text,
                        ),
                        private: isPrivate,
                      ),
                    ).then(
                      (_) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
            ),
          ],
        ),
      );

  Widget _randomPasswordForm() => Column(
        children: [
          CustomWidgets.textField(
            Texts.passwordLengthTextFieldLabel,
            passwordLengthController,
          ),
          CustomWidgets.spacer(),
          CheckboxListTile(
            value: hasSpanish,
            onChanged: (value) => setState(
              () => hasSpanish = value!,
            ),
            title: Text(
              Texts.spanishCheckBoxTitle,
            ),
          ),
          CustomWidgets.spacer(),
          CheckboxListTile(
            value: hasNumbers,
            onChanged: (value) => setState(
              () => hasNumbers = value!,
            ),
            title: Text(
              Texts.numbersCheckBoxTitle,
            ),
          ),
          CheckboxListTile(
            value: hasSymbols,
            onChanged: (value) => setState(
              () => hasSymbols = value!,
            ),
            title: Text(
              Texts.symbolsCheckBoxTitle,
            ),
          ),
          CustomWidgets.spacer(),
          CustomWidgets.button(
            Texts.generateRandomPasswordButton,
            () {
              setState(
                () => randomPassword = Utils.generatePassword(
                  length: int.tryParse(
                        passwordLengthController.text.toString(),
                      ) ??
                      10,
                  hasSpanish: hasSpanish,
                  hasNumber: hasNumbers,
                  hasSymbol: hasSymbols,
                ),
              );
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          Visibility(
            visible: randomPassword != '',
            child: GestureDetector(
              onLongPress: () =>
                  Clipboard.setData(ClipboardData(text: randomPassword)).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  Utils.snackbarBuilder(
                    Texts.copiedToClipboard,
                  ),
                ),
              ),
              child: Text(
                Texts.randomPasswordText + randomPassword,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
}

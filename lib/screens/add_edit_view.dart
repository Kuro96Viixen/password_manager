import 'package:flutter/material.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/encrypt.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/widgets/account_text_field.dart';
import 'package:password_manager/widgets/random_password_form.dart';
import 'package:password_manager/widgets/save_password_form.dart';

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

  bool hasSpanishCharacters = true;
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
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
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
                      AccountTextField(
                          label: Texts.nameTextFieldLabel,
                          controller: nameController),
                      AccountTextField(
                          label: Texts.usernameTextFieldLabel,
                          controller: usernameController),
                      const SizedBox(height: 8.0),
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
                        child: AccountTextField(
                          label: Texts.passwordTextFieldLabel,
                          controller: passwordController,
                          isPasswordVisible: viewPassword,
                          onPressed: () => setState(
                            () => viewPassword = !viewPassword,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isRandomPassword,
                        child: RandomPasswordForm(
                          passwordLengthController: passwordLengthController,
                          hasSpanishCharacters: hasSpanishCharacters,
                          onPressedSpanish: (value) => setState(
                            () => hasSpanishCharacters = value!,
                          ),
                          hasNumbers: hasNumbers,
                          onPressedNumbers: (value) => setState(
                            () => hasNumbers = value!,
                          ),
                          hasSymbols: hasSymbols,
                          onPressedSymbols: (value) => setState(
                            () => hasSymbols = value!,
                          ),
                          randomPassword: randomPassword,
                          onPressedButton: () {
                            setState(
                              () => randomPassword = Utils.generatePassword(
                                length: int.tryParse(
                                      passwordLengthController.text.toString(),
                                    ) ??
                                    10,
                                hasSpanish: hasSpanishCharacters,
                                hasNumber: hasNumbers,
                                hasSymbol: hasSymbols,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: viewSave,
              child: SavePasswordForm(
                isPrivate: isPrivate,
                checkBoxAction: (value) => setState(
                  () => isPrivate = value!,
                ),
                onPressedButton: () async => widget.arguments == null
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
            ),
          ],
        ),
      ),
    );
  }
}

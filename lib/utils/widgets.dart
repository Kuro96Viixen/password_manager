import 'package:flutter/material.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/utils.dart';

class CustomWidgets {
  static Widget accountListTile(
          BuildContext context, int index, Account account) =>
      ListTile(
        onTap: () => Utils.navigateToView(
          context,
          index,
          account,
        ),
        leading: Icon(
          CommonIcons.account,
        ),
        title: Text(
          account.name,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
        trailing: Icon(
          CommonIcons.next,
        ),
      );

  static Widget backButton(BuildContext context) => IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          CommonIcons.back,
        ),
      );

  static Widget viewAccountField(String text) => Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 20.0,
        ),
      );

  static Widget viewAccountLabel(String text) => Column(
        children: [
          CustomWidgets.spacer(),
          Text(
            text,
            style: TextStyle(
              color: Colors.purple[100],
              fontSize: 16.0,
            ),
          ),
          CustomWidgets.spacer(),
        ],
      );

  static Widget button(String buttonText, Function() onPressed) =>
      GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.purple[200],
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          padding: const EdgeInsets.all(
            8.0,
          ),
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      );

  static Widget spacer() => const SizedBox(height: 8.0);

  static Widget textField(
    String label,
    TextEditingController controller, {
    bool viewPassword = true,
    void Function()? pressedViewPassword,
  }) =>
      TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: label == Texts.passwordLengthTextFieldLabel
              ? Texts.passwordLengthTextFieldHint
              : null,
          suffixIcon: label == Texts.passwordTextFieldLabel
              ? IconButton(
                  icon: Icon(
                    viewPassword
                        ? CommonIcons.hidePassword
                        : CommonIcons.seePassword,
                  ),
                  onPressed: pressedViewPassword,
                  tooltip: viewPassword
                      ? Texts.hidePasswordTooltip
                      : Texts.seePasswordTooltip,
                )
              : null,
        ),
        autocorrect: false,
        enableSuggestions: false,
        controller: controller,
        maxLines: 1,
        obscureText: label == Texts.passwordTextFieldLabel && !viewPassword,
        keyboardType: label == Texts.passwordLengthTextFieldLabel
            ? TextInputType.number
            : label == Texts.usernameTextFieldLabel
                ? TextInputType.emailAddress
                : TextInputType.name,
      );

  static Widget searchTextField(Function(String) onEditting) => TextField(
        onChanged: onEditting,
        decoration: InputDecoration(
          hintText: Texts.searchHintText,
        ),
      );
}

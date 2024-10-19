import 'package:flutter/material.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/utils.dart';

class CustomWidgets {
  static Widget listTile(
    BuildContext context,
    int index,
    Account account,
  ) =>
      ListTile(
        onTap: () => Utils.navigateToView(context, index, account),
        leading: Icon(CommonIcons.private),
        title: Text(account.name),
        trailing: Icon(CommonIcons.next),
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
          const SizedBox(
            height: 8.0,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.purple[100], fontSize: 16.0),
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      );

  static Widget button(String text, Function() onPressed) => GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.purple[200],
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      );

  static Widget textField(String label, TextEditingController controller) =>
      TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: label == Texts.passwordLengthTextFieldLabel
              ? Texts.passwordLengthTextFieldHint
              : null,
        ),
        autocorrect: false,
        enableSuggestions: false,
        controller: controller,
        maxLines: 1,
        keyboardType: label == Texts.passwordLengthTextFieldLabel
            ? TextInputType.number
            : TextInputType.name,
      );
}

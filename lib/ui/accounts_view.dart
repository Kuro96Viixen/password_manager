import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:password_manager/constants/icons.dart';
import 'package:password_manager/constants/routes.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/widgets/account_list_tile.dart';

class AccountsView extends StatefulWidget {
  const AccountsView({
    super.key,
  });

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
  bool isPrivateView = false;

  List<Account> accounts = Utils.accounts;

  String search = '';

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () => setState(
        () => accounts = Utils.accounts,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: (isPrivateView)
                ? BackButton(
                    onPressed: () => setState(() {
                      isPrivateView = false;
                    }),
                  )
                : null,
            title: Text(
              isPrivateView
                  ? Texts.privateAccountsViewTitle
                  : Texts.accountsViewTitle,
            ),
            actions: (!isPrivateView)
                ? [
                    IconButton(
                      onPressed: () => Utils.authenticate(
                        Texts.fingerprintPrivateAuthTitle,
                      ).then(
                        (authenticated) {
                          setState(() {
                            isPrivateView = true;
                          });
                        },
                      ),
                      icon: Icon(
                        CommonIcons.private,
                      ),
                      tooltip: Texts.showPrivateTooltip,
                    ),
                    IconButton(
                      onPressed: () => showSettings(),
                      icon: Icon(
                        CommonIcons.settings,
                      ),
                    ),
                  ]
                : null,
          ),
          body: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: TextField(
                    onChanged: (searchText) => setState(
                      () => search = searchText,
                    ),
                    decoration: InputDecoration(
                      hintText: Texts.searchHintText,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => (accounts[index]
                                .name
                                .toLowerCase()
                                .startsWith(search) &&
                            ((!accounts[index].private == !isPrivateView) ||
                                (accounts[index].private == isPrivateView)))
                        ? AccountListTile(
                            index: index,
                            account: accounts[index],
                          )
                        : Container(),
                    itemCount: accounts.length,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(
              context,
              Routes.addEdit,
            ),
            tooltip: Texts.addNewAccountTooltip,
            child: Icon(
              CommonIcons.add,
            ),
          ),
        ),
      ),
    );
  }

  void showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Center(
              child: ElevatedButton(
                child: Text(Texts.exportAccounts),
                onPressed: () => Utils.exportAccounts().then(
                  (_) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          Texts.exportedAccounts,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                child: Text(Texts.importAccounts),
                onPressed: () => Utils.importAccounts().then(
                  (_) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          Texts.importedAccounts,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

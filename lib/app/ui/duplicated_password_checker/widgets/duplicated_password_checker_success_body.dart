import 'package:flutter/material.dart';
import 'package:password_manager/app/ui/accounts/widgets/account_list_tile.dart';
import 'package:password_manager/app/ui/duplicated_password_checker/bloc/duplicated_password_checker_state.dart';
import 'package:password_manager/l10n/app_localizations.dart';

class DuplicatedPasswordCheckerSuccessBody extends StatelessWidget {
  final DuplicatedPasswordCheckerState state;

  const DuplicatedPasswordCheckerSuccessBody({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text(
              AppLocalizations.of(
                context,
              )!.duplicatedPasswordCheckerViewSuccess(
                state.differentAccountsPercentage,
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              AppLocalizations.of(
                context,
              )!.duplicatedPasswordCheckerViewSuccessDisclaimer,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 8),
          ...state.accountsList.entries.map(
            (e) => Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ExpansionTile(
                collapsedShape: const RoundedRectangleBorder(),
                shape: const RoundedRectangleBorder(),
                title: Text(
                  AppLocalizations.of(
                    context,
                  )!.duplicatedPasswordCheckerViewSuccessCardTitle(e.key),
                ),
                children: e.value
                    .map(
                      (account) => account.private
                          ? Container()
                          : Column(
                              children: [
                                AccountListTile(account: account),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

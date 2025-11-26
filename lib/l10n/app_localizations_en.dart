// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Password Manager';

  @override
  String get accountsViewTitle => 'Accounts list';

  @override
  String get showPrivateTooltip => 'Show private';

  @override
  String get addNewAccountTooltip => 'Add new password';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get randomPasswordListTile => 'Generate Random password';

  @override
  String get privateAccountsViewTitle => 'Private accounts list';

  @override
  String get addViewTitle => 'Add new account';

  @override
  String get nameTextFieldLabel => 'Name';

  @override
  String get usernameTextFieldLabel => 'Username';

  @override
  String get passwordTextFieldLabel => 'Password';

  @override
  String get useRandomPasswordSwitchTitle => 'Use random password';

  @override
  String get passwordLengthTextFieldLabel => 'Random password length';

  @override
  String get passwordLengthTextFieldHint => 'Default 10';

  @override
  String get spanishCheckBoxTitle => 'Spanish characters (ñ)';

  @override
  String get numbersCheckBoxTitle => 'Numbers';

  @override
  String get symbolsCheckBoxTitle => 'Symbols';

  @override
  String get generateRandomPasswordButton => 'Generate';

  @override
  String randomPasswordText(String password) {
    return 'Your random password is:\n$password';
  }

  @override
  String get isPrivateAccountCheckBoxTitle => 'Is private?';

  @override
  String get saveAccountButton => 'Save account';

  @override
  String get viewAccountViewTitle => 'Account details';

  @override
  String get viewAccountNameLabel => 'Name';

  @override
  String get viewAccountUsernameLabel => 'Username';

  @override
  String get viewAccountPasswordLabel => 'Password';

  @override
  String get hiddenPasswordText => '****';

  @override
  String get viewAccountViewPassword => 'View password';

  @override
  String get viewAccountViewEditTooltip => 'Edit account';

  @override
  String get copiedToClipboard => 'Password copied to clipboard';

  @override
  String get editViewTitle => 'Edit account';

  @override
  String get fingerprintPrivateAuthTitle =>
      'Use device authentication to unlock';

  @override
  String get fingerprintPasswordAuthTitle =>
      'Use device authentication to see the password';

  @override
  String get fingerprintDialogTitle => 'Authentication required';

  @override
  String get fingerprintDialogSubtitle => 'Verify identity';

  @override
  String get importExportDisclaimer =>
      'The following options will allow you to import/export the previously saved accounts.\nBy default this file will be stored in/read from the downloads folder with CSV format, only CSV file format allowed.';

  @override
  String get exportAccounts => 'Export';

  @override
  String get importAccounts => 'Import';

  @override
  String get exportedAccounts => 'Successfully exported';

  @override
  String get importedAccounts => 'Successfully imported';

  @override
  String get searchHintText => 'Search account';

  @override
  String get seePasswordTooltip => 'See password';

  @override
  String get hidePasswordTooltip => 'Hide password';

  @override
  String get dialogTitle => 'Oops, something went wrong';

  @override
  String get dialogPickFileExceptionText =>
      'The app couldn\'t import your previously saved accounts list, either the file is corrupted or you closed the picker.\n\nIf you closed the picker you can close this advice and try again.';

  @override
  String get dialogPickFolderExceptionText =>
      'The app couldn\'t export your accounts list, either you got an exception with the file or you closed the picker.\n\nIf you closed the picker you can close this advice and try again.';

  @override
  String get dialogButtonText => 'Ok, I understand';

  @override
  String get deleteDialogTitle => 'Are you sure?';

  @override
  String deleteDialogBody(String account) {
    return 'You are going to delete the account:\n\n$account\n\nAre you sure do you want to remove it?';
  }

  @override
  String get deleteDialogAdvice => 'This action cannot be undone.';

  @override
  String get deleteDialogCancel => 'No, go back';

  @override
  String get deleteDialogConfirm => 'Yes, I\'m sure';

  @override
  String get randomPasswordViewTitle => 'Random Password Generator';

  @override
  String get randomPasswordDisclaimer =>
      'This random generated password won\'t be stored anywhere and will be discarded once exit, to store it you might use the form to save an account, this password can be copied by long-pressing it.';

  @override
  String get duplicatedPasswordCheckerSettings => 'Duplicated Passwords';

  @override
  String get duplicatedPasswordCheckerSettingsDisclaimer =>
      'This feature is still experimental, sorry if something is wrong, feedback appreciated.';

  @override
  String get duplicatedPasswordCheckerViewTitle => 'Duplication Checker';

  @override
  String get duplicatedPasswordCheckerViewLoading =>
      'Loading stats, this may take a while depending on how many accounts you have stored';

  @override
  String duplicatedPasswordCheckerViewSuccess(num percentage) {
    final intl.NumberFormat percentageNumberFormat =
        intl.NumberFormat.percentPattern(localeName);
    final String percentageString = percentageNumberFormat.format(percentage);

    return 'The passwords of the $percentageString of the accounts are different';
  }

  @override
  String get duplicatedPasswordCheckerViewSuccessDisclaimer =>
      'The following list are only to show the accounts that share the same password, you cannot see the password nor the email/username assigned to that account, only the name that was used to save the account.\n\nNotes:\nPrivate accounts are counted but not shown\nThe name of the card is a placeholder, not the real password';

  @override
  String duplicatedPasswordCheckerViewSuccessCardTitle(num index) {
    final intl.NumberFormat indexNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String indexString = indexNumberFormat.format(index);

    return 'Password #$indexString';
  }

  @override
  String get duplicatedPasswordCheckerViewUniqueCongrats => 'Congratulations!!';

  @override
  String get duplicatedPasswordCheckerViewUniqueBody =>
      'All of your accounts have a different password';

  @override
  String get duplicatedPasswordCheckerViewUniqueGoBack => 'Go back';

  @override
  String get experimentalFeatureInfoTooltip => 'Experimental feature info';

  @override
  String get experimentalFeatureInfoDialogTitle => 'Experimental feature';

  @override
  String get experimentalFeatureInfoDialogBody =>
      'The current functionality is still in experimental phase and may contain bugs, if you are having problems or have any suggestions, feel free to leave a review on the Play Store or open a new ticket on the project github page (if possible)\n\nThank you so much for your support.';

  @override
  String get experimentalFeatureInfoDialogPlayStore => 'Play Store';

  @override
  String get experimentalFeatureInfoDialogGitHub => 'Github';

  @override
  String get experimentalFeatureInfoDialogConfirm => 'Ok';
}

class Texts {
  // App title
  static String title = 'Password manager';

  // Accounts view
  static String accountsViewTitle = 'Accounts list';
  static String showPrivateTooltip = 'Show private';
  static String addNewAccountTooltip = 'Add new password';
  static String settingsTooltip = 'Settings';

  static String randomPasswordListTile = 'Generate Random password';

  // Private accounts view
  static String privateAccountsViewTitle = 'Private accounts list';

  // Add view
  static String addViewTitle = 'Add new account';
  static String nameTextFieldLabel = 'Name';
  static String usernameTextFieldLabel = 'Username';
  static String passwordTextFieldLabel = 'Password';
  static String useRandomPasswordSwitchTitle = 'Use random password';
  static String passwordLengthTextFieldLabel = 'Random password length';
  static String passwordLengthTextFieldHint = 'Default 10';
  static String spanishCheckBoxTitle = 'Spanish characters (ñ)';
  static String numbersCheckBoxTitle = 'Numbers';
  static String symbolsCheckBoxTitle = 'Symbols';
  static String generateRandomPasswordButton = 'Generate';
  static String randomPasswordText = 'Your random password is:\n';
  static String isPrivateAccountCheckBoxTitle = 'Is private?';
  static String saveAccountButton = 'Save account';

  // View account view
  static String viewAccountViewTitle = 'Account details';
  static String viewAccountNameLabel = 'Name';
  static String viewAccountUsernameLabel = 'Username';
  static String viewAccountPasswordLabel = 'Password';
  static String hiddenPasswordText = '****';
  static String viewAccountViewPassword = 'View password';
  static String viewAccountViewEditTooltip = 'Edit account';
  static String copiedToClipboard = 'Password copied to clipboard';

  // Edit view
  static String editViewTitle = 'Edit account';

  // Fingerprint
  // static String fingerprintDialogTitle = 'Authentication required';
  // static String fingerprintDialogSubtitle = 'Verify identity';
  static String fingerprintPrivateAuthTitle =
      'Use device authentication to unlock';
  static String fingerprintPasswordAuthTitle =
      'Use device authentication to see the password';

  // Settings
  static String importExportDisclaimer = 'The following options will allow you '
      'to import/export the previously saved accounts.\n'
      'By default this file will be stored in/read from the downloads folder '
      'with CSV format, only CSV file format allowed.';
  static String exportAccounts = 'Export';
  static String importAccounts = 'Import';

  // Settings success snack bar
  static String exportedAccounts = 'Successfully exported';
  static String importedAccounts = 'Successfully imported';

  // Search
  static String searchHintText = 'Search account';

  // See/Hide password
  static String seePasswordTooltip = 'See password';
  static String hidePasswordTooltip = 'Hide password';

  // Dialog Export/Import exception texts
  static String dialogTitle = 'Oops, something went wrong';
  static String dialogPickFileExceptionText =
      "The app couldn't import your previously saved accounts list, "
      'either the file is corrupted or you closed the picker.\n\n'
      'If you closed the picker you can close this advice and try again.';
  static String dialogPickFolderExceptionText =
      "The app couldn't export your accounts list, "
      'either you got an exception with the file or you closed the picker.\n\n'
      'If you closed the picker you can close this advice and try again.';
  static String dialogButtonText = 'Ok, I understand';

  // Dialog Export/Import exception texts
  static String deleteDialogTitle = 'Are you sure?';
  static String deleteDialogBody = 'You are going to delete the account:\n\n'
      '{account}\n\nAre you sure do you want to remove it?';
  static String deleteDialogAdvice = 'This action cannot be undone.';
  static String deleteDialogCancel = 'No, go back';
  static String deleteDialogConfirm = "Yes, I'm sure";

  // Random Password View
  static String randomPasswordViewTitle = 'Random Password Generator';
  static String randomPasswordDisclaimer = 'This random generated password '
      "won't be stored anywhere and will be discarded once exit, "
      'to store it you might use the form to save an account, '
      'this password can be copied by long-pressing it';

  // Duplicated Password Checker
  static String duplicatedPasswordCheckerSettings = 'Duplicated Passwords';
  static String duplicatedPasswordCheckerSettingsDisclaimer =
      'This feature is still experimental, '
      'sorry if something is wrong, feedback appreciated.';
  static String duplicatedPasswordCheckerViewTitle = 'Duplication Checker';
  static String duplicatedPasswordCheckerViewLoading =
      'Loading stats, this may take a while '
      'depending on how many accounts you have stored';
  static String duplicatedPasswordCheckerViewSuccess =
      'The passwords of the {percentage}% of the accounts are different';
  static String duplicatedPasswordCheckerViewSuccessDisclaimer =
      'The following list are only to show the accounts '
      'that share the same password, you cannot see the password nor '
      'the email/username assigned to that account, '
      'only the name that was used to save the account.\n\n'
      'Notes:\n'
      'Private accounts are counted but not shown\n'
      'The name of the card is a placeholder, not the real password';
  static String duplicatedPasswordCheckerViewSuccessCardTitle =
      'Password #{index}';
  static String duplicatedPasswordCheckerViewUniqueCongrats =
      'Congratulations!!';
  static String duplicatedPasswordCheckerViewUniqueBody =
      'All of your accounts have a different password';
  static String duplicatedPasswordCheckerViewUniqueGoBack = 'Go back';

  // Experimental feature info dialog
  static String experimentalFeatureInfoTooltip = 'Experimental feature info';
  static String experimentalFeatureInfoDialogTitle = 'Experimental feature';
  static String experimentalFeatureInfoDialogBody =
      'The current functionality is still in experimental phase '
      'and may contain bugs, if you are having problems '
      'or have any suggestions, feel free to leave a review on the Play Store '
      'or open a new ticket on the project github page (if possible)\n\n'
      'Thank you so much for your support.';
  static String experimentalFeatureInfoDialogPlayStore = 'Play Store';
  static String experimentalFeatureInfoDialogGitHub = 'Github';
  static String experimentalFeatureInfoDialogConfirm = 'Ok';
}

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
      'The app couldn\'t import your previously saved accounts list, '
      'either you don\'t have permissions or you close the picker.\n\n'
      'If you closed the picker you can close this advice and try again.\n\n'
      'If you denied permissions you should enable them in the App settings.';
  static String dialogPickFolderExceptionText =
      'The app couldn\'t export your accounts list, '
      'either you don\'t have permissions or you close the picker.\n\n'
      'If you closed the picker you can close this advice and try again.\n\n'
      'If you denied permissions you should enable them in the App settings.';
  static String dialogButtonText = 'Ok, I understand';

  // Dialog Export/Import exception texts
  static String deleteDialogTitle = 'Are you sure?';
  static String deleteDialogBody = 'You are going to delete the account:\n\n'
      '{account}\n\nAre you sure do you want to remove it?';
  static String deleteDialogAdvice = 'This action cannot be undone.';
  static String deleteDialogCancel = 'No, go back';
  static String deleteDialogConfirm = 'Yes, I\'m sure';

  // Random Password View
  static String randomPasswordViewTitle = 'Random Password Generator';
  static String randomPasswordDisclaimer = 'This random generated password '
      'won\'t be stored anywhere and will be discarded once exit, '
      'to store it you might use the form to save an account, '
      'this password can be copied by long-pressing it';
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Password Manager'**
  String get title;

  /// No description provided for @accountsViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Accounts list'**
  String get accountsViewTitle;

  /// No description provided for @showPrivateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show private'**
  String get showPrivateTooltip;

  /// No description provided for @addNewAccountTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add new password'**
  String get addNewAccountTooltip;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @randomPasswordListTile.
  ///
  /// In en, this message translates to:
  /// **'Generate Random password'**
  String get randomPasswordListTile;

  /// No description provided for @privateAccountsViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Private accounts list'**
  String get privateAccountsViewTitle;

  /// No description provided for @addViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Add new account'**
  String get addViewTitle;

  /// No description provided for @nameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameTextFieldLabel;

  /// No description provided for @usernameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameTextFieldLabel;

  /// No description provided for @passwordTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTextFieldLabel;

  /// No description provided for @useRandomPasswordSwitchTitle.
  ///
  /// In en, this message translates to:
  /// **'Use random password'**
  String get useRandomPasswordSwitchTitle;

  /// No description provided for @passwordLengthTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Random password length'**
  String get passwordLengthTextFieldLabel;

  /// No description provided for @passwordLengthTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Default 10'**
  String get passwordLengthTextFieldHint;

  /// No description provided for @spanishCheckBoxTitle.
  ///
  /// In en, this message translates to:
  /// **'Spanish characters (ñ)'**
  String get spanishCheckBoxTitle;

  /// No description provided for @numbersCheckBoxTitle.
  ///
  /// In en, this message translates to:
  /// **'Numbers'**
  String get numbersCheckBoxTitle;

  /// No description provided for @symbolsCheckBoxTitle.
  ///
  /// In en, this message translates to:
  /// **'Symbols'**
  String get symbolsCheckBoxTitle;

  /// No description provided for @generateRandomPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generateRandomPasswordButton;

  /// No description provided for @randomPasswordText.
  ///
  /// In en, this message translates to:
  /// **'Your random password is:\n{password}'**
  String randomPasswordText(String password);

  /// No description provided for @isPrivateAccountCheckBoxTitle.
  ///
  /// In en, this message translates to:
  /// **'Is private?'**
  String get isPrivateAccountCheckBoxTitle;

  /// No description provided for @saveAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Save account'**
  String get saveAccountButton;

  /// No description provided for @viewAccountViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Account details'**
  String get viewAccountViewTitle;

  /// No description provided for @viewAccountNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get viewAccountNameLabel;

  /// No description provided for @viewAccountUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get viewAccountUsernameLabel;

  /// No description provided for @viewAccountPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get viewAccountPasswordLabel;

  /// No description provided for @hiddenPasswordText.
  ///
  /// In en, this message translates to:
  /// **'****'**
  String get hiddenPasswordText;

  /// No description provided for @viewAccountViewPassword.
  ///
  /// In en, this message translates to:
  /// **'View password'**
  String get viewAccountViewPassword;

  /// No description provided for @viewAccountViewEditTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get viewAccountViewEditTooltip;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Password copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @editViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get editViewTitle;

  /// No description provided for @fingerprintPrivateAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Use device authentication to unlock'**
  String get fingerprintPrivateAuthTitle;

  /// No description provided for @fingerprintPasswordAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Use device authentication to see the password'**
  String get fingerprintPasswordAuthTitle;

  /// No description provided for @fingerprintDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication required'**
  String get fingerprintDialogTitle;

  /// No description provided for @fingerprintDialogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verify identity'**
  String get fingerprintDialogSubtitle;

  /// No description provided for @importExportDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'The following options will allow you to import/export the previously saved accounts.\nBy default this file will be stored in/read from the downloads folder with CSV format, only CSV file format allowed.'**
  String get importExportDisclaimer;

  /// No description provided for @exportAccounts.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportAccounts;

  /// No description provided for @importAccounts.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importAccounts;

  /// No description provided for @exportedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Successfully exported'**
  String get exportedAccounts;

  /// No description provided for @importedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Successfully imported'**
  String get importedAccounts;

  /// No description provided for @searchHintText.
  ///
  /// In en, this message translates to:
  /// **'Search account'**
  String get searchHintText;

  /// No description provided for @seePasswordTooltip.
  ///
  /// In en, this message translates to:
  /// **'See password'**
  String get seePasswordTooltip;

  /// No description provided for @hidePasswordTooltip.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePasswordTooltip;

  /// No description provided for @dialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Oops, something went wrong'**
  String get dialogTitle;

  /// No description provided for @dialogPickFileExceptionText.
  ///
  /// In en, this message translates to:
  /// **'The app couldn\'t import your previously saved accounts list, either the file is corrupted or you closed the picker.\n\nIf you closed the picker you can close this advice and try again.'**
  String get dialogPickFileExceptionText;

  /// No description provided for @dialogPickFolderExceptionText.
  ///
  /// In en, this message translates to:
  /// **'The app couldn\'t export your accounts list, either you got an exception with the file or you closed the picker.\n\nIf you closed the picker you can close this advice and try again.'**
  String get dialogPickFolderExceptionText;

  /// No description provided for @dialogButtonText.
  ///
  /// In en, this message translates to:
  /// **'Ok, I understand'**
  String get dialogButtonText;

  /// No description provided for @deleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get deleteDialogTitle;

  /// No description provided for @deleteDialogBody.
  ///
  /// In en, this message translates to:
  /// **'You are going to delete the account:\n\n{account}\n\nAre you sure do you want to remove it?'**
  String deleteDialogBody(String account);

  /// No description provided for @deleteDialogAdvice.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteDialogAdvice;

  /// No description provided for @deleteDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'No, go back'**
  String get deleteDialogCancel;

  /// No description provided for @deleteDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, I\'m sure'**
  String get deleteDialogConfirm;

  /// No description provided for @randomPasswordViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Random Password Generator'**
  String get randomPasswordViewTitle;

  /// No description provided for @randomPasswordDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This random generated password won\'t be stored anywhere and will be discarded once exit, to store it you might use the form to save an account, this password can be copied by long-pressing it.'**
  String get randomPasswordDisclaimer;

  /// No description provided for @duplicatedPasswordCheckerSettings.
  ///
  /// In en, this message translates to:
  /// **'Duplicated Passwords'**
  String get duplicatedPasswordCheckerSettings;

  /// No description provided for @duplicatedPasswordCheckerSettingsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This feature is still experimental, sorry if something is wrong, feedback appreciated.'**
  String get duplicatedPasswordCheckerSettingsDisclaimer;

  /// No description provided for @duplicatedPasswordCheckerViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Duplication Checker'**
  String get duplicatedPasswordCheckerViewTitle;

  /// No description provided for @duplicatedPasswordCheckerViewLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading stats, this may take a while depending on how many accounts you have stored'**
  String get duplicatedPasswordCheckerViewLoading;

  /// No description provided for @duplicatedPasswordCheckerViewSuccess.
  ///
  /// In en, this message translates to:
  /// **'The passwords of the {percentage} of the accounts are different'**
  String duplicatedPasswordCheckerViewSuccess(num percentage);

  /// No description provided for @duplicatedPasswordCheckerViewSuccessDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'The following list are only to show the accounts that share the same password, you cannot see the password nor the email/username assigned to that account, only the name that was used to save the account.\n\nNotes:\nPrivate accounts are counted but not shown\nThe name of the card is a placeholder, not the real password'**
  String get duplicatedPasswordCheckerViewSuccessDisclaimer;

  /// No description provided for @duplicatedPasswordCheckerViewSuccessCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Password #{index}'**
  String duplicatedPasswordCheckerViewSuccessCardTitle(num index);

  /// No description provided for @duplicatedPasswordCheckerViewUniqueCongrats.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!!'**
  String get duplicatedPasswordCheckerViewUniqueCongrats;

  /// No description provided for @duplicatedPasswordCheckerViewUniqueBody.
  ///
  /// In en, this message translates to:
  /// **'All of your accounts have a different password'**
  String get duplicatedPasswordCheckerViewUniqueBody;

  /// No description provided for @duplicatedPasswordCheckerViewUniqueGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get duplicatedPasswordCheckerViewUniqueGoBack;

  /// No description provided for @experimentalFeatureInfoTooltip.
  ///
  /// In en, this message translates to:
  /// **'Experimental feature info'**
  String get experimentalFeatureInfoTooltip;

  /// No description provided for @experimentalFeatureInfoDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Experimental feature'**
  String get experimentalFeatureInfoDialogTitle;

  /// No description provided for @experimentalFeatureInfoDialogBody.
  ///
  /// In en, this message translates to:
  /// **'The current functionality is still in experimental phase and may contain bugs, if you are having problems or have any suggestions, feel free to leave a review on the Play Store or open a new ticket on the project github page (if possible)\n\nThank you so much for your support.'**
  String get experimentalFeatureInfoDialogBody;

  /// No description provided for @experimentalFeatureInfoDialogPlayStore.
  ///
  /// In en, this message translates to:
  /// **'Play Store'**
  String get experimentalFeatureInfoDialogPlayStore;

  /// No description provided for @experimentalFeatureInfoDialogGitHub.
  ///
  /// In en, this message translates to:
  /// **'Github'**
  String get experimentalFeatureInfoDialogGitHub;

  /// No description provided for @experimentalFeatureInfoDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get experimentalFeatureInfoDialogConfirm;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

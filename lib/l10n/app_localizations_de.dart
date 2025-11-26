// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get title => 'Password Manager';

  @override
  String get accountsViewTitle => 'Kontenliste';

  @override
  String get showPrivateTooltip => 'Private anzeigen';

  @override
  String get addNewAccountTooltip => 'Neues Passwort hinzufügen';

  @override
  String get settingsTooltip => 'Einstellungen';

  @override
  String get randomPasswordListTile => 'Zufallspasswort generieren';

  @override
  String get privateAccountsViewTitle => 'Liste der privaten Konten';

  @override
  String get addViewTitle => 'Neues Konto hinzufügen';

  @override
  String get nameTextFieldLabel => 'Name';

  @override
  String get usernameTextFieldLabel => 'Benutzername';

  @override
  String get passwordTextFieldLabel => 'Passwort';

  @override
  String get useRandomPasswordSwitchTitle => 'Zufallspasswort verwenden';

  @override
  String get passwordLengthTextFieldLabel => 'Länge des Zufallspassworts';

  @override
  String get passwordLengthTextFieldHint => 'Standard 10';

  @override
  String get spanishCheckBoxTitle => 'Spanische Zeichen (ñ)';

  @override
  String get numbersCheckBoxTitle => 'Zahlen';

  @override
  String get symbolsCheckBoxTitle => 'Symbole';

  @override
  String get generateRandomPasswordButton => 'Generieren';

  @override
  String get randomPasswordText => 'Ihr zufälliges Passwort lautet:\n';

  @override
  String get isPrivateAccountCheckBoxTitle => 'Ist privat?';

  @override
  String get saveAccountButton => 'Konto speichern';

  @override
  String get viewAccountViewTitle => 'Kontodetails';

  @override
  String get viewAccountNameLabel => 'Name';

  @override
  String get viewAccountUsernameLabel => 'Benutzername';

  @override
  String get viewAccountPasswordLabel => 'Passwort';

  @override
  String get hiddenPasswordText => '****';

  @override
  String get viewAccountViewPassword => 'Passwort anzeigen';

  @override
  String get viewAccountViewEditTooltip => 'Konto bearbeiten';

  @override
  String get copiedToClipboard => 'Passwort in die Zwischenablage kopiert';

  @override
  String get editViewTitle => 'Konto bearbeiten';

  @override
  String get fingerprintPrivateAuthTitle =>
      'Geräteauthentifizierung zum Entsperren verwenden';

  @override
  String get fingerprintPasswordAuthTitle =>
      'Geräteauthentifizierung verwenden, um das Passwort anzuzeigen';

  @override
  String get fingerprintDialogTitle => 'Authentifizierung erforderlich';

  @override
  String get fingerprintDialogSubtitle => 'Identität überprüfen';

  @override
  String get importExportDisclaimer =>
      'Die folgenden Optionen ermöglichen es Ihnen, die zuvor gespeicherten Konten zu importieren/exportieren.\nStandardmäßig wird diese Datei im CSV-Format im Download-Ordner gespeichert/gelesen, nur das CSV-Dateiformat ist erlaubt.';

  @override
  String get exportAccounts => 'Exportieren';

  @override
  String get importAccounts => 'Importieren';

  @override
  String get exportedAccounts => 'Erfolgreich exportiert';

  @override
  String get importedAccounts => 'Erfolgreich importiert';

  @override
  String get searchHintText => 'Konto suchen';

  @override
  String get seePasswordTooltip => 'Passwort anzeigen';

  @override
  String get hidePasswordTooltip => 'Passwort ausblenden';

  @override
  String get dialogTitle => 'Hoppla, etwas ist schief gelaufen';

  @override
  String get dialogPickFileExceptionText =>
      'Die App konnte Ihre zuvor gespeicherte Kontenliste nicht importieren, entweder ist die Datei beschädigt oder Sie haben die Auswahl geschlossen.\n\nWenn Sie die Auswahl geschlossen haben, können Sie diesen Hinweis schließen und es erneut versuchen.';

  @override
  String get dialogPickFolderExceptionText =>
      'Die App konnte Ihre Kontenliste nicht exportieren, entweder gab es eine Ausnahme mit der Datei oder Sie haben die Auswahl geschlossen.\n\nWenn Sie die Auswahl geschlossen haben, können Sie diesen Hinweis schließen und es erneut versuchen.';

  @override
  String get dialogButtonText => 'Ok, ich verstehe';

  @override
  String get deleteDialogTitle => 'Sind Sie sicher?';

  @override
  String deleteDialogBody(String account) {
    return 'Sie sind dabei, das Konto zu löschen:\n\n$account\n\nMöchten Sie es wirklich entfernen?';
  }

  @override
  String get deleteDialogAdvice =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deleteDialogCancel => 'Nein, zurück';

  @override
  String get deleteDialogConfirm => 'Ja, ich bin sicher';

  @override
  String get randomPasswordViewTitle => 'Zufallspasswortgenerator';

  @override
  String get randomPasswordDisclaimer =>
      'Dieses zufällig generierte Passwort wird nirgendwo gespeichert und nach dem Beenden verworfen. Um es zu speichern, können Sie das Formular zum Speichern eines Kontos verwenden. Dieses Passwort kann durch langes Drücken kopiert werden.';

  @override
  String get duplicatePasswordCheckerSettings => 'Doppelte Passwörter';

  @override
  String get duplicatePasswordCheckerSettingsDisclaimer =>
      'Diese Funktion ist noch experimentell, entschuldigen Sie, wenn etwas nicht stimmt, Feedback wird geschätzt.';

  @override
  String get duplicatedPasswordCheckerViewTitle => 'Duplikatprüfer';

  @override
  String get duplicatedPasswordCheckerViewLoading =>
      'Lade Statistiken, dies kann eine Weile dauern, je nachdem, wie viele Konten Sie gespeichert haben';

  @override
  String duplicatedPasswordCheckerViewSuccess(num percentage) {
    final intl.NumberFormat percentageNumberFormat =
        intl.NumberFormat.percentPattern(localeName);
    final String percentageString = percentageNumberFormat.format(percentage);

    return 'Die Passwörter von $percentageString der Konten sind unterschiedlich';
  }

  @override
  String get duplicatedPasswordCheckerViewSuccessDisclaimer =>
      'Die folgende Liste dient nur dazu, die Konten anzuzeigen, die dasselbe Passwort verwenden. Sie können weder das Passwort noch die E-Mail/den Benutzernamen sehen, der diesem Konto zugewiesen ist, sondern nur den Namen, der zum Speichern des Kontos verwendet wurde.\n\nAnmerkungen:\nPrivate Konten werden gezählt, aber nicht angezeigt\nDer Name der Karte ist ein Platzhalter, nicht das eigentliche Passwort';

  @override
  String duplicatedPasswordCheckerViewSuccessCardTitle(num index) {
    final intl.NumberFormat indexNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String indexString = indexNumberFormat.format(index);

    return 'Passwort #$indexString';
  }

  @override
  String get duplicatedPasswordCheckerViewUniqueCongrats =>
      'Herzlichen Glückwunsch!!';

  @override
  String get duplicatedPasswordCheckerViewUniqueBody =>
      'Alle Ihre Konten haben ein anderes Passwort';

  @override
  String get duplicatedPasswordCheckerViewUniqueGoBack => 'Zurück';

  @override
  String get experimentalFeatureInfoTooltip =>
      'Info zur experimentellen Funktion';

  @override
  String get experimentalFeatureInfoDialogTitle => 'Experimentelle Funktion';

  @override
  String get experimentalFeatureInfoDialogBody =>
      'Die aktuelle Funktionalität befindet sich noch in der experimentellen Phase und kann Fehler enthalten. Wenn Sie Probleme haben oder Vorschläge haben, können Sie gerne eine Bewertung im Play Store hinterlassen oder ein neues Ticket auf der Github-Seite des Projekts öffnen (wenn möglich)\n\nVielen Dank für Ihre Unterstützung.';

  @override
  String get experimentalFeatureInfoDialogPlayStore => 'Play Store';

  @override
  String get experimentalFeatureInfoDialogGitHub => 'Github';

  @override
  String get experimentalFeatureInfoDialogConfirm => 'Ok';
}

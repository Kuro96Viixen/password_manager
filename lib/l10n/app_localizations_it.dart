// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get title => 'Password Manager';

  @override
  String get accountsViewTitle => 'Elenco degli account';

  @override
  String get showPrivateTooltip => 'Mostra privati';

  @override
  String get addNewAccountTooltip => 'Aggiungi nuova password';

  @override
  String get settingsTooltip => 'Impostazioni';

  @override
  String get randomPasswordListTile => 'Genera password casuale';

  @override
  String get privateAccountsViewTitle => 'Elenco degli account privati';

  @override
  String get addViewTitle => 'Aggiungi nuovo account';

  @override
  String get nameTextFieldLabel => 'Nome';

  @override
  String get usernameTextFieldLabel => 'Nome utente';

  @override
  String get passwordTextFieldLabel => 'Password';

  @override
  String get useRandomPasswordSwitchTitle => 'Usa password casuale';

  @override
  String get passwordLengthTextFieldLabel => 'Lunghezza password casuale';

  @override
  String get passwordLengthTextFieldHint => 'Predefinito 10';

  @override
  String get spanishCheckBoxTitle => 'Caratteri spagnoli (ñ)';

  @override
  String get numbersCheckBoxTitle => 'Numeri';

  @override
  String get symbolsCheckBoxTitle => 'Simboli';

  @override
  String get generateRandomPasswordButton => 'Genera';

  @override
  String randomPasswordText(String password) {
    return 'La tua password casuale è:\n$password';
  }

  @override
  String get isPrivateAccountCheckBoxTitle => 'È privato?';

  @override
  String get saveAccountButton => 'Salva account';

  @override
  String get viewAccountViewTitle => 'Dettagli dell\'account';

  @override
  String get viewAccountNameLabel => 'Nome';

  @override
  String get viewAccountUsernameLabel => 'Nome utente';

  @override
  String get viewAccountPasswordLabel => 'Password';

  @override
  String get hiddenPasswordText => '****';

  @override
  String get viewAccountViewPassword => 'Visualizza password';

  @override
  String get viewAccountViewEditTooltip => 'Modifica account';

  @override
  String get copiedToClipboard => 'Password copiata negli appunti';

  @override
  String get editViewTitle => 'Modifica account';

  @override
  String get fingerprintPrivateAuthTitle =>
      'Usa l\'autenticazione del dispositivo per sbloccare';

  @override
  String get fingerprintPasswordAuthTitle =>
      'Usa l\'autenticazione del dispositivo per vedere la password';

  @override
  String get fingerprintDialogTitle => 'Autenticazione richiesta';

  @override
  String get fingerprintDialogSubtitle => 'Verifica identità';

  @override
  String get importExportDisclaimer =>
      'Le seguenti opzioni ti consentiranno di esportare/importare gli account salvati in precedenza.\nPer impostazione predefinita questo file verrà archiviato/letto dalla cartella download o documenti in formato CSV, è consentito solo il formato file CSV.';

  @override
  String get exportAccounts => 'Esporta';

  @override
  String get importAccounts => 'Importa';

  @override
  String get exportedAccounts => 'Esportato con successo';

  @override
  String get importedAccounts => 'Importato con successo';

  @override
  String get searchHintText => 'Cerca account';

  @override
  String get seePasswordTooltip => 'Vedi password';

  @override
  String get hidePasswordTooltip => 'Nascondi password';

  @override
  String get dialogTitle => 'Ops, qualcosa è andato storto';

  @override
  String get dialogPickFolderExceptionText =>
      'L\'app non è riuscita a esportare il tuo elenco di account, o hai avuto un\'eccezione con il file o hai chiuso il selettore.\n\nSe hai chiuso il selettore puoi chiudere questo avviso e riprovare.';

  @override
  String get dialogPickFileExceptionText =>
      'L\'app non è riuscita a importare il tuo elenco di account salvato in precedenza, o il file è corrotto o hai chiuso il selettore.\n\nSe hai chiuso il selettore puoi chiudere questo avviso e riprovare.';

  @override
  String get dialogButtonText => 'Ok, ho capito';

  @override
  String get deleteDialogTitle => 'Sei sicuro?';

  @override
  String deleteDialogBody(String account) {
    return 'Stai per eliminare l\'account:\n\n$account\n\nSei sicuro di volerlo rimuovere?';
  }

  @override
  String get deleteDialogAdvice => 'Questa azione non può essere annullata.';

  @override
  String get deleteDialogCancel => 'No, torna indietro';

  @override
  String get deleteDialogConfirm => 'Sì, sono sicuro';

  @override
  String get randomPasswordViewTitle => 'Generatore di Password Casuali';

  @override
  String get randomPasswordDisclaimer =>
      'Questa password casuale generata non verrà memorizzata da nessuna parte e verrà scartata all\'uscita, per memorizzarla potresti utilizzare il modulo per salvare un account, questa password può essere copiata premendola a lungo.';

  @override
  String get duplicatedPasswordCheckerSettings => 'Password Duplicate';

  @override
  String get duplicatedPasswordCheckerSettingsDisclaimer =>
      'Questa funzionalità è ancora sperimentale, scusa se qualcosa non va, i feedback sono apprezzati.';

  @override
  String get duplicatedPasswordCheckerViewTitle => 'Controllo Duplicati';

  @override
  String get duplicatedPasswordCheckerViewLoading =>
      'Caricamento delle statistiche, questo potrebbe richiedere del tempo a seconda di quanti account hai memorizzato';

  @override
  String duplicatedPasswordCheckerViewSuccess(num percentage) {
    final intl.NumberFormat percentageNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String percentageString = percentageNumberFormat.format(percentage);

    return 'Le password del $percentageString% degli account sono diverse';
  }

  @override
  String get duplicatedPasswordCheckerViewSuccessDisclaimer =>
      'Il seguente elenco serve solo a mostrare gli account che condividono la stessa password, non puoi vedere la password né l\'email/nome utente assegnato a quell\'account, solo il nome utilizzato per salvare l\'account.\n\nNote:\nGli account privati sono conteggiati ma non mostrati\nIl nome della scheda è un segnaposto, non la password reale';

  @override
  String duplicatedPasswordCheckerViewSuccessCardTitle(num index) {
    final intl.NumberFormat indexNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String indexString = indexNumberFormat.format(index);

    return 'Password #$indexString';
  }

  @override
  String get duplicatedPasswordCheckerViewUniqueCongrats => 'Congratulazioni!!';

  @override
  String get duplicatedPasswordCheckerViewUniqueBody =>
      'Tutti i tuoi account hanno una password diversa';

  @override
  String get duplicatedPasswordCheckerViewUniqueGoBack => 'Torna indietro';

  @override
  String get experimentalFeatureInfoTooltip =>
      'Informazioni sulla funzionalità sperimentale';

  @override
  String get experimentalFeatureInfoDialogTitle => 'Funzionalità sperimentale';

  @override
  String get experimentalFeatureInfoDialogBody =>
      'La funzionalità attuale è ancora in fase sperimentale e potrebbe contenere bug, se hai problemi o hai suggerimenti, sentiti libero di lasciare una recensione sul Play Store o aprire un nuovo ticket sulla pagina github del progetto (se possibile)\n\nGrazie mille per il tuo supporto.';

  @override
  String get experimentalFeatureInfoDialogPlayStore => 'Play Store';

  @override
  String get experimentalFeatureInfoDialogGitHub => 'Github';

  @override
  String get experimentalFeatureInfoDialogConfirm => 'Ok';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get title => 'Password Manager';

  @override
  String get accountsViewTitle => 'Liste des comptes';

  @override
  String get showPrivateTooltip => 'Afficher les privés';

  @override
  String get addNewAccountTooltip => 'Ajouter un nouveau mot de passe';

  @override
  String get settingsTooltip => 'Paramètres';

  @override
  String get randomPasswordListTile => 'Générer un mot de passe aléatoire';

  @override
  String get privateAccountsViewTitle => 'Liste des comptes privés';

  @override
  String get addViewTitle => 'Ajouter un nouveau compte';

  @override
  String get nameTextFieldLabel => 'Nom';

  @override
  String get usernameTextFieldLabel => 'Nom d\'utilisateur';

  @override
  String get passwordTextFieldLabel => 'Mot de passe';

  @override
  String get useRandomPasswordSwitchTitle =>
      'Utiliser un mot de passe aléatoire';

  @override
  String get passwordLengthTextFieldLabel =>
      'Longueur du mot de passe aléatoire';

  @override
  String get passwordLengthTextFieldHint => 'Défaut 10';

  @override
  String get spanishCheckBoxTitle => 'Caractères espagnols (ñ)';

  @override
  String get numbersCheckBoxTitle => 'Nombres';

  @override
  String get symbolsCheckBoxTitle => 'Symboles';

  @override
  String get generateRandomPasswordButton => 'Générer';

  @override
  String randomPasswordText(String password) {
    return 'Votre mot de passe aléatoire est :\n$password';
  }

  @override
  String get isPrivateAccountCheckBoxTitle => 'Est privé ?';

  @override
  String get saveAccountButton => 'Enregistrer le compte';

  @override
  String get viewAccountViewTitle => 'Détails du compte';

  @override
  String get viewAccountNameLabel => 'Nom';

  @override
  String get viewAccountUsernameLabel => 'Nom d\'utilisateur';

  @override
  String get viewAccountPasswordLabel => 'Mot de passe';

  @override
  String get hiddenPasswordText => '****';

  @override
  String get viewAccountViewPassword => 'Voir le mot de passe';

  @override
  String get viewAccountViewEditTooltip => 'Modifier le compte';

  @override
  String get copiedToClipboard => 'Mot de passe copié dans le presse-papiers';

  @override
  String get editViewTitle => 'Modifier le compte';

  @override
  String get fingerprintPrivateAuthTitle =>
      'Utiliser l\'authentification de l\'appareil pour déverrouiller';

  @override
  String get fingerprintPasswordAuthTitle =>
      'Utiliser l\'authentification de l\'appareil pour voir le mot de passe';

  @override
  String get fingerprintDialogTitle => 'Authentification requise';

  @override
  String get fingerprintDialogSubtitle => 'Vérifier l\'identité';

  @override
  String get importExportDisclaimer =>
      'Les options suivantes vous permettront d\'importer/exporter les comptes précédemment enregistrés.\nPar défaut, ce fichier sera stocké/lu depuis le dossier des téléchargements au format CSV, seul le format de fichier CSV est autorisé.';

  @override
  String get exportAccounts => 'Exporter';

  @override
  String get importAccounts => 'Importer';

  @override
  String get exportedAccounts => 'Exporté avec succès';

  @override
  String get importedAccounts => 'Importé avec succès';

  @override
  String get searchHintText => 'Rechercher un compte';

  @override
  String get seePasswordTooltip => 'Voir le mot de passe';

  @override
  String get hidePasswordTooltip => 'Cacher le mot de passe';

  @override
  String get dialogTitle => 'Oups, quelque chose s\'est mal passé';

  @override
  String get dialogPickFileExceptionText =>
      'L\'application n\'a pas pu importer votre liste de comptes précédemment enregistrée, soit le fichier est corrompu, soit vous avez fermé le sélecteur.\n\nSi vous avez fermé le sélecteur, vous pouvez fermer cet avis et réessayer.';

  @override
  String get dialogPickFolderExceptionText =>
      'L\'application n\'a pas pu exporter votre liste de comptes, soit vous avez eu une exception avec le fichier, soit vous avez fermé le sélecteur.\n\nSi vous avez fermé le sélecteur, vous pouvez fermer cet avis et réessayer.';

  @override
  String get dialogButtonText => 'Ok, je comprends';

  @override
  String get deleteDialogTitle => 'Êtes-vous sûr ?';

  @override
  String deleteDialogBody(String account) {
    return 'Vous allez supprimer le compte :\n\n$account\n\nÊtes-vous sûr de vouloir le supprimer ?';
  }

  @override
  String get deleteDialogAdvice => 'Cette action ne peut pas être annulée.';

  @override
  String get deleteDialogCancel => 'Non, retour';

  @override
  String get deleteDialogConfirm => 'Oui, je suis sûr';

  @override
  String get randomPasswordViewTitle => 'Générateur de mot de passe aléatoire';

  @override
  String get randomPasswordDisclaimer =>
      'Ce mot de passe généré aléatoirement ne sera stocké nulle part et sera supprimé une fois que vous quitterez. Pour le stocker, vous pouvez utiliser le formulaire pour enregistrer un compte. Ce mot de passe peut être copié en appuyant longuement dessus.';

  @override
  String get duplicatedPasswordCheckerSettings => 'Mots de passe dupliqués';

  @override
  String get duplicatedPasswordCheckerSettingsDisclaimer =>
      'Cette fonctionnalité est encore expérimentale, désolé si quelque chose ne va pas, les commentaires sont appréciés.';

  @override
  String get duplicatedPasswordCheckerViewTitle =>
      'Vérificateur de duplication';

  @override
  String get duplicatedPasswordCheckerViewLoading =>
      'Chargement des statistiques, cela может prendre un certain temps en fonction du nombre de comptes que vous avez stockés';

  @override
  String duplicatedPasswordCheckerViewSuccess(num percentage) {
    final intl.NumberFormat percentageNumberFormat =
        intl.NumberFormat.percentPattern(localeName);
    final String percentageString = percentageNumberFormat.format(percentage);

    return 'Les mots de passe de $percentageString des comptes sont différents';
  }

  @override
  String get duplicatedPasswordCheckerViewSuccessDisclaimer =>
      'La liste suivante sert uniquement à afficher les comptes qui partagent le même mot de passe, vous не pouvez pas voir le mot de passe ni l\'e-mail/nom d\'utilisateur attribué à ce compte, uniquement le nom qui a été utilisé pour enregistrer le compte.\n\nRemarques :\nLes comptes privés sont comptés mais non affichés\nLe nom de la carte est un espace réservé, pas le vrai mot de passe';

  @override
  String duplicatedPasswordCheckerViewSuccessCardTitle(num index) {
    final intl.NumberFormat indexNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String indexString = indexNumberFormat.format(index);

    return 'Mot de passe #$indexString';
  }

  @override
  String get duplicatedPasswordCheckerViewUniqueCongrats => 'Félicitations !!';

  @override
  String get duplicatedPasswordCheckerViewUniqueBody =>
      'Tous vos comptes ont un mot de passe différent';

  @override
  String get duplicatedPasswordCheckerViewUniqueGoBack => 'Retour';

  @override
  String get experimentalFeatureInfoTooltip =>
      'Informations sur la fonctionnalité expérimentale';

  @override
  String get experimentalFeatureInfoDialogTitle =>
      'Fonctionnalité expérimentale';

  @override
  String get experimentalFeatureInfoDialogBody =>
      'La fonctionnalité actuelle est encore en phase expérimentale et peut contenir des bogues. Si vous rencontrez des problèmes ou avez des suggestions, n\'hésitez pas à laisser un commentaire sur le Play Store ou à ouvrir un nouveau ticket sur la page github du projet (si possible)\n\nMerci beaucoup pour votre soutien.';

  @override
  String get experimentalFeatureInfoDialogPlayStore => 'Play Store';

  @override
  String get experimentalFeatureInfoDialogGitHub => 'Github';

  @override
  String get experimentalFeatureInfoDialogConfirm => 'D\'accord';
}

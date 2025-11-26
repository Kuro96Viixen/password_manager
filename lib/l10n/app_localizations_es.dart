// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Password Manager';

  @override
  String get accountsViewTitle => 'Lista de cuentas';

  @override
  String get showPrivateTooltip => 'Mostrar privadas';

  @override
  String get addNewAccountTooltip => 'Añadir nueva contraseña';

  @override
  String get settingsTooltip => 'Ajustes';

  @override
  String get randomPasswordListTile => 'Generar contraseña aleatoria';

  @override
  String get privateAccountsViewTitle => 'Lista de cuentas privadas';

  @override
  String get addViewTitle => 'Añadir nueva cuenta';

  @override
  String get nameTextFieldLabel => 'Nombre';

  @override
  String get usernameTextFieldLabel => 'Usuario';

  @override
  String get passwordTextFieldLabel => 'Contraseña';

  @override
  String get useRandomPasswordSwitchTitle => 'Usar contraseña aleatoria';

  @override
  String get passwordLengthTextFieldLabel =>
      'Longitud de la contraseña aleatoria';

  @override
  String get passwordLengthTextFieldHint => 'Por defecto 10';

  @override
  String get spanishCheckBoxTitle => 'Caracteres españoles (ñ)';

  @override
  String get numbersCheckBoxTitle => 'Números';

  @override
  String get symbolsCheckBoxTitle => 'Símbolos';

  @override
  String get generateRandomPasswordButton => 'Generar';

  @override
  String get randomPasswordText => 'Tu contraseña aleatoria es:\n';

  @override
  String get isPrivateAccountCheckBoxTitle => '¿Es privada?';

  @override
  String get saveAccountButton => 'Guardar cuenta';

  @override
  String get viewAccountViewTitle => 'Detalles de la cuenta';

  @override
  String get viewAccountNameLabel => 'Nombre';

  @override
  String get viewAccountUsernameLabel => 'Usuario';

  @override
  String get viewAccountPasswordLabel => 'Contraseña';

  @override
  String get hiddenPasswordText => '****';

  @override
  String get viewAccountViewPassword => 'Ver contraseña';

  @override
  String get viewAccountViewEditTooltip => 'Editar cuenta';

  @override
  String get copiedToClipboard => 'Contraseña copiada al portapapeles';

  @override
  String get editViewTitle => 'Editar cuenta';

  @override
  String get fingerprintPrivateAuthTitle =>
      'Usa la autenticación del dispositivo para desbloquear';

  @override
  String get fingerprintPasswordAuthTitle =>
      'Usa la autenticación del dispositivo para ver la contraseña';

  @override
  String get fingerprintDialogTitle => 'Autenticación requerida';

  @override
  String get fingerprintDialogSubtitle => 'Verificar identidad';

  @override
  String get importExportDisclaimer =>
      'Las siguientes opciones te permitirán importar/exportar las cuentas guardadas previamente.\nPor defecto, este archivo se guardará/leerá desde la carpeta de descargas con formato CSV, solo se permite el formato de archivo CSV.';

  @override
  String get exportAccounts => 'Exportar';

  @override
  String get importAccounts => 'Importar';

  @override
  String get exportedAccounts => 'Exportado con éxito';

  @override
  String get importedAccounts => 'Importado con éxito';

  @override
  String get searchHintText => 'Buscar cuenta';

  @override
  String get seePasswordTooltip => 'Ver contraseña';

  @override
  String get hidePasswordTooltip => 'Ocultar contraseña';

  @override
  String get dialogTitle => 'Vaya, algo salió mal';

  @override
  String get dialogPickFileExceptionText =>
      'La aplicación no pudo importar la lista de cuentas guardadas anteriormente, el archivo está dañado o cerraste el selector.\n\nSi cerraste el selector, puedes cerrar este aviso e intentarlo de nuevo.';

  @override
  String get dialogPickFolderExceptionText =>
      'La aplicación no pudo exportar tu lista de cuentas, o bien tuviste una excepción con el archivo o cerraste el selector.\n\nSi cerraste el selector, puedes cerrar este aviso e intentarlo de nuevo.';

  @override
  String get dialogButtonText => 'Ok, lo entiendo';

  @override
  String get deleteDialogTitle => '¿Estás seguro?';

  @override
  String deleteDialogBody(String account) {
    return 'Vas a eliminar la cuenta:\n\n$account\n\n¿Estás seguro de que quieres eliminarla?';
  }

  @override
  String get deleteDialogAdvice => 'Esta acción no se puede deshacer.';

  @override
  String get deleteDialogCancel => 'No, volver';

  @override
  String get deleteDialogConfirm => 'Sí, estoy seguro';

  @override
  String get randomPasswordViewTitle => 'Generador de contraseñas aleatorias';

  @override
  String get randomPasswordDisclaimer =>
      'Esta contraseña generada aleatoriamente no se guardará en ningún sitio y se descartará una vez que salgas. Para guardarla, puedes usar el formulario para guardar una cuenta. Esta contraseña se puede copiar manteniéndola pulsada.';

  @override
  String get duplicatePasswordCheckerSettings => 'Contraseñas duplicadas';

  @override
  String get duplicatePasswordCheckerSettingsDisclaimer =>
      'Esta función aún es experimental, disculpa si algo va mal, se agradecen los comentarios.';

  @override
  String get duplicatedPasswordCheckerViewTitle => 'Contraseñas duplicadas';

  @override
  String get duplicatedPasswordCheckerViewLoading =>
      'Cargando estadísticas, esto puede tardar un poco dependiendo de cuántas cuentas tengas almacenadas';

  @override
  String duplicatedPasswordCheckerViewSuccess(num percentage) {
    final intl.NumberFormat percentageNumberFormat =
        intl.NumberFormat.percentPattern(localeName);
    final String percentageString = percentageNumberFormat.format(percentage);

    return 'Las contraseñas del $percentageString de las cuentas son diferentes';
  }

  @override
  String get duplicatedPasswordCheckerViewSuccessDisclaimer =>
      'La siguiente lista es solo para mostrar las cuentas que comparten la misma contraseña, no puedes ver la contraseña ni el correo electrónico/nombre de usuario asignado a esa cuenta, solo el nombre que se usó para guardar la cuenta.\n\nNotas:\nLas cuentas privadas se cuentan pero no se muestran\nEl nombre de la tarjeta es un marcador de posición, no la contraseña real';

  @override
  String duplicatedPasswordCheckerViewSuccessCardTitle(num index) {
    final intl.NumberFormat indexNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String indexString = indexNumberFormat.format(index);

    return 'Contraseña #$indexString';
  }

  @override
  String get duplicatedPasswordCheckerViewUniqueCongrats => '¡Felicidades!';

  @override
  String get duplicatedPasswordCheckerViewUniqueBody =>
      'Todas tus cuentas tienen una contraseña diferente';

  @override
  String get duplicatedPasswordCheckerViewUniqueGoBack => 'Volver';

  @override
  String get experimentalFeatureInfoTooltip =>
      'Información de la función experimental';

  @override
  String get experimentalFeatureInfoDialogTitle => 'Función experimental';

  @override
  String get experimentalFeatureInfoDialogBody =>
      'La funcionalidad actual todavía está en fase experimental y puede contener errores. Si tienes problemas o alguna sugerencia, no dudes en dejar una reseña en la Play Store o abrir un nuevo ticket en la página de github del proyecto (si es posible)\n\nMuchas gracias por tu apoyo.';

  @override
  String get experimentalFeatureInfoDialogPlayStore => 'Play Store';

  @override
  String get experimentalFeatureInfoDialogGitHub => 'Github';

  @override
  String get experimentalFeatureInfoDialogConfirm => 'Ok';
}

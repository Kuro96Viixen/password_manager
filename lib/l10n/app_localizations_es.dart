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
  String get settingsTooltip => 'Configuración';

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
  String get passwordLengthTextFieldLabel => 'Longitud de contraseña aleatoria';

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
  String randomPasswordText(String password) {
    return 'Tu contraseña aleatoria es:\n$password';
  }

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
      'Usar la autenticación del dispositivo para desbloquear';

  @override
  String get fingerprintPasswordAuthTitle =>
      'Usar la autenticación del dispositivo para ver la contraseña';

  @override
  String get fingerprintDialogTitle => 'Autenticación requerida';

  @override
  String get fingerprintDialogSubtitle => 'Verificar identidad';

  @override
  String get importExportDisclaimer =>
      'Las siguientes opciones te permitirán exportar/importar las cuentas guardadas previamente.\nPor defecto este archivo se almacenará/leerá desde la carpeta de descargas o documentos con formato CSV, solo se permite formato de archivo CSV.';

  @override
  String get exportAccounts => 'Exportar';

  @override
  String get importAccounts => 'Importar';

  @override
  String get exportedAccounts => 'Exportado exitosamente';

  @override
  String get importedAccounts => 'Importado exitosamente';

  @override
  String get searchHintText => 'Buscar cuenta';

  @override
  String get seePasswordTooltip => 'Ver contraseña';

  @override
  String get hidePasswordTooltip => 'Ocultar contraseña';

  @override
  String get dialogTitle => 'Ups, algo salió mal';

  @override
  String get dialogPickFolderExceptionText =>
      'La aplicación no pudo exportar tu lista de cuentas, o hubo una excepción con el archivo o cerraste el selector.\n\nSi cerraste el selector puedes cerrar este aviso e intentarlo de nuevo.';

  @override
  String get dialogPickFileExceptionText =>
      'La aplicación no pudo importar tu lista de cuentas guardadas previamente, o el archivo está corrupto o cerraste el selector.\n\nSi cerraste el selector puedes cerrar este aviso e intentarlo de nuevo.';

  @override
  String get dialogButtonText => 'Ok, entiendo';

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
  String get randomPasswordViewTitle => 'Generador de Contraseñas Aleatorias';

  @override
  String get randomPasswordDisclaimer =>
      'Esta contraseña aleatoria generada no se almacenará en ningún lugar y se descartará una vez salgas, para almacenarla puedes usar el formulario para guardar una cuenta, esta contraseña se puede copiar manteniéndola presionada.';

  @override
  String get duplicatedPasswordCheckerSettings => 'Contraseñas Duplicadas';

  @override
  String get duplicatedPasswordCheckerSettingsDisclaimer =>
      'Esta característica aún es experimental, disculpa si algo está mal, se agradecen comentarios.';

  @override
  String get duplicatedPasswordCheckerViewTitle => 'Verificador de Duplicación';

  @override
  String get duplicatedPasswordCheckerViewLoading =>
      'Cargando estadísticas, esto puede tardar un poco dependiendo de cuántas cuentas tengas guardadas';

  @override
  String duplicatedPasswordCheckerViewSuccess(num percentage) {
    final intl.NumberFormat percentageNumberFormat =
        intl.NumberFormat.percentPattern(localeName);
    final String percentageString = percentageNumberFormat.format(percentage);

    return 'Las contraseñas del $percentageString de las cuentas son diferentes';
  }

  @override
  String get duplicatedPasswordCheckerViewSuccessDisclaimer =>
      'La siguiente lista es solo para mostrar las cuentas que comparten la misma contraseña, no puedes ver la contraseña ni el correo/usuario asignado a esa cuenta, solo el nombre que se usó para guardar la cuenta.\n\nNotas:\nLas cuentas privadas se cuentan pero no se muestran\nEl nombre de la tarjeta es un marcador de posición, no la contraseña real';

  @override
  String duplicatedPasswordCheckerViewSuccessCardTitle(num index) {
    final intl.NumberFormat indexNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String indexString = indexNumberFormat.format(index);

    return 'Contraseña #$indexString';
  }

  @override
  String get duplicatedPasswordCheckerViewUniqueCongrats => '¡¡Felicidades!!';

  @override
  String get duplicatedPasswordCheckerViewUniqueBody =>
      'Todas tus cuentas tienen una contraseña diferente';

  @override
  String get duplicatedPasswordCheckerViewUniqueGoBack => 'Volver';

  @override
  String get experimentalFeatureInfoTooltip =>
      'Información sobre característica experimental';

  @override
  String get experimentalFeatureInfoDialogTitle =>
      'Característica experimental';

  @override
  String get experimentalFeatureInfoDialogBody =>
      'La funcionalidad actual todavía está en fase experimental y puede contener errores, si tienes problemas o tienes alguna sugerencia, no dudes en dejar una reseña en Play Store o abrir un nuevo ticket en la página de github del proyecto (si es posible)\n\nMuchas gracias por tu apoyo.';

  @override
  String get experimentalFeatureInfoDialogPlayStore => 'Play Store';

  @override
  String get experimentalFeatureInfoDialogGitHub => 'Github';

  @override
  String get experimentalFeatureInfoDialogConfirm => 'Ok';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get title => 'Password Manager';

  @override
  String get accountsViewTitle => 'Lista de contas';

  @override
  String get showPrivateTooltip => 'Mostrar privadas';

  @override
  String get addNewAccountTooltip => 'Adicionar nova senha';

  @override
  String get settingsTooltip => 'Configurações';

  @override
  String get randomPasswordListTile => 'Gerar senha aleatória';

  @override
  String get privateAccountsViewTitle => 'Lista de contas privadas';

  @override
  String get addViewTitle => 'Adicionar nova conta';

  @override
  String get nameTextFieldLabel => 'Nome';

  @override
  String get usernameTextFieldLabel => 'Nome de usuário';

  @override
  String get passwordTextFieldLabel => 'Senha';

  @override
  String get useRandomPasswordSwitchTitle => 'Usar senha aleatória';

  @override
  String get passwordLengthTextFieldLabel => 'Comprimento da senha aleatória';

  @override
  String get passwordLengthTextFieldHint => 'Padrão 10';

  @override
  String get spanishCheckBoxTitle => 'Caracteres espanhóis (ñ)';

  @override
  String get numbersCheckBoxTitle => 'Números';

  @override
  String get symbolsCheckBoxTitle => 'Símbolos';

  @override
  String get generateRandomPasswordButton => 'Gerar';

  @override
  String randomPasswordText(String password) {
    return 'Sua senha aleatória é:\n$password';
  }

  @override
  String get isPrivateAccountCheckBoxTitle => 'É privada?';

  @override
  String get saveAccountButton => 'Salvar conta';

  @override
  String get viewAccountViewTitle => 'Detalhes da conta';

  @override
  String get viewAccountNameLabel => 'Nome';

  @override
  String get viewAccountUsernameLabel => 'Nome de usuário';

  @override
  String get viewAccountPasswordLabel => 'Senha';

  @override
  String get hiddenPasswordText => '****';

  @override
  String get viewAccountViewPassword => 'Ver senha';

  @override
  String get viewAccountViewEditTooltip => 'Editar conta';

  @override
  String get copiedToClipboard => 'Senha copiada para a área de transferência';

  @override
  String get editViewTitle => 'Editar conta';

  @override
  String get fingerprintPrivateAuthTitle =>
      'Use a autenticação do dispositivo para desbloquear';

  @override
  String get fingerprintPasswordAuthTitle =>
      'Use a autenticação do dispositivo para ver a senha';

  @override
  String get fingerprintDialogTitle => 'Autenticação necessária';

  @override
  String get fingerprintDialogSubtitle => 'Verificar identidade';

  @override
  String get importExportDisclaimer =>
      'As opções a seguir permitirão que você importe/exporte as contas salvas anteriormente.\nPor padrão, este arquivo será armazenado/lido da pasta de downloads com formato CSV, apenas o formato de arquivo CSV é permitido.';

  @override
  String get exportAccounts => 'Exportar';

  @override
  String get importAccounts => 'Importar';

  @override
  String get exportedAccounts => 'Exportado com sucesso';

  @override
  String get importedAccounts => 'Importado com sucesso';

  @override
  String get searchHintText => 'Pesquisar conta';

  @override
  String get seePasswordTooltip => 'Ver senha';

  @override
  String get hidePasswordTooltip => 'Ocultar senha';

  @override
  String get dialogTitle => 'Ops, algo deu errado';

  @override
  String get dialogPickFileExceptionText =>
      'O aplicativo não conseguiu importar sua lista de contas salvas anteriormente, o arquivo está corrompido ou você fechou o seletor.\n\nSe você fechou o seletor, pode fechar este aviso e tentar novamente.';

  @override
  String get dialogPickFolderExceptionText =>
      'O aplicativo não pôde exportar sua lista de contas, ou você teve uma exceção com o arquivo ou fechou o seletor.\n\nSe você fechou o seletor, pode fechar este aviso e tentar novamente.';

  @override
  String get dialogButtonText => 'Ok, entendi';

  @override
  String get deleteDialogTitle => 'Você tem certeza?';

  @override
  String deleteDialogBody(String account) {
    return 'Você vai deletar a conta:\n\n$account\n\nVocê tem certeza que quer removê-la?';
  }

  @override
  String get deleteDialogAdvice => 'Esta ação não pode ser desfeita.';

  @override
  String get deleteDialogCancel => 'Não, volte';

  @override
  String get deleteDialogConfirm => 'Sim, tenho certeza';

  @override
  String get randomPasswordViewTitle => 'Gerador de Senha Aleatória';

  @override
  String get randomPasswordDisclaimer =>
      'Esta senha gerada aleatoriamente não será armazenada em lugar nenhum e será descartada ao sair. Para armazená-la, você pode usar o formulário para salvar uma conta. Esta senha pode ser copiada pressionando-a longamente.';

  @override
  String get duplicatedPasswordCheckerSettings => 'Senhas Duplicadas';

  @override
  String get duplicatedPasswordCheckerSettingsDisclaimer =>
      'Este recurso ainda é experimental, desculpe se algo estiver errado, o feedback é apreciado.';

  @override
  String get duplicatedPasswordCheckerViewTitle => 'Verificador de Duplicação';

  @override
  String get duplicatedPasswordCheckerViewLoading =>
      'Carregando estatísticas, isso pode levar um tempo dependendo de quantas contas você armazenou';

  @override
  String duplicatedPasswordCheckerViewSuccess(num percentage) {
    final intl.NumberFormat percentageNumberFormat =
        intl.NumberFormat.percentPattern(localeName);
    final String percentageString = percentageNumberFormat.format(percentage);

    return 'As senhas de $percentageString das contas são diferentes';
  }

  @override
  String get duplicatedPasswordCheckerViewSuccessDisclaimer =>
      'A lista a seguir serve apenas para mostrar as contas que compartilham a mesma senha, você não pode ver a senha nem o e-mail/nome de usuário atribuído a essa conta, apenas o nome que foi usado para salvar a conta.\n\nNotas:\nContas privadas são contadas, mas não mostradas\nO nome do cartão é um espaço reservado, não a senha real';

  @override
  String duplicatedPasswordCheckerViewSuccessCardTitle(num index) {
    final intl.NumberFormat indexNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String indexString = indexNumberFormat.format(index);

    return 'Senha #$indexString';
  }

  @override
  String get duplicatedPasswordCheckerViewUniqueCongrats => 'Parabéns!!';

  @override
  String get duplicatedPasswordCheckerViewUniqueBody =>
      'Todas as suas contas têm uma senha diferente';

  @override
  String get duplicatedPasswordCheckerViewUniqueGoBack => 'Voltar';

  @override
  String get experimentalFeatureInfoTooltip =>
      'Informações do recurso experimental';

  @override
  String get experimentalFeatureInfoDialogTitle => 'Recurso experimental';

  @override
  String get experimentalFeatureInfoDialogBody =>
      'A funcionalidade atual ainda está em fase experimental и pode conter bugs. Se você estiver tendo problemas ou tiver alguma sugestão, sinta-se à vontade para deixar um comentário na Play Store ou abrir um novo ticket na página do projeto no github (se possível)\n\nMuito obrigado pelo seu apoio.';

  @override
  String get experimentalFeatureInfoDialogPlayStore => 'Play Store';

  @override
  String get experimentalFeatureInfoDialogGitHub => 'Github';

  @override
  String get experimentalFeatureInfoDialogConfirm => 'Ok';
}

import 'dart:ui';

import 'package:local_auth/local_auth.dart';
import 'package:password_manager/app/data/repository/services/local_auth_service.dart';
import 'package:password_manager/l10n/app_localizations.dart';

class LocalAuthServiceImpl implements LocalAuthService {
  LocalAuthServiceImpl(this.locale);

  final Locale locale;
  final _localAuthentication = LocalAuthentication();

  @override
  Future<bool> authenticate() async {
    final l10n = lookupAppLocalizations(locale);

    final authenticated = await _localAuthentication.authenticate(
      localizedReason: l10n.fingerprintPrivateAuthTitle,
      // authMessages: [
      //   AndroidAuthMessages(
      //     signInTitle: l10n.fingerprintDialogTitle,
      //     biometricHint: l10n.fingerprintDialogSubtitle,
      //   ),
      // ],
      options: const AuthenticationOptions(
        stickyAuth: true,
        useErrorDialogs: false,
      ),
    );

    return authenticated;
  }
}

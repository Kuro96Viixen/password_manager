import 'package:local_auth/local_auth.dart';
import 'package:password_manager/constants/texts.dart';
import 'package:password_manager/data/repository/services/local_auth_service.dart';

class LocalAuthServiceImpl implements LocalAuthService {
  final _localAuthentication = LocalAuthentication();

  @override
  Future<bool> authenticate() async {
    final authenticated = await _localAuthentication.authenticate(
      localizedReason: Texts.fingerprintPrivateAuthTitle,
      // authMessages: [
      //   AndroidAuthMessages(
      //     signInTitle: Texts.fingerprintDialogTitle,
      //     biometricHint: Texts.fingerprintDialogSubtitle,
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

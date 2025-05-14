import 'package:password_manager/widgets/confetti/utils/launcher.dart';

class ConfettiController {
  /// launch the confetti
  void launch() {
    Launcher.launch(this);
  }

  /// kill the confetti
  void kill() {
    Launcher.kill(this);
  }
}

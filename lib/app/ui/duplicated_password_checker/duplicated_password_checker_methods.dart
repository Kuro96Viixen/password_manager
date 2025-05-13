part of 'duplicated_password_checker_view.dart';

void shootingStars(BuildContext context) {
  /// BEGIN
  final options = ConfettiOptions(
    spread: 360,
    ticks: 50,
    gravity: 0,
    decay: 0.94,
    startVelocity: 20,
    particleCount: 50,
    scalar: 1,
    colors: const [
      Color(0xffBA68C8),
      Color(0xffAB47BC),
      Color(0xffCE93D8),
      Color(0xffE1BEE7),
      Color(0xffF3E5F5),
    ],
  );

  Timer(Duration.zero, () {
    // Big Star
    Confetti.launch(
      context,
      options: options.copyWith(
        particleCount: 40,
        scalar: 1.2,
      ),
      particleBuilder: (index) => ConfettiStar(),
    );
    // Small Star
    Confetti.launch(
      context,
      options: options.copyWith(
        particleCount: 10,
        scalar: 0.75,
      ),
      particleBuilder: (index) => ConfettiStar(),
    );
  });

  ///END
}

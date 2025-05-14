import 'dart:math';
import 'dart:ui';

import 'package:password_manager/widgets/confetti/confetti_particle.dart';
import 'package:password_manager/widgets/confetti/confetti_physics.dart';

class ConfettiStar extends ConfettiParticle {
  @override
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  }) {
    canvas.save();

    final innerRadius = 4 * physics.scalar;
    final outerRadius = 8 * physics.scalar;
    var rot = pi / 2 * 3;
    var x = physics.x;
    var y = physics.y;
    var spikes = 5;
    final step = pi / spikes;

    final path = Path()..moveTo(x, y);

    while (spikes-- >= 0) {
      x = physics.x + cos(rot) * outerRadius;
      y = physics.y + sin(rot) * outerRadius;
      path.lineTo(x, y);
      rot += step;

      x = physics.x + cos(rot) * innerRadius;
      y = physics.y + sin(rot) * innerRadius;
      path.lineTo(x, y);
      rot += step;
    }

    path.close();

    final paint = Paint()
      ..color = physics.color.withValues(alpha: 1 - physics.progress);

    canvas
      ..drawPath(path, paint)
      ..restore();
  }
}

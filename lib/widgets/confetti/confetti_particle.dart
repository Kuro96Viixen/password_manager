import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:password_manager/widgets/confetti/confetti_physics.dart';

abstract class ConfettiParticle {
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  });
}

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confetti_options.freezed.dart';

@freezed
class ConfettiOptions with _$ConfettiOptions {
  factory ConfettiOptions({
    required double spread,
    required int ticks,
    required double decay,
    required double gravity,
    required double startVelocity,
    required int particleCount,
    required double scalar,
    required List<Color> colors,
  }) = _ConfettiOptions;
}

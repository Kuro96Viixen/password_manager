import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ConfettiOptions extends Equatable {
  const ConfettiOptions({
    required this.spread,
    required this.ticks,
    required this.decay,
    required this.gravity,
    required this.startVelocity,
    required this.particleCount,
    required this.scalar,
    required this.colors,
  });

  final double spread;
  final int ticks;
  final double decay;
  final double gravity;
  final double startVelocity;
  final int particleCount;
  final double scalar;
  final List<Color> colors;

  @override
  List<Object?> get props => [
        spread,
        ticks,
        decay,
        gravity,
        startVelocity,
        particleCount,
        scalar,
        colors,
      ];

  ConfettiOptions copyWith({
    double? spread,
    int? ticks,
    double? decay,
    double? gravity,
    double? startVelocity,
    int? particleCount,
    double? scalar,
    List<Color>? colors,
  }) {
    return ConfettiOptions(
      spread: spread ?? this.spread,
      ticks: ticks ?? this.ticks,
      decay: decay ?? this.decay,
      gravity: gravity ?? this.gravity,
      startVelocity: startVelocity ?? this.startVelocity,
      particleCount: particleCount ?? this.particleCount,
      scalar: scalar ?? this.scalar,
      colors: colors ?? this.colors,
    );
  }
}

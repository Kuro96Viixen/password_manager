import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:password_manager/widgets/confetti/confetti_controller.dart';
import 'package:password_manager/widgets/confetti/confetti_options.dart';
import 'package:password_manager/widgets/confetti/confetti_particle.dart';
import 'package:password_manager/widgets/confetti/confetti_physics.dart';
import 'package:password_manager/widgets/confetti/utils/glue.dart';
import 'package:password_manager/widgets/confetti/utils/launcher.dart';
import 'package:password_manager/widgets/confetti/utils/launcher_config.dart';
import 'package:password_manager/widgets/confetti/utils/painter.dart';

typedef ParticleBuilder = ConfettiParticle Function(int index);

class Confetti extends StatefulWidget {
  /// The options used to launch the confetti.
  final ConfettiOptions options;

  /// A builder that creates the particles.
  /// if you don't provide one, a default one will be used.
  /// the default particles are circles and squares.
  final ParticleBuilder particleBuilder;

  /// The controller of the confetti.
  /// in general, you don't need to provide one.
  final ConfettiController controller;

  /// A callback that will be called when the confetti finished its animation.
  final void Function()? onFinished;

  const Confetti({
    required this.particleBuilder,
    required this.controller,
    required this.options,
    super.key,
    this.onFinished,
  });

  @override
  State<Confetti> createState() => _ConfettiState();

  /// A quick way to launch the confetti.
  /// Notice: If your APP is not using the MaterialApp as the root widget,
  /// you can't use this method. Instead, you should use the Confetti widget directly.
  /// [context] is the context of the APP.
  /// [options] is the options used to launch the confetti.
  /// [particleBuilder] is the builder that creates the particles. if you don't
  /// provide one, a default one will be used.The default particles are circles and squares..
  /// [onFinished] is a callback that will be called when the confetti finished its animation.
  static ConfettiController launch(
    BuildContext context, {
    required ConfettiOptions options,
    ParticleBuilder? particleBuilder,
  }) {
    OverlayEntry? overlayEntry;
    final controller = ConfettiController();

    overlayEntry = OverlayEntry(
      builder: (BuildContext ctx) {
        final height = MediaQuery.of(ctx).size.height;
        final width = MediaQuery.of(ctx).size.width;

        return Positioned(
          left: width * 0.5,
          top: height * 0.5,
          width: 2,
          height: 2,
          child: Confetti(
            controller: controller,
            options: options,
            particleBuilder: particleBuilder!,
            onFinished: () {
              overlayEntry?.remove();
            },
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry);

    return controller;
  }
}

class _ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  List<Glue> glueList = [];

  late AnimationController animationController;

  late Timer? timer;

  late double containerWidth;
  late double containerHeight;

  int randomInt(int min, int max) {
    return Random().nextInt(max - min) + min;
  }

  void addParticles() {
    final colors = widget.options.colors;
    final colorsCount = colors.length;

    final particleBuilder = widget.particleBuilder;

    final x = 0.5 * containerWidth;
    final y = 0.5 * containerHeight;

    for (var i = 0; i < widget.options.particleCount; i++) {
      final color = colors[i % colorsCount];
      final physic =
          ConfettiPhysics.fromOptions(options: widget.options, color: color)
            ..x = x
            ..y = y;

      final glue = Glue(particle: particleBuilder(i), physics: physic);

      glueList.add(glue);
    }
  }

  void initScheduler() {
    void schedule() {
      final finished = !glueList.any((element) => !element.physics.finished);

      if (finished) {
        animationController.stop();

        if (widget.onFinished != null) {
          widget.onFinished?.call();
        }
      }
    }

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animationController.addListener(schedule);
  }

  void play() {
    if (animationController.isAnimating == false) {
      animationController.repeat();
    }
  }

  void launch() {
    addParticles();
    play();
  }

  void kill() {
    for (final glue in glueList) {
      glue.physics.kill();
    }
  }

  @override
  void initState() {
    super.initState();

    initScheduler();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        launch();
      },
    );

    Launcher.load(
      widget.controller,
      LauncherConfig(onLaunch: launch, onKill: kill),
    );
  }

  @override
  void didUpdateWidget(covariant Confetti oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      Launcher.unload(oldWidget.controller);
      Launcher.load(
        widget.controller,
        LauncherConfig(onLaunch: launch, onKill: kill),
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();

    Launcher.unload(widget.controller);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        containerWidth = constraints.maxWidth;
        containerHeight = constraints.maxHeight;

        return CustomPaint(
          willChange: true,
          painter: Painter(
            glueList: glueList,
            animationController: animationController,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

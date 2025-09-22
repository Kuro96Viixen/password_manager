import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _movingController;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _movingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _movingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    _positionAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: (-screenWidth / 2) - 45,
          end: (screenWidth / 2) + 45,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
    ]).animate(_movingController);

    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white24),
        width: screenWidth,
        child: AnimatedBuilder(
          animation: _movingController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_positionAnimation.value, 0),
              child: const _HorizontalBar(),
            );
          },
        ),
      ),
    );
  }
}

class _HorizontalBar extends StatelessWidget {
  const _HorizontalBar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 4,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.purple[200],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

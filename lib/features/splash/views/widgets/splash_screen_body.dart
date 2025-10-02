import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child:
            Image.asset(
                  "assets/images/autism-high-resolution-logo.png",
                  fit: BoxFit.contain,
                )
                .animate()
                .slide(
                  duration: 1000.ms,
                  begin: const Offset(1, 0),
                  curve: Curves.easeOutCubic,
                )
                .fadeIn(duration: 1000.ms)
                .scale(duration: 1000.ms)
                .then(delay: 300.ms),
      ),
    );
  }
}

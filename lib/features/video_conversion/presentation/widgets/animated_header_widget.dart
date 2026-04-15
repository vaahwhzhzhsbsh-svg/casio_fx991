import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class AnimatedHeaderWidget extends StatefulWidget {
  const AnimatedHeaderWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedHeaderWidget> createState() => _AnimatedHeaderWidgetState();
}

class _AnimatedHeaderWidgetState extends State<AnimatedHeaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _gradientController;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _gradientController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _gradientAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _gradientController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0a0e27),
            const Color(0xFF1a1f3a),
            const Color(0xFF0a0e27),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Shimmer Text
              AnimatedBuilder(
                animation: _gradientAnimation,
                builder: (context, child) {
                  return Shimmer.fromColors(
                    baseColor: const Color(0xFF00d9ff),
                    highlightColor: const Color(0xFFb026ff),
                    period: const Duration(milliseconds: 2000),
                    child: Text(
                      'Youssef Jaber',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.elMessiri(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: const Color(0xFF00d9ff),
                        shadows: [
                          Shadow(
                            color: const Color(0xFF00d9ff).withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              // Subtitle with Animation
              Text(
                'Video Converter',
                style: GoogleFonts.elMessiri(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  color: const Color(0xFF00d9ff).withOpacity(0.7),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: const Duration(milliseconds: 2000),
                    color: const Color(0xFFb026ff),
                  ),
              const SizedBox(height: 20),
              // Animated Underline
              Container(
                height: 3,
                width: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00d9ff),
                      const Color(0xFFb026ff),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scaleX(
                    duration: const Duration(milliseconds: 1500),
                    begin: 0.5,
                    end: 1.0,
                  )
                  .then()
                  .scaleX(
                    duration: const Duration(milliseconds: 1500),
                    begin: 1.0,
                    end: 0.5,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

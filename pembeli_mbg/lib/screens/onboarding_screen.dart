import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final VoidCallback? onSkip;

  const OnboardingScreen({super.key, this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/onboarding_grocery.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),

          // Dark Overlay (~40% black) for contrast exactly matching design
          Container(
            color: Colors.black.withValues(alpha: 0.40),
          ),

          // Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Right: Skip>
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onSkip,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: const Text(
                          'Skip>',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 7),

                  // Headline: Grocerynya Pindah ke HP-mu!!
                  const Text(
                    'Grocerynya Pindah ke\nHP-mu!!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      height: 1.18,
                      letterSpacing: -0.2,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle: Lengkapi kebutuhan dapur dan bahan makanan segar tanpa perlu keluar rumah
                  const Text(
                    'Lengkapi kebutuhan dapur dan bahan makanan\nsegar tanpa perlu keluar rumah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                      height: 1.35,
                      letterSpacing: 0.1,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

class PenjualSplashScreen extends StatefulWidget {
  final VoidCallback? onFinished;

  const PenjualSplashScreen({super.key, this.onFinished});

  @override
  State<PenjualSplashScreen> createState() => _PenjualSplashScreenState();
}

class _PenjualSplashScreenState extends State<PenjualSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    // Auto-transition timer
    if (widget.onFinished != null) {
      _timer = Timer(const Duration(milliseconds: 2800), () {
        if (mounted && widget.onFinished != null) {
          widget.onFinished!();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF01A852);

    return Scaffold(
      body: MbgBackground(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SizedBox(
                  width: 162,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // MBG Cart Logo centered
                      Image.asset(
                        'assets/images/logo.png',
                        width: 162,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 18),

                      // Brand title aligned with wheels & basket matching Figma
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Text(
                            'My Big Grocery',
                            style: TextStyle(
                              color: brandGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

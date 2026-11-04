import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Reusable background widget that matches the MBG soft pastel gradient aesthetic.
/// Features medium-sized, perfectly balanced circular/oval ambient radial glows
/// with dimension W: 361, H: 365.69 as specified in the design.
class MbgBackground extends StatelessWidget {
  final Widget child;

  const MbgBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const AmbientBackgroundPainter(),
      child: SizedBox.expand(
        child: child,
      ),
    );
  }
}

class AmbientBackgroundPainter extends CustomPainter {
  const AmbientBackgroundPainter();

  // Exact dimensions requested: W: 361, H: 365.69
  static const double baseWidth = 361.0;
  static const double baseHeight = 365.69;

  void _drawGradientOval({
    required Canvas canvas,
    required Offset center,
    required double width,
    required double height,
    required Color color,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    final scaleY = height / width;
    canvas.scale(1.0, scaleY);
    final radius = width / 2.0;

    final paint = Paint()
      ..shader = ui.Gradient.radial(
        Offset.zero,
        radius,
        [
          color,
          color.withValues(alpha: 0.85),
          color.withValues(alpha: 0.50),
          color.withValues(alpha: 0.18),
          Colors.white.withValues(alpha: 0.0),
        ],
        const [0.0, 0.35, 0.65, 0.85, 1.0],
      );

    canvas.drawCircle(Offset.zero, radius, paint);
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Base clean white background
    final bgPaint = Paint()..color = Colors.white;
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Scale dimensions proportionally to screen width (360 base)
    final scale = size.width / 360.0;
    final blobW = baseWidth * scale;
    final blobH = baseHeight * scale;

    // 2. Top-Right Mint Oval Glow (W: 361, H: 365.69)
    _drawGradientOval(
      canvas: canvas,
      center: Offset(size.width * 0.95, size.height * 0.16),
      width: blobW,
      height: blobH,
      color: const Color(0xFFCBEFDE),
    );

    // 3. Middle-Left Mint Oval Glow (W: 361, H: 365.69)
    _drawGradientOval(
      canvas: canvas,
      center: Offset(-size.width * 0.05, size.height * 0.52),
      width: blobW,
      height: blobH,
      color: const Color(0xFFCBEFDE),
    );

    // 4. Bottom-Right Sky-Blue Oval Glow (W: 361, H: 365.69)
    _drawGradientOval(
      canvas: canvas,
      center: Offset(size.width * 0.95, size.height * 0.80),
      width: blobW,
      height: blobH,
      color: const Color(0xFFCEEBFF),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

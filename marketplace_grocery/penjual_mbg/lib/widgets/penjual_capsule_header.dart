import 'package:flutter/material.dart';

/// Standard Green Capsule Header used across Penjual pages
/// (Produk, Semua Produk, Stok Barang, Notifikasi, etc.)
/// Guarantees 100% identical styling and optical vertical alignment between
/// the back arrow and the title text.
class PenjualCapsuleHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? arrowColor;
  final String? fontFamily;
  final double? height;
  final Gradient? gradient;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final double? iconSize;

  const PenjualCapsuleHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.fontSize,
    this.backgroundColor,
    this.textColor,
    this.arrowColor,
    this.fontFamily,
    this.height,
    this.gradient,
    this.margin,
    this.boxShadow,
    this.iconSize,
  });

  static const Color headerGreen = Color(0xFF9FC89F);
  static const Color textDarkGreen = Color(0xFF1F4827);

  static const LinearGradient pesananMasukGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.85, 1.0],
    colors: [
      Color(0xFF9FC89F),
      Color(0xFF9FC89F),
      Color(0xFF75B175),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // Smaller font size for long titles so they never collide with the back button
    final effectiveFontSize = fontSize ?? (title.length > 22 ? 15.0 : 20.0);
    final effectiveBgColor = backgroundColor ?? headerGreen;
    final effectiveTextColor = textColor ?? textDarkGreen;
    final effectiveArrowColor = arrowColor ?? (textColor ?? Colors.black);
    final effectiveHeight = height ?? 48.0;
    final isBaloo = fontFamily == null || fontFamily == 'Baloo Tammudu 2';

    return Container(
      margin: margin ?? const EdgeInsets.fromLTRB(20, 14, 20, 16),
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: gradient == null ? effectiveBgColor : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(effectiveHeight / 2),
        boxShadow: boxShadow ??
            const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.20),
                offset: Offset(0, 4),
                blurRadius: 6.0,
              ),
            ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Perfectly Centered Title with clearance on both sides, optically aligned with the back arrow
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Center(
              child: Transform.translate(
                // Optical baseline offset for Baloo Tammudu 2 so text is vertically aligned with arrow
                offset: isBaloo ? const Offset(0, 2.5) : Offset.zero,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: fontFamily ?? 'Baloo Tammudu 2',
                      fontSize: effectiveFontSize,
                      fontWeight: FontWeight.w800,
                      color: effectiveTextColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Back button pinned to the left, vertically centered in capsule
          Positioned(
            left: 20,
            child: GestureDetector(
              onTap: onBack,
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Icons.arrow_back,
                color: effectiveArrowColor,
                size: iconSize ?? 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

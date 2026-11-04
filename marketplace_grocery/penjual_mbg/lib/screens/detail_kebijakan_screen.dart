import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

class DetailKebijakanScreen extends StatelessWidget {
  final String title;
  final String content;

  const DetailKebijakanScreen({
    super.key,
    required this.title,
    required this.content,
  });

  static const Color headerGreen = Color(0xFF5AB688);
  static const Color cardBgColor = Color(0xFFB5D7BA);
  static const Color bodyTextColor = Color(0xFF1E2022);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: Column(
          children: [
            // 1. Top White Rounded App Bar matching Figma
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(22),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      // Circular back button matching user asset
                      GestureDetector(
                        key: const Key('btn_back'),
                        onTap: () => Navigator.pop(context),
                        behavior: HitTestBehavior.opaque,
                        child: Image.asset(
                          'assets/images/btn_back_curved_green.png',
                          width: 38,
                          height: 38,
                          errorBuilder: (_, __, ___) => Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE2EDE4),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.reply,
                              color: Color(0xFF00AA5B),
                              size: 22,
                            ),
                          ),
                        ),
                      ),

                      // Center Title
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Baloo Tammudu 2',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: headerGreen,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),

                      // Placeholder for symmetry
                      const SizedBox(width: 42),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Policy Content Card
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    content,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: bodyTextColor,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

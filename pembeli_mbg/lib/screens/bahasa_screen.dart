import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../widgets/mbg_background.dart';

class BahasaScreen extends StatelessWidget {
  const BahasaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.language,
      builder: (context, currentLang, _) {
        final tr = LanguageService.instance.tr;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Ambient Background
              Positioned.fill(
                child: MbgBackground(
                  child: const SizedBox.expand(),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Curved Header Bar with Drop Shadow (Sesuai Figma)
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 14),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Circular Back Button (Asset Asli Figma)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                behavior: HitTestBehavior.opaque,
                                child: Image.asset(
                                  'assets/images/btn_back_circle.png',
                                  width: 36,
                                  height: 36,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            // Centered Title
                            Text(
                              tr('Bahasa', 'Language'),
                              style: const TextStyle(
                                fontFamily: 'Baloo Tammudu 2',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5EC494),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Label: Bahasa Utama
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      tr('Bahasa Utama', 'Main Language'),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A7A7A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Option 1: Bahasa Indonesia
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: _buildLanguageOption(
                      title: 'Bahasa Indonesia',
                      isSelected: currentLang == 'id',
                      onTap: () {
                        LanguageService.instance.setLanguage('id');
                      },
                    ),
                  ),

                  // Option 2: Bahasa Inggris
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: _buildLanguageOption(
                      title: 'Bahasa Inggris',
                      isSelected: currentLang == 'en',
                      onTap: () {
                        LanguageService.instance.setLanguage('en');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: const Color(0xFF00B359), width: 1.5)
              : Border.all(color: Colors.transparent, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'layanan_bantuan_screen.dart';
import 'syarat_ketentuan_screen.dart';
import 'kebijakan_privasi_screen.dart';

class BantuanPengaturanScreen extends StatelessWidget {
  const BantuanPengaturanScreen({super.key});

  static const Color pillBgColor = Color(0xFFF1EDED);
  static const Color textDarkGreen = Color(0xFF1F4827);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule ("Bantuan dan Pengaturan Lainnya" with Back Button)
              PenjualCapsuleHeader(
                title: 'Bantuan dan Pengaturan Lainnya',
                onBack: () => Navigator.pop(context),
              ),

              // 2. Menu Items
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    children: [
                      // Pill 1: Layanan dan Bantuan
                      _buildMenuPill(
                        context,
                        title: 'Layanan dan Bantuan',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LayananBantuanScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),

                      // Pill 2: Syarat dan Ketentuan
                      _buildMenuPill(
                        context,
                        title: 'Syarat dan Ketentuan',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SyaratKetentuanScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),

                      // Pill 3: Kebijakan Privasi
                      _buildMenuPill(
                        context,
                        title: 'Kebijakan Privasi',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const KebijakanPrivasiScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuPill(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: pillBgColor,
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 3),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: textDarkGreen,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

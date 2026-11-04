import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

class SyaratKetentuanScreen extends StatelessWidget {
  const SyaratKetentuanScreen({super.key});

  static const Color headerGreen = Color(0xFF5AB688);
  static const Color cardBgColor = Color(0xFFB5D7BA);
  static const Color labelTextColor = Color(0xFF4A4A4A);
  static const Color bodyTextColor = Color(0xFF1E2022);

  final List<Map<String, String>> _terms = const [
    {
      'label': 'Ketentuan Akun Toko',
      'body':
          'Penjual wajib memberikan data informasi toko, identitas asli, dan rekening bank yang valid serta bertanggung jawab penuh atas keamanan akun masing-masing.',
    },
    {
      'label': 'Aturan Produk & Penjualan',
      'body':
          'Produk sembako, daging, atau bahan segar yang dijual harus berkualitas baik, sesuai deskripsi, halal/legal, dan tidak melanggar hukum yang berlaku.',
    },
    {
      'label': 'Transaksi & Pencairan Dana',
      'body':
          'Hasil penjualan dari pembeli akan masuk ke saldo toko setelah pesanan selesai. Penjual dapat melakukan penarikan dana (withdraw) sesuai ketentuan biaya admin dan minimum saldo.',
    },
    {
      'label': 'Kebijakan Komisi & Penalti',
      'body':
          'Pihak platform berhak mengenakan biaya layanan/komisi per transaksi dan memberikan sanksi atau penangguhan toko jika terbukti melakukan kecurangan.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: Column(
          children: [
            // 1. Top White Rounded App Bar matching Figma Screen 3
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

                      // Center Title: Syarat dan Ketentuan
                      Expanded(
                        child: Text(
                          'Syarat dan Ketentuan',
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

            // 2. Content (Scrollable List of Terms)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < _terms.length; i++) ...[
                      // Section Label
                      Text(
                        _terms[i]['label']!,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: labelTextColor,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Section Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
                          _terms[i]['body']!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: bodyTextColor,
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

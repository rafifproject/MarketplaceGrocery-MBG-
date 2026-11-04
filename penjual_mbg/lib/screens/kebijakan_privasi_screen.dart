import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import 'detail_kebijakan_screen.dart';

class KebijakanPrivasiScreen extends StatelessWidget {
  const KebijakanPrivasiScreen({super.key});

  static const Color headerGreen = Color(0xFF5AB688);
  static const Color borderGreen = Color(0xFF00AA5B);
  static const Color bodyTextColor = Color(0xFF1E2022);

  final List<Map<String, String>> _privacyItems = const [
    {
      'buttonLabel': 'Data Pengguna',
      'pageTitle': 'Data Pengguna',
      'content':
          'Kami mengumpulkan data pribadi seperti nama, nomor HP, alamat toko, dan rekening bank yang didaftarkan oleh penjual untuk keperluan verifikasi akun.',
    },
    {
      'buttonLabel': 'Penggunaan Informasi',
      'pageTitle': 'Penggunaan Informasi',
      'content':
          'Data penjual hanya digunakan untuk mengelola toko, memproses pesanan pembeli, serta mencairkan hasil penjualan ke rekening.',
    },
    {
      'buttonLabel': 'Pembagian Data ke Pihak Ketiga',
      'pageTitle': 'Pembagian Data',
      'content':
          'Kami menjaga kerahasiaan data Anda dan hanya membagikannya kepada mitra pembayaran resmi atau kurir demi kelancaran transaksi toko.',
    },
    {
      'buttonLabel': 'Keamanan & Hak Pengguna',
      'pageTitle': 'Keamanan & Hak Pengguna',
      'content':
          'Keamanan akun dilindungi dengan sistem enkripsi dan PIN transaksi. Penjual berhak memperbarui atau menghapus data toko kapan saja.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: Column(
          children: [
            // 1. Top White Rounded App Bar matching Figma Screen 5
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

                      // Center Title: Kebijakan Privasi
                      Expanded(
                        child: Text(
                          'Kebijakan Privasi',
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

            // 2. Content (List of 4 White Pills with Green Border)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Column(
                  children: [
                    for (int i = 0; i < _privacyItems.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailKebijakanScreen(
                                title: _privacyItems[i]['pageTitle']!,
                                content: _privacyItems[i]['content']!,
                              ),
                            ),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: borderGreen, width: 1.2),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.08),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _privacyItems[i]['buttonLabel']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: bodyTextColor,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
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

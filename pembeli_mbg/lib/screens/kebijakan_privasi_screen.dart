import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../widgets/mbg_background.dart';

class KebijakanPrivasiScreen extends StatelessWidget {
  const KebijakanPrivasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.language,
      builder: (context, lang, _) {
        final tr = LanguageService.instance.tr;

        final items = [
          {
            'menuTitle': tr('Data Pengguna', 'User Data'),
            'pageTitle': tr('Data Pengguna', 'User Data'),
            'content': tr(
              'Aplikasi mengumpulkan data pribadi saat Anda mendaftar dan berbelanja, meliputi nama, nomor telepon, email, alamat pengiriman, lokasi GPS untuk mencari toko terdekat, serta riwayat transaksi belanja Anda',
              'The application collects personal data when you register and shop, including name, phone number, email, delivery address, GPS location to find nearest stores, and your shopping transaction history.',
            ),
          },
          {
            'menuTitle': tr('Penggunaan Informasi', 'Use of Information'),
            'pageTitle': tr('Penggunaan Informasi', 'Use of Information'),
            'content': tr(
              'Informasi Anda digunakan khusus untuk memproses dan mengantarkan pesanan bahan makanan, memverifikasi pembayaran (QRIS/COD/E-Wallet), serta mengirimkan notifikasi status pengiriman secara real-time',
              'Your information is used specifically to process and deliver grocery orders, verify payments (QRIS/COD/E-Wallet), and send real-time delivery status notifications.',
            ),
          },
          {
            'menuTitle': tr('Pembagian Data ke Pihak Ketiga', 'Data Sharing with Third Parties'),
            'pageTitle': tr('Pembagian Data', 'Data Sharing'),
            'content': tr(
              'Data alamat dan kontak hanya dibagikan kepada mitra kurir pengiriman dan penyedia layanan pembayaran (payment gateway) demi kelancaran transaksi. Kami tidak pernah memperjualbelikan data Anda ke pihak luar',
              'Address and contact data are only shared with delivery courier partners and payment gateway providers for transaction fulfillment. We never sell your data to outside parties.',
            ),
          },
          {
            'menuTitle': tr('Keamanan & Hak Pengguna', 'Security & User Rights'),
            'pageTitle': tr('Keamanan & Hak Pengguna', 'Security & User Rights'),
            'content': tr(
              'Kami menerapkan sistem keamanan enkripsi data dan perlindungan privasi yang ketat. Anda berhak memperbarui data profil, mengubah kata sandi, atau meminta penghapusan akun kapan saja melalui pengaturan aplikasi.',
              'We apply strict data encryption and privacy protection systems. You have the right to update profile data, change passwords, or request account deletion at any time via app settings.',
            ),
          },
        ];

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
                              tr('Kebijakan Privasi', 'Privacy Policy'),
                              style: const TextStyle(
                                fontFamily: 'Baloo Tammudu 2',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5EC494),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // 4 White Pill Buttons with Green Border & Drop Shadow (Sesuai Figma)
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KebijakanPrivasiDetailScreen(
                                    title: item['pageTitle']!,
                                    content: item['content']!,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 44,
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF00B359),
                                  width: 1.2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                item['menuTitle']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                            ),
                          ),
                        );
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
}

/// Detail Screen for individual Privacy Policy topics
class KebijakanPrivasiDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const KebijakanPrivasiDetailScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
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
                          title,
                          style: const TextStyle(
                            fontFamily: 'Baloo Tammudu 2',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5EC494),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Sage/Mint Green Card with Drop Shadow (Sesuai Figma)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD0E4D0),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFA6CAA6),
                      width: 1.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    content,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.45,
                      color: Color(0xFF1E1E1E),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

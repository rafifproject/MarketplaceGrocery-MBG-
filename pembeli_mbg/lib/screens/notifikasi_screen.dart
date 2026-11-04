import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

class NotificationItem {
  final String title;
  final String message;

  const NotificationItem({required this.title, required this.message});
}

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  static const List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'Pesanan Tiba di Tujuan',
      message:
          'Pesanan 290926XXXXXBGEI telah diterima oleh Amba. Yuk, buka paketmu, konfirmasi penerimaan, dan beri ulasan untuk penjual!',
    ),
    NotificationItem(
      title: 'Pesanan Tiba di Tujuan',
      message:
          'Pesanan 270563XXXXXXYUT telah diterima oleh Amba. Yuk, buka paketmu, konfirmasi penerimaan, dan beri ulasan untuk penjual!',
    ),
    NotificationItem(
      title: 'Pesanan Tiba di Tujuan',
      message:
          'Pesanan 270563XXXXXXYUT telah diterima oleh Amba. Yuk, buka paketmu, konfirmasi penerimaan, dan beri ulasan untuk penjual!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MbgBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Header Pill Stadium Shape presisi Figma: height 58, radius 29, drop shadow lembut
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9FC89F),
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.20),
                        offset: Offset(0, 4),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Tombol Back presisi tengah
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        behavior: HitTestBehavior.opaque,
                        child: Image.asset(
                          'assets/images/kategori_back_arrow.png',
                          width: 30,
                          height: 22,
                          fit: BoxFit.contain,
                          color: Colors.white,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.undo_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Teks "Notifikasi" sejajar 100% presisi horizontal dengan tombol kembali
                      Transform.translate(
                        offset: const Offset(0, 10.0),
                        child: const Text(
                          'Notifikasi',
                          style: TextStyle(
                            fontFamily: 'Baloo Tammudu 2',
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Daftar Kartu Notifikasi Presisi Figma
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: _notifications.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = _notifications[index];
                    return _buildNotificationCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        // Hasil blend #8ABD8B di 67% pada latar agar bayangan tidak tembus ke dalam kartu
        color: const Color(0xFFABD2AC),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(0, 4),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.message,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF222222),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

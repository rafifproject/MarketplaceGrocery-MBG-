import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class PenjualNotificationScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const PenjualNotificationScreen({super.key, this.onBack});

  static const Color brandGreen = Color(0xFF01A852);
  static const Color brandDark = Color(0xFF222222);

  static final List<Map<String, dynamic>> notifications = [
    {
      'id': 'notif_1',
      'type': 'order',
      'message':
          'Pembeli (@ambalohya56) membuat pesanan baru untuk Daging Sapi Wagyu A5 (1 Pcs). Segera proses pesanan sebelum batas waktu!',
      'time': '10 menit yang lalu',
    },
    {
      'id': 'notif_2',
      'type': 'completed',
      'message':
          'Pesanan #GBXTD28097UXXX telah diterima oleh pembeli. Dana sebesar Rp294.900 telah ditambahkan ke saldo toko.',
      'time': '1 jam yang lalu',
    },
    {
      'id': 'notif_3',
      'type': 'finance',
      'message':
          'Penarikan saldo sebesar Rp500.000 ke rekening Bank Syariah Indonesia (BSI) telah berhasil diproses. Cek mutasi rekeningmu.',
      'time': '2 jam yang lalu',
    },
    {
      'id': 'notif_4',
      'type': 'security',
      'message':
          'Keamanan akunmu diperbarui. PIN transaksi 6-digit berhasil diubah pada 13 Oktober 2026.',
      'time': '13 Okt 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MbgBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Green Capsule Header
            _buildNotificationHeader(context),

            // Notification Cards List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 90),
                physics: const BouncingScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notif = notifications[index];
                  return _buildNotificationCard(context, notif);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Green Capsule Header standardized with PenjualCapsuleHeader
  Widget _buildNotificationHeader(BuildContext context) {
    return PenjualCapsuleHeader(
      title: 'Notifikasi',
      onBack: onBack ?? () => Navigator.maybePop(context),
    );
  }

  /// Single Notification Card with prominent drop shadow and exact Figma colors (display only)
  Widget _buildNotificationCard(BuildContext context, Map<String, dynamic> notif) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE7E7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.22),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notif['message'] as String,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.35,
              color: Color(0xFF222222),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            notif['time'] as String,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Halaman Informasi Pembatalan Pesanan (Sisi Penjual)
/// 100% Presisi Identik Desain Figma:
/// - Header Hijau Melengkung dengan tombol lingkaran panah kembali dan judul "Pembatalan Pesanan"
/// - Section "Detail Alasan Pembatalan" dengan ikon info merah & badge status "DiKonfirmasi"
/// - Label "KATEGORI ALASAN" (Oranye) + Ikon Stopwatch Oranye + Teks "Waktu Pengiriman Terlalu Lama / Perubahan Rencana"
/// - Box Hijau dengan "Catatan dari Pembeli (Amba Rita):" & Box dalam berisi teks ulasan pembeli
/// - Label "STATUS PENGEMBALIAN DANA" + Bar Hijau dengan ikon dompet "Pengembalian Dana" & badge "Selesai via QRIS"
class PembatalanPesananScreen extends StatelessWidget {
  final Map<String, dynamic>? order;

  const PembatalanPesananScreen({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final buyerName = order?['buyerName'] as String? ?? 'Amba Rita';
    final cancelReason = order?['cancelNote'] as String? ??
        order?['cancelReason'] as String? ??
        'Maaf terpaksa saya batalkan karena butuh daging segera untuk masak siang ini, namun estimasi persiapan toko memakan waktu lebih dari 45 menit dan kurir belum terkonfirmasi.';
    final categoryReason = order?['categoryReason'] as String? ??
        'Waktu Pengiriman Terlalu Lama / Perubahan Rencana';
    final refundMethod = order?['refundMethod'] as String? ?? 'Selesai via QRIS';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Hijau Melengkung Khas MBG Penjual
          _buildHeader(context),

          // 2. Konten Rincian Pembatalan
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Header Detail Alasan Pembatalan & Badge DiKonfirmasi
                    Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFEBEE),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.info_outline,
                            color: Color(0xFFE53935),
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Detail Alasan Pembatalan',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1E2022),
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F7F3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'DiKonfirmasi',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00A86B),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    const Divider(height: 1, color: Color(0xFFECECEC)),
                    const SizedBox(height: 24),

                    // Section 2: Kategori Alasan
                    const Text(
                      'KATEGORI ALASAN',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE0AA54),
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.timer_outlined,
                            color: Color(0xFFE0AA54),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            categoryReason,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1E293B),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    // Section 3: Catatan dari Pembeli (Box Hijau dengan Box Teks di Dalamnya)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF96C496),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF1B381B),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 18,
                                color: Color(0xFF1B381B),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Catatan dari Pembeli ($buyerName):',
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1B381B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDF3EB),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF1B381B),
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              '"$cancelReason"',
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF222222),
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Section 4: Status Pengembalian Dana
                    const Text(
                      'STATUS PENGEMBALIAN DANA',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8C9BA8),
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Bar Hijau Pengembalian Dana
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF96C496),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Color(0xFF1B381B),
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Pengembalian Dana',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1B381B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF72A672),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              refundMethod,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF143A14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Header hijau melengkung presisi gambar Figma
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF96C496),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(26),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
          child: Row(
            children: [
              // Circular Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD3E7D3),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF1E2022),
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 18),

              // Title "Pembatalan Pesanan"
              const Expanded(
                child: Text(
                  'Pembatalan Pesanan',
                  style: TextStyle(
                    fontSize: 19.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1B381B),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

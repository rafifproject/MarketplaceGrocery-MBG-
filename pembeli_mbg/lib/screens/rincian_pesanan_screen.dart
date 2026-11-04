import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

/// Halaman Rincian Pesanan (Aplikasi Pembeli)
/// 100% Identik Screenshot Figma:
/// - Header pill hijau dengan tombol kembali melengkung: "Rincian Pesanan"
/// - Card 1: Estimasi Tiba (banner hijau) + Info Pengiriman (GrabExpress & Kurir) + Alamat Pengiriman
/// - Card 2: Toko Sayur Mbak Putri + Produk Baby Pak Choi 1 Ikat (Rp7.000 x2) + Rincian Subtotal
/// - Card 3: No. Pesanan + Metode Pembayaran (COD) + Waktu Pemesanan/Pengiriman
class RincianPesananScreen extends StatelessWidget {
  const RincianPesananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MbgBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Header Pill Hijau Floating (Sesuai Figma)
              _buildHeaderPill(context, 'Rincian Pesanan'),
              const SizedBox(height: 16),

              // Scrollable Order Details
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                  children: [
                    // Card 1: Estimasi Pengiriman & Alamat
                    _buildCardEstimasiAlamat(),
                    const SizedBox(height: 14),

                    // Card 2: Toko & Produk & Subtotal
                    _buildCardProdukSubtotal(),
                    const SizedBox(height: 14),

                    // Card 3: No. Pesanan & Waktu
                    _buildCardInfoPesanan(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Floating Green Header Pill
  Widget _buildHeaderPill(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF96C496),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.18),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: const Icon(
              Icons.undo_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Baloo Tammudu 2',
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Card 1: Estimasi Tiba + Info Pengiriman + Alamat Pengiriman
  Widget _buildCardEstimasiAlamat() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Hijau Atas Card: "Estimasi Tiba : 20-30 min"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF8BBF8B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Text(
              'Estimasi Tiba : 20–30 min',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Pengiriman
                const Text(
                  'Info Pengiriman',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E2022),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'GrabExpress',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 12),

                // Baris Status Kurir
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.local_shipping_outlined,
                      size: 22,
                      color: Color(0xFF1E2022),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Pesanan telah diserahkan ke kurir',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E2022),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '28/09/2026 07:30',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF888888),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                ),

                // Alamat Pengiriman
                const Text(
                  'Alamat Pengiriman',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E2022),
                  ),
                ),
                const SizedBox(height: 10),

                // Baris Alamat
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 22,
                      color: Color(0xFF1E2022),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Amba (0812••••7890)',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E2022),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Jl. Cot Tengku Nie, Reuleut Timur, Kab Aceh Utara, Aceh',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF666666),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Card 2: Toko Sayur Mbak Putri + Produk Baby Pak Choi + Subtotal
  Widget _buildCardProdukSubtotal() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama Toko
          Row(
            children: const [
              Icon(
                Icons.storefront_rounded,
                size: 20,
                color: Color(0xFFE0AA54),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Toko Sayur Mbak Putri',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E2022),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFE5E5E5)),
          const SizedBox(height: 12),

          // Baris Produk (Baby Pak Choi 1 Ikat)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk
              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF9F9F9),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/product_pakchoi.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.eco,
                      size: 38,
                      color: Color(0xFF01A852),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Detail Produk: Judul di atas & Harga di bawah
              Expanded(
                child: SizedBox(
                  height: 78,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Baby Pak Choi 1 Ikat',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E2022),
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Rp7.000',
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFC47D2B),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2.5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF5E6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'x2',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF6B8A32),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFD2D2D2)),
          const SizedBox(height: 12),

          // Rincian Subtotal
          _buildSubtotalRow('Subtotal Produk', 'Rp7.000'),
          const SizedBox(height: 6),
          _buildSubtotalRow('Subtotal Pengiriman', 'Rp3.000'),
          const SizedBox(height: 6),
          _buildSubtotalRow('Subtotal Diskon Pengiriman', 'Rp0'),
          const SizedBox(height: 6),
          _buildSubtotalRow('Biaya Layanan', 'Rp2.000'),
        ],
      ),
    );
  }

  Widget _buildSubtotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF444444),
          ),
        ),
      ],
    );
  }

  /// Card 3: No. Pesanan + Metode Pembayaran + Waktu
  Widget _buildCardInfoPesanan() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'No. Pesanan',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E2022),
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  '260928000002XXXCBUY',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF444444),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFD2D2D2)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: Text(
                  'Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Bayar Di tempat (COD)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF444444),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFD2D2D2)),
          const SizedBox(height: 10),
          _buildInfoRow('Waktu Pemesanan', '28/09/2026 06:53'),
          const SizedBox(height: 6),
          _buildInfoRow('Waktu Pembayaran', '-'),
          const SizedBox(height: 6),
          _buildInfoRow('Waktu Pengiriman', '28/09/2026 07:30'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF444444),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import 'pembatalan_pesanan_screen.dart';
import 'ulasan_pembeli_screen.dart';

/// Halaman Pesanan Masuk Penjual
/// 100% presisi Figma:
/// - Gradiasi vertikal hijau header exact Figma stops:
///   85% -> Color(0xFF9FC89F), 100% -> Color(0xFF75B175)
/// - Drop shadow tebal & halus pada header bawah: blur 16, offset (0, 6)
/// - Drop shadow lebih tegas & proporsional pada kartu produk (blur 14, spread 1, offset (0, 5))
/// - Ukuran foto produk diperbesar menjadi 78x78 dengan radius 10
/// - Garis pemisah kartu terbagi dua segmen dengan celah di tengah persis Figma
/// - Menu bar atas digeser manual oleh pengguna (TIDAK bergerak otomatis saat ditekan)
/// - Warna kolom fitur tab yang aktif: Color(0xFFE0AA54) persis hex Figma
/// - Ukuran rektenggel tab ditingkatkan menjadi tinggi 36 dp dengan padding proporsional
class PesananMasukScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PesananMasukScreen({
    super.key,
    this.onBack,
  });

  @override
  State<PesananMasukScreen> createState() => _PesananMasukScreenState();
}

class _PesananMasukScreenState extends State<PesananMasukScreen> {
  // Menu tab categories matching Figma
  static const List<String> _categories = [
    'Semua',
    'Belum diproses',
    'Dikemas',
    'Dikirim',
    'Selesai',
    'Dibatalkan',
  ];

  String _selectedCategory = 'Semua';
  final ScrollController _menuScrollController = ScrollController();

  // Model data pesanan masuk untuk setiap fitur menu persis sesuai Figma
  late List<Map<String, dynamic>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = [
      // ==========================================
      // KELOMPOK: Belum diproses
      // ==========================================
      {
        'id': 'GBXTD23468UXXX',
        'date': '30 Sept 2026-13:40',
        'title': 'Iga Sapi Backribs 500 gram',
        'image': 'assets/images/product_iga_sapi_potong.png',
        'price': 'Rp75.000',
        'qty': 'x1',
        'totalPrice': 'Rp79.000',
        'statusCategory': 'Belum diproses',
        'inSemuaTab': true,
        'statusLeft': 'Belum diproses',
        'deliveryEstimate': null,
        'deliveryIcon': null,
        'inlineAction': null,
        'actionRightType': 'button_kemas',
        'actionRightText': 'Kemas Sekarang',
        'buyerName': 'Budi Santoso',
        'buyerAddress': 'Jl. Merdeka No. 12, Lhokseumawe',
      },
      {
        'id': 'GBXTD200034UXXX',
        'date': '30 Sept 2026-12:39',
        'title': 'Daging Giling Sapi Minced Beef',
        'image': 'assets/images/product_daging_giling.png',
        'price': 'Rp55.000',
        'qty': 'x1',
        'totalPrice': 'Rp59.000',
        'statusCategory': 'Belum diproses',
        'inSemuaTab': true,
        'statusLeft': 'Belum diproses',
        'deliveryEstimate': null,
        'deliveryIcon': null,
        'inlineAction': null,
        'actionRightType': 'button_kemas',
        'actionRightText': 'Kemas Sekarang',
        'buyerName': 'Siti Nurhaliza',
        'buyerAddress': 'Komp. Bukit Indah Blok C3, Blang Pulo',
      },
      {
        'id': 'GBXTD21789UXXX',
        'date': '30 Sept 2026-10:40',
        'title': 'Beef Sirloin Steak 1953',
        'image': 'assets/images/product_sirloin_steak.png',
        'price': 'Rp109.000',
        'qty': 'x1',
        'totalPrice': 'Rp117.000',
        'statusCategory': 'Belum diproses',
        'inSemuaTab': true,
        'statusLeft': 'Belum diproses',
        'deliveryEstimate': null,
        'deliveryIcon': null,
        'inlineAction': null,
        'actionRightType': 'button_kemas',
        'actionRightText': 'Kemas Sekarang',
        'buyerName': 'Ahmad Fauzi',
        'buyerAddress': 'Jl. Samudera Pasai No. 44, Muara Satu',
      },

      // ==========================================
      // KELOMPOK: Dikemas
      // ==========================================
      {
        'id': 'GBXTD28097UXXX',
        'date': '30 Sept 2026-13:40',
        'title': 'Daging Sapi Wagyu A5 250gr',
        'image': 'assets/images/product_wagyu_pack.png',
        'price': 'Rp289.900',
        'qty': 'x1',
        'totalPrice': 'Rp294.900',
        'statusCategory': 'Dikemas',
        'inSemuaTab': true,
        'statusLeft': 'Sedang dikemas',
        'deliveryEstimate': '5–10 min',
        'deliveryIcon': 'box',
        'inlineAction': 'Serahkan',
        'actionRightType': 'text_green',
        'actionRightText': 'Dikemas',
        'buyerName': 'Rian Pratama',
        'buyerAddress': 'Perumahan Asri Indah No. 8, Batuphat Timur',
      },
      {
        'id': 'GBXTD23468UXXX',
        'date': '30 Sept 2026-13:40',
        'title': 'Iga Sapi Backribs 500 gram',
        'image': 'assets/images/product_iga_sapi_potong.png',
        'price': 'Rp75.000',
        'qty': 'x1',
        'totalPrice': 'Rp79.000',
        'statusCategory': 'Dikemas',
        'inSemuaTab': false,
        'statusLeft': 'Sedang dikemas',
        'deliveryEstimate': '5–10 min',
        'deliveryIcon': 'box',
        'inlineAction': 'Serahkan',
        'actionRightType': 'text_green',
        'actionRightText': 'Dikemas',
        'buyerName': 'Budi Santoso',
        'buyerAddress': 'Jl. Merdeka No. 12, Lhokseumawe',
      },

      // ==========================================
      // KELOMPOK: Dikirim
      // ==========================================
      {
        'id': 'GBXTD21790UXXX',
        'date': '30 Sept 2026-07:45',
        'title': 'Daging Sapi Yoshinoya Beef Slice 500gr',
        'image': 'assets/images/product_beef_slice.png',
        'price': 'Rp74.000',
        'qty': 'x1',
        'totalPrice': 'Rp80.000',
        'statusCategory': 'Dikirim',
        'inSemuaTab': true,
        'statusLeft': 'Diserahkan ke kurir',
        'deliveryEstimate': '20–35 min',
        'deliveryIcon': 'motor',
        'inlineAction': null,
        'actionRightType': 'text_green',
        'actionRightText': 'Dikirim',
        'buyerName': 'Dewi Sartika',
        'buyerAddress': 'Jl. Malikussaleh No. 18, Reuleut',
      },
      {
        'id': 'GBXTD28097UXXX',
        'date': '30 Sept 2026-13:40',
        'title': 'Daging Sapi Wagyu A5 250gr',
        'image': 'assets/images/product_wagyu_pack.png',
        'price': 'Rp289.900',
        'qty': 'x1',
        'totalPrice': 'Rp294.900',
        'statusCategory': 'Dikirim',
        'inSemuaTab': false,
        'statusLeft': 'Diserahkan ke kurir',
        'deliveryEstimate': '20–35 min',
        'deliveryIcon': 'motor',
        'inlineAction': null,
        'actionRightType': 'text_green',
        'actionRightText': 'Dikirim',
        'buyerName': 'Rian Pratama',
        'buyerAddress': 'Perumahan Asri Indah No. 8, Batuphat Timur',
      },

      // ==========================================
      // KELOMPOK: Selesai
      // ==========================================
      {
        'id': 'GBXTD6794097UXXX',
        'date': '28 Sept 2026-11:56',
        'title': 'Daging Sapi Wagyu A5 250gr',
        'image': 'assets/images/product_wagyu_pack.png',
        'price': 'Rp289.900',
        'qty': 'x1',
        'totalPrice': 'Rp294.900',
        'statusCategory': 'Selesai',
        'inSemuaTab': true,
        'statusLeft': 'Tiba ditujuan',
        'deliveryEstimate': null,
        'deliveryIcon': null,
        'inlineAction': 'Lihat Ulasan',
        'actionRightType': 'text_green',
        'actionRightText': 'Selesai',
        'buyerName': 'Panggil Aja Rahul',
        'buyerUsername': '@rahuluhuy19',
        'buyerAddress': 'Gedung Rektorat Unimal Lt. 2, Reuleut',
        'reviewText':
            'Oh iya bang, makasih bang dagingnya fresh, kakek buyut saya sampai ingin pesan lagi, sukses selalu bang.',
        'reviewRating': 5.0,
      },

      // ==========================================
      // KELOMPOK: Dibatalkan
      // ==========================================
      {
        'id': 'GBXTD28097UXXX',
        'date': '27 Sept 2026-11:40',
        'title': 'Daging Sapi Wagyu A5 250gr',
        'image': 'assets/images/product_wagyu_pack.png',
        'price': 'Rp289.900',
        'qty': 'x1',
        'totalPrice': 'Rp294.900',
        'statusCategory': 'Dibatalkan',
        'inSemuaTab': true,
        'statusLeft': null,
        'deliveryEstimate': null,
        'deliveryIcon': null,
        'inlineAction': 'Lihat Ulasan',
        'actionRightType': 'text_red',
        'actionRightText': 'Dibatalkan',
        'buyerName': 'Amba Rita',
        'buyerAddress': 'Jl. Cot Tengku Nie, Reuleut Timur, Kab Aceh Utara, Aceh',
        'categoryReason': 'Waktu Pengiriman Terlalu Lama / Perubahan Rencana',
        'cancelReason':
            'Maaf terpaksa saya batalkan karena butuh daging segera untuk masak siang ini, namun estimasi persiapan toko memakan waktu lebih dari 45 menit dan kurir belum terkonfirmasi.',
        'reviewText':
            'Maaf terpaksa saya batalkan karena butuh daging segera untuk masak siang ini, namun estimasi persiapan toko memakan waktu lebih dari 45 menit dan kurir belum terkonfirmasi.',
        'refundMethod': 'Selesai via QRIS',
      },
    ];
  }

  @override
  void dispose() {
    _menuScrollController.dispose();
    super.dispose();
  }

  /// Filter pesanan sesuai fitur menu aktif
  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedCategory == 'Semua') {
      return _orders.where((order) => order['inSemuaTab'] == true).toList();
    }
    return _orders
        .where((order) => order['statusCategory'] == _selectedCategory)
        .toList();
  }

  void _handleBack() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  /// Pemilihan kategori tab:
  /// Manual scroll - pengguna menggeser tab sendiri tanpa auto-scroll otomatis
  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  /// Dialog konfirmasi 'Kemas Sekarang'
  void _handleKemasSekarang(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: Color(0xFF00A852),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Konfirmasi Pengemasan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2022),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'No. Pesanan : ${order['id']}',
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Pastikan produk "${order['title']}" telah disiapkan, ditimbang, dan dikemas dengan rapi sebelum diserahkan ke kurir.',
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF555555),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF666666),
                      side: const BorderSide(color: Color(0xFFDDDDDD)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      setState(() {
                        order['statusCategory'] = 'Dikemas';
                        order['statusLeft'] = 'Sedang dikemas';
                        order['actionRightType'] = 'text_green';
                        order['actionRightText'] = 'Dikemas';
                        order['deliveryEstimate'] = '5–10 min';
                        order['deliveryIcon'] = 'box';
                        order['inlineAction'] = 'Serahkan';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF00A852),
                          content: Text(
                            'Pesanan ${order['id']} sedang dikemas!',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A852),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Kemas Sekarang',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Dialog konfirmasi 'Serahkan' ke kurir
  void _handleSerahkan(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.two_wheeler,
                    color: Color(0xFF00AA5B),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Serahkan ke Kurir',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2022),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'No. Pesanan : ${order['id']}',
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Serahkan paket "${order['title']}" kepada kurir pengantaran. Pastikan kurir telah memindai resi pengiriman.',
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF555555),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF666666),
                      side: const BorderSide(color: Color(0xFFDDDDDD)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      setState(() {
                        order['statusCategory'] = 'Dikirim';
                        order['statusLeft'] = 'Diserahkan ke kurir';
                        order['deliveryEstimate'] = '20–35 min';
                        order['deliveryIcon'] = 'motor';
                        order['actionRightType'] = 'text_green';
                        order['actionRightText'] = 'Dikirim';
                        order['inlineAction'] = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF00A852),
                          content: Text(
                            'Pesanan ${order['id']} telah diserahkan ke kurir!',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A852),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Serahkan Sekarang',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Halaman ulasan pembeli
  void _showReviewDialog(Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UlasanPembeliScreen(order: order),
      ),
    );
  }

  void _showOrderDetailSheet(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Rincian Pesanan',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E2022),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  order['statusCategory'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: order['statusCategory'] == 'Dibatalkan'
                        ? const Color(0xFFE53935)
                        : const Color(0xFF00A852),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    order['image'] as String,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['title'] as String,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E2022),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${order['price']} • ${order['qty']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Total: ${order['totalPrice']}',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF00A852),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 12),
            _buildDetailRow('No. Pesanan', order['id'] as String),
            const SizedBox(height: 6),
            _buildDetailRow('Waktu Pesanan', order['date'] as String),
            const SizedBox(height: 6),
            _buildDetailRow('Pembeli', order['buyerName'] as String? ?? '-'),
            const SizedBox(height: 6),
            _buildDetailRow(
                'Alamat Pengiriman', order['buyerAddress'] as String? ?? '-'),
            const SizedBox(height: 20),
            if (order['statusCategory'] == 'Dibatalkan') ...[
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PembatalanPesananScreen(order: order),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE53935),
                    side: const BorderSide(color: Color(0xFFE53935), width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Lihat Alasan Pembatalan',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A852),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Tutup',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF888888),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF222222),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredOrders;

    return Scaffold(
      backgroundColor: Colors.white,
      body: MbgBackground(
        child: Column(
          children: [
            // Top Green Header dengan Gradient & Drop Shadow Figma
            _buildTopHeader(),

            // Order Cards List
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 30),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        return _buildOrderCard(filtered[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Top Green Header
  /// Presisi 100% Figma:
  /// - Stops Gradient: 85% Color(0xFF9FC89F), 100% Color(0xFF75B175)
  /// - Drop shadow tebal & halus: blur 16, offset (0, 6)
  /// - Tombol lingkaran kembali di kiri (Color 0xFFCEE4CB)
  /// - Judul "Pesanan Masuk" di tengah
  /// - Menu bar horizontal rektenggel di bawah judul yang digeser MANUAL oleh user
  /// - Warna tab aktif: Color(0xFFE0AA54)
  /// Top Green Header
  /// Presisi 100% Figma:
  /// - Stops Gradient: 85% Color(0xFF9FC89F), 100% Color(0xFF75B175)
  /// - Drop shadow tebal & halus: blur 16, offset (0, 6)
  /// - Tombol lingkaran kembali di kiri (Color 0xFFCEE4CB)
  /// - Judul "Pesanan Masuk" di tengah
  /// - Menu bar horizontal rektenggel di bawah judul yang digeser MANUAL oleh user
  /// - Jarak judul ke menu tabs lebih lega (24 dp)
  /// - Rektenggel hijau lebih panjang ke bawah (26 dp di bawah tab)
  /// - Warna tab aktif: Color(0xFFE0AA54)
  /// - Ukuran tab ramping & lebih lebar horizontal (tinggi 29 dp)
  Widget _buildTopHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.85, 1.0],
          colors: [
            Color(0xFF9FC89F),
            Color(0xFF9FC89F),
            Color(0xFF75B175),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.22),
            blurRadius: 16,
            spreadRadius: 1,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Header Top Bar: Back Circle Button & Centered Title
            Stack(
              alignment: Alignment.center,
              children: [
                // Back Button (Circle)
                Positioned(
                  left: 16,
                  child: GestureDetector(
                    key: const Key('btn_pesanan_masuk_back'),
                    onTap: _handleBack,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4E7D0).withValues(alpha: 0.95),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF1B4E1F),
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ),

                // Centered Title: "Pesanan Masuk"
                const Center(
                  child: Text(
                    'Pesanan Masuk',
                    style: TextStyle(
                      fontFamily: 'Baloo Tammudu 2',
                      fontSize: 19.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B4E1F),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ],
            ),
            // Jarak antara teks judul header dengan rektenggel menu lebih lega persis Figma
            const SizedBox(height: 24),

            // Kolom-kolom Menu Tab Rektenggel (Horizontal Scrollable Manual)
            // Bentuk lebih ke lebar dan ramping vertikal (tinggi 29 dp), warna aktif Color(0xFFE0AA54) persis Figma
            SizedBox(
              height: 29,
              child: ListView.separated(
                controller: _menuScrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;
                  return GestureDetector(
                    key: Key('tab_$category'),
                    onTap: () => _selectCategory(category),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 16 : 14,
                        vertical: 4.5,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE0AA54) // Warna E0AA54 persis Figma
                            : Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(
                              0,
                              0,
                              0,
                              isSelected ? 0.14 : 0.07,
                            ),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF707070),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Rektenggel hijau lebih panjang ke bawah persis Figma
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }

  /// Single Order Card
  /// 100% Identik gambar Figma:
  /// - Card Background White, Radius 16
  /// - Drop Shadow lebih tegas: blur 14, spread 1, offset (0, 5)
  /// - Baris 1: No. Pesanan & Tanggal
  /// - Garis pemisah atas batas foto (abu-abu lebih tebal & tegas)
  /// - Baris 2: Foto produk (78x78), Nama, Harga (C47D2B), Badge Qty (x1), Tombol Serahkan / Lihat Ulasan fit
  /// - Garis pemisah bawah batas foto (abu-abu lebih tebal & tegas)
  /// - Baris 3: Estimasi kurir (📦 / 🛵) di kiri, Total harga (00A852) di kanan
  /// - Baris 4: Status di kiri (abu-abu lebih gelap, space sedikit di bawah), Tombol 'Kemas Sekarang' stroke fit rapi
  Widget _buildOrderCard(Map<String, dynamic> order) {
    final hasInlineAction = order['inlineAction'] != null;
    final deliveryEstimate = order['deliveryEstimate'] as String?;
    final deliveryIcon = order['deliveryIcon'] as String?;
    final statusLeft = order['statusLeft'] as String?;
    final actionRightType = order['actionRightType'] as String;
    final actionRightText = order['actionRightText'] as String?;

    return GestureDetector(
      onTap: () {
        if (order['statusCategory'] == 'Dibatalkan' || actionRightText == 'Dibatalkan') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PembatalanPesananScreen(order: order),
            ),
          );
        } else {
          _showOrderDetailSheet(order);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.fromLTRB(16, 13, 16, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.11),
              blurRadius: 14,
              spreadRadius: 1,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris 1: Header No. Pesanan & Tanggal
            Row(
              children: [
                Expanded(
                  child: Text(
                    'No. Pesanan : ${order['id']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6E6E6E),
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  order['date'] as String,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6E6E6E),
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),

            // Garis pembatas ATAS batas foto (abu-abu lebih tegas & tebal)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.1,
                      color: const Color(0xFFD0D0D0),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Container(
                      height: 1.1,
                      color: const Color(0xFFD0D0D0),
                    ),
                  ),
                ],
              ),
            ),

            // Baris 2: Foto Produk (78x78) & Deskripsi
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Produk (Ukuran 78x78 persis Figma)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    order['image'] as String,
                    width: 78,
                    height: 78,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.fastfood,
                        color: Color(0xFF00A852),
                        size: 36,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Info Produk (Tinggi 78 dp sama persis gambar: Judul di batas atas, Harga & Jumlah di batas bawah)
                Expanded(
                  child: SizedBox(
                    height: 78,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order['title'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E2022),
                            height: 1.25,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Harga Produk (Warna C47D2B)
                            Flexible(
                              child: Text(
                                order['price'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFC47D2B),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Badge Qty (x1)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2.5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF5E6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                order['qty'] as String,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF6B8A32),
                                ),
                              ),
                            ),

                            // Tombol Inline (Serahkan / Lihat Ulasan) stroke fit
                            if (hasInlineAction) ...[
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (order['inlineAction'] == 'Serahkan') {
                                    _handleSerahkan(order);
                                  } else if (order['inlineAction'] ==
                                      'Lihat Ulasan') {
                                    _showReviewDialog(order);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: const Color(0xFF38A384),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    order['inlineAction'] as String,
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF269886),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Garis pembatas BAWAH batas foto (abu-abu lebih tegas & tebal) persis Figma
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.1,
                      color: const Color(0xFFD0D0D0),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Container(
                      height: 1.1,
                      color: const Color(0xFFD0D0D0),
                    ),
                  ),
                ],
              ),
            ),

            // Baris 3: Estimasi Pengiriman di kiri & Total Harga di kanan
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Delivery badge (kotak / motor) jika ada
                if (deliveryEstimate != null)
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (deliveryIcon == 'box')
                          Image.asset(
                            'assets/images/icon_order_box.png',
                            width: 16,
                            height: 16,
                            color: const Color(0xFFDF8B30),
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.inventory_2_outlined,
                              size: 16,
                              color: Color(0xFFDF8B30),
                            ),
                          )
                        else if (deliveryIcon == 'motor')
                          Image.asset(
                            'assets/images/icon_motor_orange.png',
                            width: 16,
                            height: 16,
                            color: const Color(0xFFDF8B30),
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.two_wheeler,
                              size: 16,
                              color: Color(0xFFDF8B30),
                            ),
                          ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            deliveryEstimate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFDF8B30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const SizedBox.shrink(),

                const SizedBox(width: 8),

                // Total Harga di kanan
                Flexible(
                  child: Text(
                    'Total harga : ${order['totalPrice']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF00A852),
                    ),
                  ),
                ),
              ],
            ),

            // Baris 4: Status di kiri (space dikit di bawah) & Action fit di kanan
            const SizedBox(height: 6),
            Row(
              children: [
                // Status Left Text (lebih gelap & tegas)
                Expanded(
                  child: Text(
                    statusLeft ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Action Right
                if (actionRightType == 'button_kemas')
                  GestureDetector(
                    onTap: () => _handleKemasSekarang(order),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color(0xFF00AA5B),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        actionRightText ?? 'Kemas Sekarang',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00AA5B),
                        ),
                      ),
                    ),
                  )
                else if (actionRightType == 'text_green')
                  GestureDetector(
                    onTap: () {
                      if (order['inlineAction'] == 'Serahkan') {
                        _handleSerahkan(order);
                      }
                    },
                    child: Text(
                      actionRightText ?? '',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF00AA5B),
                      ),
                    ),
                  )
                else if (actionRightType == 'text_red')
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PembatalanPesananScreen(order: order),
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      actionRightText ?? '',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE53935),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Empty state ketika tab kategori tidak memiliki pesanan
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(35),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: Color(0xFF00A852),
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada pesanan di kategori "$_selectedCategory"',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E2022),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Pesanan baru dari pembeli akan muncul di sini.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}

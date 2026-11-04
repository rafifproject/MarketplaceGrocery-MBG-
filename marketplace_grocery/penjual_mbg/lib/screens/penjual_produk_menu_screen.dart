import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'tambah_produk_screen.dart';
import 'tambah_stok_screen.dart';

class PenjualProdukMenuScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final ValueChanged<bool>? onToggleBottomNav;

  const PenjualProdukMenuScreen({
    super.key,
    this.onBack,
    this.onToggleBottomNav,
  });

  @override
  State<PenjualProdukMenuScreen> createState() =>
      _PenjualProdukMenuScreenState();
}

class _PenjualProdukMenuScreenState extends State<PenjualProdukMenuScreen> {
  static const Color brandGreen = Color(0xFF00AA5B);
  static const Color brandDark = Color(0xFF1E2022);
  static const Color textDarkGreen = Color(0xFF1B4E1F);

  // Active subview: null = main menu ("Semua Produk" & "Stok Barang"), 'all' = Semua Produk grid, 'stock' = Stok Barang grid
  String? _activeSubView;

  // Toko Daging Mas Rusdi Products matching Figma 100%
  final List<Map<String, dynamic>> _allProducts = [
    {
      'titleLine1': 'Daging Sapi',
      'titleLine2': 'Wagyu A5 250gr',
      'titleLine3': null,
      'image': 'assets/images/product_angus_ribeye.png',
      'price': 'Rp289.900',
      'priceNumber': 289900,
      'sold': '10 Terjual',
      'stockPcs': 11,
      'rating': '5.0',
      'location': 'Blang Pulo',
      'hasGratisOngkir': true,
      'stock': 11,
    },
    {
      'titleLine1': 'Fresh Beef Ribeye',
      'titleLine2': 'Steak 500gr',
      'titleLine3': null,
      'image': 'assets/images/product_beef_ribeye.png',
      'price': 'Rp536.000',
      'priceNumber': 536000,
      'sold': '25 Terjual',
      'stockPcs': 30,
      'rating': '4.7',
      'location': 'Blang Pulo',
      'hasGratisOngkir': true,
      'stock': 30,
    },
    {
      'titleLine1': 'Beef Sirloin Steak',
      'titleLine2': '1953',
      'titleLine3': null,
      'image': 'assets/images/product_sirloin_steak.png',
      'price': 'Rp109.000',
      'priceNumber': 109000,
      'sold': '16 Terjual',
      'stockPcs': 12,
      'rating': '4.7',
      'location': 'Blang Pulo',
      'hasGratisOngkir': false,
      'stock': 12,
    },
    {
      'titleLine1': 'Daging Sapi',
      'titleLine2': 'Yoshinoya Beef Slice',
      'titleLine3': '500gr',
      'image': 'assets/images/product_beef_slice.png',
      'price': 'Rp74.000',
      'priceNumber': 74000,
      'sold': '9 Terjual',
      'stockPcs': 12,
      'rating': '4.7',
      'location': 'Blang Pulo',
      'hasGratisOngkir': false,
      'stock': 12,
    },
    {
      'titleLine1': 'Iga Sapi Backribs',
      'titleLine2': '500 gram',
      'titleLine3': null,
      'image': 'assets/images/product_iga_sapi_potong.png',
      'price': 'Rp75.000',
      'priceNumber': 75000,
      'sold': '34 Terjual',
      'stockPcs': 12,
      'rating': '5.0',
      'location': 'Blang Pulo',
      'hasGratisOngkir': true,
      'stock': 12,
    },
    {
      'titleLine1': 'Daging Giling Sapi',
      'titleLine2': 'Minced Beef',
      'titleLine3': null,
      'image': 'assets/images/product_daging_giling.png',
      'price': 'Rp55.000',
      'priceNumber': 55000,
      'sold': '25 Terjual',
      'stockPcs': 12,
      'rating': '5.0',
      'location': 'Blang Pulo',
      'hasGratisOngkir': true,
      'stock': 12,
    },
  ];

  @override
  void dispose() {
    widget.onToggleBottomNav?.call(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MbgBackground(
      child: SafeArea(
        bottom:
            _activeSubView !=
            null, // When bottom nav is hidden, respect bottom safe area
        child: Column(
          children: [
            // Top Green Capsule Header
            _buildHeader(),

            // Content: either the 2 main pill buttons or the selected subview
            Expanded(
              child: _activeSubView == null
                  ? _buildMainMenuView()
                  : _activeSubView == 'all'
                  ? _buildSemuaProdukView()
                  : _buildStokBarangView(),
            ),
          ],
        ),
      ),
    );
  }

  /// Top Green Capsule Header matching Figma exactly
  Widget _buildHeader() {
    final title = _activeSubView == null
        ? 'Produk'
        : _activeSubView == 'all'
        ? 'Semua Produk'
        : 'Stok Barang';

    return PenjualCapsuleHeader(
      title: title,
      onBack: () {
        if (_activeSubView != null) {
          setState(() {
            _activeSubView = null;
          });
          // Restore bottom nav when returning to main product menu
          widget.onToggleBottomNav?.call(true);
        } else {
          widget.onBack?.call();
        }
      },
    );
  }

  /// Main Menu: Two large pill buttons for "Semua Produk" & "Stok Barang"
  Widget _buildMainMenuView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // 1. "Semua Produk" Capsule Button
          _buildMenuPill(
            title: 'Semua Produk',
            onTap: () {
              setState(() {
                _activeSubView = 'all';
              });
              // Hide bottom nav bar on Semua Produk screen matching Figma exactly
              widget.onToggleBottomNav?.call(false);
            },
          ),
          const SizedBox(height: 18),

          // 2. "Stok Barang" Capsule Button
          _buildMenuPill(
            title: 'Stok Barang',
            onTap: () {
              setState(() {
                _activeSubView = 'stock';
              });
              // Hide bottom nav bar on Stok Barang screen matching Figma exactly
              widget.onToggleBottomNav?.call(false);
            },
          ),
        ],
      ),
    );
  }

  /// Single Menu Pill Card
  Widget _buildMenuPill({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFFF1EDED),
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.22),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textDarkGreen,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // --- SUBVIEW 1: SEMUA PRODUK (FIGMA 100%) ---
  // ==========================================
  Widget _buildSemuaProdukView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(14, 2, 14, 24),
      child: Column(
        children: [
          // 2-Column Product Grid dengan tinggi card presisi (mainAxisExtent: 220)
          // Harga dan lokasi sejajar tepat dengan cap hijau Gratis Ongkir
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              mainAxisExtent: 220, // Panjang presisi, bebas dari overflow
            ),
            itemBuilder: (context, index) {
              final prod = _allProducts[index];
              return _buildProductGridCard(prod, index);
            },
          ),

          const SizedBox(height: 18),

          // "Tambah Produk" Capsule Button Matching Figma Bottom
          _buildTambahProdukButton(),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  /// Product Grid Card matching Figma screenshot exactly
  Widget _buildProductGridCard(Map<String, dynamic> item, int index) {
    final hasGratisOngkir = (item['hasGratisOngkir'] as bool?) ?? false;

    return GestureDetector(
      onTap: () => _showProductOptions(item, index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.18),
              offset: Offset(0, 4),
              blurRadius: 6.0,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Produk: Ukuran 126px, padding tipis 4px, rounded 12px
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 126,
                      width: double.infinity,
                      color: Colors.white,
                      child: _buildProductImage(item),
                    ),
                  ),
                ),

                // Area Informasi Produk
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Baris 1: Judul Line 1 + Terjual
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item['titleLine1'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: brandDark,
                                height: 1.15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['sold'] as String,
                            style: const TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF263238),
                            ),
                          ),
                        ],
                      ),

                      // Judul Line 2
                      Text(
                        item['titleLine2'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: brandDark,
                          height: 1.15,
                        ),
                      ),

                      // Optional Judul Line 3 (seperti 500gr pada Yoshinoya Beef Slice)
                      if (item['titleLine3'] != null)
                        Text(
                          item['titleLine3'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: brandDark,
                            height: 1.15,
                          ),
                        ),

                      const SizedBox(height: 2),

                      // Harga Produk Hijau (Sejajar dengan bagian atas cap hijau)
                      Text(
                        item['price'] as String,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w800,
                          color: brandGreen,
                          height: 1.1,
                        ),
                      ),

                      const SizedBox(height: 2),

                      // Rating & Lokasi Toko (Sejajar dengan bagian bawah cap hijau)
                      Row(
                        children: [
                          Text(
                            item['rating'] as String,
                            style: const TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: brandDark,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFB020),
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 1,
                            height: 10,
                            color: const Color(0xFFCBD5E1),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.location_on_outlined,
                            color: brandGreen,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              item['location'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                color: brandGreen,
                              ),
                            ),
                          ),
                          // Space jika ada Gratis Ongkir agar teks lokasi berdampingan rapi
                          if (hasGratisOngkir) const SizedBox(width: 28),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Badge Gratis Ongkir Bookmark Ribbon (Sudut Kanan Bawah, sejajar pas dengan Harga & Lokasi)
            if (hasGratisOngkir)
              Positioned(
                bottom: 0,
                right: 0,
                child: _buildGratisOngkirRibbon(),
              ),
          ],
        ),
      ),
    );
  }

  /// Ribbon Gratis Ongkir dengan notch inverted-V di bagian atas
  Widget _buildGratisOngkirRibbon() {
    return ClipPath(
      clipper: const _RibbonInvertedVClipper(),
      child: Container(
        width: 30,
        height: 36,
        color: const Color(0xFF00B14F),
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Gratis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 7.0,
                fontWeight: FontWeight.w800,
                height: 1.0,
              ),
            ),
            SizedBox(height: 1),
            Text(
              'Ongkir',
              style: TextStyle(
                color: Colors.white,
                fontSize: 7.0,
                fontWeight: FontWeight.w800,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Tombol Tambah Produk Kapsul Hijau di Bagian Bawah Halaman (Halaman Semua Produk)
  Widget _buildTambahProdukButton() {
    return GestureDetector(
      onTap: _navigateToTambahProduk,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF9FC89F),
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 4),
              blurRadius: 6.0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'Tambah Produk',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textDarkGreen,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }

  /// Navigasi ke Halaman Tambah / Masukkan Produk Sesuai Desain Figma
  Future<void> _navigateToTambahProduk() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahProdukScreen(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _allProducts.add(result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Produk "${result['titleLine1']}" berhasil ditambahkan!',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF00AA5B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  /// Helper untuk menampilkan gambar produk baik dari File maupun Asset
  Widget _buildProductImage(Map<String, dynamic> item, {BoxFit fit = BoxFit.cover}) {
    final imgFile = item['imageFile'];
    if (imgFile is File) {
      return Image.file(
        imgFile,
        fit: fit,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.fastfood, color: Colors.grey, size: 36),
        ),
      );
    }
    final imgPath = item['image'] as String?;
    if (imgPath != null && imgPath.isNotEmpty) {
      if (imgPath.startsWith('assets/')) {
        return Image.asset(
          imgPath,
          fit: fit,
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(Icons.fastfood, color: Colors.grey, size: 36),
          ),
        );
      } else {
        return Image.file(
          File(imgPath),
          fit: fit,
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(Icons.fastfood, color: Colors.grey, size: 36),
          ),
        );
      }
    }
    return const Center(child: Icon(Icons.fastfood, color: Colors.grey, size: 36));
  }

  // ==========================================
  // --- SUBVIEW 2: STOK BARANG (FIGMA 100%) ---
  // ==========================================
  Widget _buildStokBarangView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(14, 2, 14, 24),
      child: Column(
        children: [
          // 2-Column Product Grid untuk Stok Barang (Presisi Figma)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              mainAxisExtent: 208,
            ),
            itemBuilder: (context, index) {
              final prod = _allProducts[index];
              return _buildStokBarangCard(prod, index);
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  /// Card Stok Barang: tombol "Tambah Stok" selalu pin di dasar card, font lebih besar & jelas seperti Figma
  Widget _buildStokBarangCard(Map<String, dynamic> item, int index) {
    final stockPcs = item['stockPcs'] ?? item['stock'] ?? 12;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(0, 3),
            blurRadius: 6.0,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Produk (Tinggi 94px, rounded 10px, padding 4px)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 94,
                width: double.infinity,
                child: _buildProductImage(item),
              ),
            ),
          ),

          // Area Informasi + Tombol Tambah Stok
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(9, 5, 9, 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Baris Teks: Judul + stok + harga (Font disesuaikan persis Figma)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Baris 1: Judul Line 1 (+ Sisa Stok jika di baris 1)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item['titleLine1'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                color: brandDark,
                                height: 1.15,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          if (item['titleLine2'] != 'Steak 500gr') ...[
                            const SizedBox(width: 4),
                            Text(
                              '$stockPcs pcs',
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ],
                        ],
                      ),

                      // Judul Line 2 (+ Sisa Stok jika di baris 2 seperti Card 2 di Figma)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item['titleLine2'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                color: brandDark,
                                height: 1.15,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          if (item['titleLine2'] == 'Steak 500gr') ...[
                            const SizedBox(width: 4),
                            Text(
                              '$stockPcs pcs',
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ],
                        ],
                      ),

                      // Optional Judul Line 3 (seperti 500gr pada Yoshinoya Beef Slice)
                      if (item['titleLine3'] != null)
                        Text(
                          item['titleLine3'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w800,
                            color: brandDark,
                            height: 1.15,
                            letterSpacing: -0.2,
                          ),
                        ),

                      const SizedBox(height: 2),

                      // Harga Produk Hijau (Ukuran besar & bold seperti Figma)
                      Text(
                        item['price'] as String,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF00AA5B),
                          height: 1.15,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),

                  // Tombol Kapsul "Tambah Stok" — Kapsul manis di tengah, rapat ke bawah seperti Figma
                  Center(
                    child: GestureDetector(
                      onTap: () => _navigateToTambahStok(item, index),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 122,
                        height: 27,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9FC89F),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Tambah Stok',
                              style: TextStyle(
                                fontFamily: 'Baloo Tammudu 2',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: textDarkGreen,
                                height: 1.0,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigasi ke Halaman Tambah Stok Sesuai Desain Figma
  Future<void> _navigateToTambahStok(Map<String, dynamic> item, int index) async {
    final newStock = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => TambahStokScreen(product: item),
      ),
    );

    if (newStock != null && mounted) {
      setState(() {
        item['stock'] = newStock;
        item['stockPcs'] = newStock;
      });

      final fullTitle =
          '${item['titleLine1']} ${item['titleLine2']} ${item['titleLine3'] ?? ''}'
              .trim();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Stok "$fullTitle" berhasil diperbarui menjadi $newStock pcs!',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF00AA5B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  // ==========================================
  // --- DIALOGS: TAMBAH & OPTIONS PRODUK ---
  // ==========================================
  void _showProductOptions(Map<String, dynamic> item, int index) {
    final fullTitle =
        '${item['titleLine1']} ${item['titleLine2']} ${item['titleLine3'] ?? ''}'
            .trim();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
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
                  width: 40,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      item['image'] as String,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: brandDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['price'] as String,
                          style: const TextStyle(
                            color: brandGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: textDarkGreen),
                title: const Text(
                  'Edit Detail Produk',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.pop(ctx);
                  _showEditProdukDialog(index);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  'Hapus Produk',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.pop(ctx);
                  setState(() {
                    _allProducts.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Produk "$fullTitle" telah dihapus'),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditProdukDialog(int index) {
    final prod = _allProducts[index];
    final title1Ctrl = TextEditingController(
      text: prod['titleLine1'] as String,
    );
    final title2Ctrl = TextEditingController(
      text: prod['titleLine2'] as String,
    );
    final priceCtrl = TextEditingController(
      text: (prod['price'] as String).replaceAll('Rp', ''),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
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
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Edit Produk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: brandDark,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: title1Ctrl,
                decoration: InputDecoration(
                  labelText: 'Judul Baris 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: title2Ctrl,
                decoration: InputDecoration(
                  labelText: 'Judul Baris 2',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceCtrl,
                decoration: InputDecoration(
                  labelText: 'Harga (Rp)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final cleanPrice = priceCtrl.text.trim().replaceAll(
                      RegExp(r'[^0-9]'),
                      '',
                    );
                    final formattedPrice =
                        'Rp${cleanPrice.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';

                    setState(() {
                      prod['titleLine1'] = title1Ctrl.text.trim();
                      prod['titleLine2'] = title2Ctrl.text.trim();
                      if (cleanPrice.isNotEmpty) {
                        prod['price'] = formattedPrice;
                      }
                    });
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}

/// Custom Clipper untuk Ribbon Gratis Ongkir dengan Inverted V Notch di Bagian Atas
class _RibbonInvertedVClipper extends CustomClipper<Path> {
  const _RibbonInvertedVClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, 6.0); // notch ke bawah di tengah atas
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

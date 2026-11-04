import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

/// Halaman Produk Terlaris
/// 100% Presisi Identik Desain Figma:
/// - Header pill hijau (#96C496) dengan tombol panah kembali & judul "Produk Terlaris"
/// - Judul seksi: "Produk Terlaris Hari ini"
/// - Card Produk Terlaris:
///   1. Rank 1: Iga Sapi Backribs 500 gram (Total Terjual : 35 pcs) + Badge 1
///   2. Rank 2: Daging Sapi Yoshinoya Beef Slice 500gr (Total Terjual : 30 pcs) + Badge 2
///   3. Rank 3: Daging Giling Sapi Minced Beef (Total Terjual : 28 pcs) + Badge 3
/// - Background dengan sentuhan ambient gradient lembut (MbgBackground)
class ProdukTerlarisScreen extends StatelessWidget {
  final List<Map<String, dynamic>>? products;

  const ProdukTerlarisScreen({super.key, this.products});

  static const List<Map<String, dynamic>> defaultProducts = [
    {
      'rank': 1,
      'title': 'Iga Sapi Backribs 500 gram',
      'sold': 35,
      'image': 'assets/images/product_beef_backribs.png',
      'badge': 'assets/images/badge_rank_1.png',
    },
    {
      'rank': 2,
      'title': 'Daging Sapi Yoshinoya Beef Slice 500gr',
      'sold': 30,
      'image': 'assets/images/product_beef_slice.png',
      'badge': 'assets/images/badge_rank_2.png',
    },
    {
      'rank': 3,
      'title': 'Daging Giling Sapi Minced Beef',
      'sold': 28,
      'image': 'assets/images/product_beef_minced.png',
      'badge': 'assets/images/badge_rank_3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final list = (products != null && products!.isNotEmpty) ? products! : defaultProducts;

    return Scaffold(
      backgroundColor: Colors.white,
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Pill Hijau Presisi Figma
              _buildHeaderPill(context),

              const SizedBox(height: 24),

              // 2. Judul Seksi "Produk Terlaris Hari ini"
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Produk Terlaris Hari ini',
                  style: TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1B381B),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 3. Daftar Card Produk Terlaris
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return _buildProductCard(context, item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Header pill hijau presisi gambar Figma:
  /// - Memakai PenjualCapsuleHeader dengan gradiasi persis rektenggel pesanan masuk
  ///   stops: [0.0, 0.85, 1.0], colors: [Color(0xFF9FC89F), Color(0xFF9FC89F), Color(0xFF75B175)]
  /// - Teks "Produk Terlaris" sejajar horizontal dengan panah kembali (optical baseline offset)
  Widget _buildHeaderPill(BuildContext context) {
    return PenjualCapsuleHeader(
      title: 'Produk Terlaris',
      onBack: () => Navigator.pop(context),
      gradient: PenjualCapsuleHeader.pesananMasukGradient,
      textColor: const Color(0xFF1B4E1F),
      arrowColor: const Color(0xFF1B4E1F),
      fontSize: 20.0,
      height: 52.0,
      iconSize: 24.0,
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 0),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.20),
          offset: Offset(0, 4),
          blurRadius: 8.0,
        ),
      ],
    );
  }

  /// Card Produk Terlaris
  Widget _buildProductCard(BuildContext context, Map<String, dynamic> item) {
    final title = item['title'] as String? ?? '';
    final sold = item['sold'] ?? 0;
    final image = item['image'] as String? ?? 'assets/images/product_beef_backribs.png';
    final badge = item['badge'] as String? ?? 'assets/images/badge_rank_1.png';
    final rank = item['rank'] as int? ?? 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5F5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Gambar Produk
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 68,
              height: 68,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 68,
                height: 68,
                color: Colors.grey.shade200,
                child: const Icon(Icons.fastfood, color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Judul Produk & Total Terjual
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1E1E),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total Terjual : $sold pcs',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Badge Ranking (Rosette Ribbon)
          Image.asset(
            badge,
            width: 34,
            height: 42,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                '$rank',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

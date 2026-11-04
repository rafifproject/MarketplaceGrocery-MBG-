import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import 'detail_produk_daging_screen.dart';

class FrozenProduct {
  final List<String> nameLines;
  final String image;
  final String price;
  final String sold;
  final double rating;
  final String location;
  final bool isTerlaris;
  final bool hasStore;
  final String? storeName;
  final String? storeImage;

  const FrozenProduct({
    required this.nameLines,
    required this.image,
    required this.price,
    required this.sold,
    required this.rating,
    required this.location,
    this.isTerlaris = false,
    this.hasStore = false,
    this.storeName,
    this.storeImage,
  });
}

class KategoriFrozenScreen extends StatelessWidget {
  const KategoriFrozenScreen({super.key});

  static const List<FrozenProduct> _products = [
    FrozenProduct(
      nameLines: ['Bakso Ikan Besar', 'Go 500gr'],
      image: 'assets/images/frozen_bakso_ikan_go.png',
      price: 'Rp28.000',
      sold: '10 Terjual',
      rating: 5.0,
      location: 'Blang Pulo',
      hasStore: true,
      storeName: 'Saji Cepat Frozen',
      storeImage: 'assets/images/avatar_sajicepat.png',
    ),
    FrozenProduct(
      nameLines: ['Kanzler Chicken', 'Nugget Original', '450gr'],
      image: 'assets/images/frozen_kanzler_nugget.png',
      price: 'Rp43.000',
      sold: '25 Terjual',
      rating: 4.7,
      location: 'Batuphat',
    ),
    FrozenProduct(
      nameLines: ['Fish Dumpling', 'Cheese 200gr'],
      image: 'assets/images/frozen_fish_dumpling.png',
      price: 'Rp28.000',
      sold: '6 Terjual',
      rating: 4.7,
      location: 'Krueng Geukueh',
    ),
    FrozenProduct(
      nameLines: ['Dumpling Ayam', 'Shrimp 200gr'],
      image: 'assets/images/frozen_dumpling_shrimp.png',
      price: 'Rp34.000',
      sold: '9Terjual',
      rating: 4.7,
      location: 'Banda Sakti',
    ),
    FrozenProduct(
      nameLines: ['Dimsum Keju', 'Frozen (4 pcs)'],
      image: 'assets/images/frozen_dimsum_keju.png',
      price: 'Rp20.000',
      sold: '34 Terjual',
      rating: 5.0,
      location: 'Blang Pulo',
      isTerlaris: true,
      hasStore: true,
      storeName: 'Saji Cepat Frozen',
      storeImage: 'assets/images/avatar_sajicepat.png',
    ),
    FrozenProduct(
      nameLines: ['Baso Ikan', 'Sakifudo 500gr'],
      image: 'assets/images/frozen_sakifudo_baso.png',
      price: 'Rp32.000',
      sold: '25 Terjual',
      rating: 5.0,
      location: 'Batuphat',
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

              // Top Rounded Pill Header dengan Drop Shadow presisi (x:0, y:4, blur:4, color: hitam 25%)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9FC89F), // Warna pill presisi Figma #9FC89F
                    borderRadius: BorderRadius.circular(30), // Rounded pill stadium shape
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25), // Hitam 25%
                        offset: Offset(0, 4), // x: 0, y: 4
                        blurRadius: 4.0, // blur 4
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      // Tombol Back dengan Icon Curved Return Arrow asli Figma
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: Image.asset(
                            'assets/images/kategori_back_arrow.png',
                            width: 28,
                            height: 22,
                            fit: BoxFit.contain,
                            color: Colors.white,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.undo_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Kategori FrozenFood',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Product Grid (2 columns)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = (constraints.maxWidth - 10) / 2;

                      return Wrap(
                        spacing: 10,
                        runSpacing: 14,
                        children: _products
                            .map((p) => _buildProductCard(context, p, cardWidth))
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, FrozenProduct product, double cardWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProdukDagingScreen(
              productName: product.nameLines.join('\n'),
              productPrice: product.price,
              productImage: product.image,
              productRating: product.rating.toStringAsFixed(1),
              productLocation: product.location,
              productSold: product.sold,
              hasStore: product.hasStore,
              storeName: product.storeName,
              storeImage: product.storeImage,
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25), // Hitam 25%
            offset: Offset(0, 4), // x: 0, y: 4
            blurRadius: 4.0, // blur 4
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              width: double.infinity,
              height: 124,
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFF1F5F9),
                  alignment: Alignment.center,
                  child: const Icon(Icons.ac_unit, color: Color(0xFF9AC4E8), size: 36),
                ),
              ),
            ),
          ),

          // Content Details
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Sold Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final line in product.nameLines)
                            Text(
                              line,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                                height: 1.15,
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Sold & Terlaris Badge Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.sold,
                          style: const TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Hitam
                          ),
                        ),
                        if (product.isTerlaris) ...[
                          const SizedBox(height: 3),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0xFF12B76A), width: 1.0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Terlaris',
                              style: TextStyle(
                                fontSize: 8.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF12B76A),
                                height: 1.1,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Price
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF12B76A), // Emerald green #12B76A
                  ),
                ),

                const SizedBox(height: 6),

                // Rating & Location Row
                Row(
                  children: [
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.star_rounded,
                      size: 13,
                      color: Color(0xFFF79009), // Amber star
                    ),
                    const SizedBox(width: 5),
                    // Garis lurus abu-abu pemisah bintang dan icon lokasi
                    Container(
                      width: 1.0,
                      height: 10.0,
                      color: const Color(0xFFD1D5DB),
                    ),
                    const SizedBox(width: 5),
                    // Icon Lokasi baru yang di-upload
                    Image.asset(
                      'assets/images/icon_lokasi.png',
                      width: 8,
                      height: 13,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        product.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF12B76A),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}

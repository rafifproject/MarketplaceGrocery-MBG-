import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import 'detail_produk_daging_screen.dart';

class SembakoProduct {
  final String namePart1;
  final String namePart2;
  final String image;
  final String price;
  final String sold;
  final double rating;
  final String location;
  final bool isTerlaris;
  final bool hasStore;
  final String? storeName;
  final String? storeImage;

  const SembakoProduct({
    required this.namePart1,
    required this.namePart2,
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

class KategoriSembakoScreen extends StatelessWidget {
  const KategoriSembakoScreen({super.key});

  static const List<SembakoProduct> _products = [
    SembakoProduct(
      namePart1: 'Tepung Terigu',
      namePart2: 'Segitiga Biru',
      image: 'assets/images/sembako_tepung.png',
      price: 'Rp289.900',
      sold: '10 Terjual',
      rating: 5.0,
      location: 'Blang Pulo',
    ),
    SembakoProduct(
      namePart1: 'Teh Celup',
      namePart2: 'Sariwangi',
      image: 'assets/images/sembako_teh.png',
      price: 'Rp7.000',
      sold: '25 Terjual',
      rating: 4.7,
      location: 'Batuphat',
    ),
    SembakoProduct(
      namePart1: 'Minyak Goreng',
      namePart2: 'Bimoli 1 L',
      image: 'assets/images/sembako_minyak.png',
      price: 'Rp21.000',
      sold: '6 Terjual',
      rating: 4.7,
      location: 'Krueng Geukueh',
      hasStore: true,
      storeName: 'Warung Sembako Lestari',
      storeImage: 'assets/images/avatar_lestari.png',
    ),
    SembakoProduct(
      namePart1: 'Kecap Bango',
      namePart2: 'Btotol',
      image: 'assets/images/sembako_kecap.png',
      price: 'Rp34.000',
      sold: '9Terjual',
      rating: 4.7,
      location: 'Banda Sakti',
    ),
    SembakoProduct(
      namePart1: 'Gulaku Gula',
      namePart2: 'Pasir',
      image: 'assets/images/sembako_gulaku.png',
      price: 'Rp20.000',
      sold: '34 Terjual',
      rating: 5.0,
      location: 'Blang Pulo',
      isTerlaris: true,
    ),
    SembakoProduct(
      namePart1: 'Beras Sania',
      namePart2: '',
      image: 'assets/images/sembako_beras.png',
      price: 'Rp152.000',
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
                          'Kategori Sembako',
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

  Widget _buildProductCard(BuildContext context, SembakoProduct product, double cardWidth) {
    return GestureDetector(
      onTap: () {
        final title = product.namePart2.isEmpty
            ? product.namePart1
            : '${product.namePart1}\n${product.namePart2}';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProdukDagingScreen(
              productName: title,
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
                  child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFE8B87C), size: 36),
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
                    // Title (2 lines max, preserving consistent height)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.namePart1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                              height: 1.15,
                            ),
                          ),
                          if (product.namePart2.isNotEmpty)
                            Text(
                              product.namePart2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                                height: 1.15,
                              ),
                            )
                          else
                            const SizedBox(height: 14),
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

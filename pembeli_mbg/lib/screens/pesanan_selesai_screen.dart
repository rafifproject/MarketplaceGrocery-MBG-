import 'package:flutter/material.dart';
import 'keranjang_screen.dart';
import 'detail_produk_daging_screen.dart';

class OrderSuccessProduct {
  final String titleLine1;
  final String titleLine2;
  final String image;
  final String price;
  final String rating;
  final String location;
  final String sold;
  final String? badge;
  final bool isCover;

  const OrderSuccessProduct({
    required this.titleLine1,
    required this.titleLine2,
    required this.image,
    required this.price,
    required this.rating,
    required this.location,
    required this.sold,
    this.badge,
    this.isCover = false,
  });
}

class PesananSelesaiScreen extends StatelessWidget {
  final bool isCod;

  const PesananSelesaiScreen({
    super.key,
    this.isCod = true,
  });

  static const List<OrderSuccessProduct> _otherProducts = [
    OrderSuccessProduct(
      titleLine1: 'Daging Sapi',
      titleLine2: 'Wagyu A5 250gr',
      image: 'assets/images/product_wagyu.png',
      price: 'Rp289.900',
      rating: '5.0',
      location: 'Blang Pulo',
      sold: '10 Terjual',
      isCover: true,
    ),
    OrderSuccessProduct(
      titleLine1: 'Baby Pak Choi',
      titleLine2: '1 Ikat',
      image: 'assets/images/product_pakchoi.png',
      price: 'Rp7.000',
      rating: '4.7',
      location: 'Batuphat',
      sold: '25 Terjual',
      isCover: true,
    ),
    OrderSuccessProduct(
      titleLine1: 'Minyak Goreng',
      titleLine2: 'Bimoli 1 L',
      image: 'assets/images/product_bimoli.png',
      price: 'Rp21.000',
      rating: '4.7',
      location: 'Krueng Geukueh',
      sold: '6 Terjual',
      isCover: false,
    ),
    OrderSuccessProduct(
      titleLine1: 'Panci Susu/',
      titleLine2: 'Milk Pot',
      image: 'assets/images/product_panci.png',
      price: 'Rp34.000',
      rating: '4.7',
      location: 'Banda Sakti',
      sold: '9Terjual',
      isCover: false,
    ),
    OrderSuccessProduct(
      titleLine1: 'Dimsum Keju',
      titleLine2: 'Frozen  (4 pcs)',
      image: 'assets/images/product_dimsum.png',
      price: 'Rp20.000',
      rating: '5.0',
      location: 'Blang Pulo',
      sold: '34 Terjual',
      badge: 'Terlaris',
      isCover: true,
    ),
    OrderSuccessProduct(
      titleLine1: 'Norwegian',
      titleLine2: 'Salmon 500gr',
      image: 'assets/images/product_salmon.png',
      price: 'Rp152.000',
      rating: '5.0',
      location: 'Batuphat',
      sold: '25 Terjual',
      isCover: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const vibrantGreen = Color(0xFF00AA5B);

    return Scaffold(
      backgroundColor: const Color(0xFF88AC87),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF82A682),
              Color(0xFF8CAF8B),
              Color(0xFF97B897),
              Color(0xFF9FBE9E),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Bagian Atas: Tombol Back (Undo curve arrow)
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KeranjangScreen(initialNavIndex: 0),
                          ),
                          (route) => route.isFirst,
                        );
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9FBFA0),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.undo_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // 2. Banner Teks: "Yeay! Pesanan kamu sedang di proses"
                const Center(
                  child: Text(
                    'Yeay! Pesanan kamu sedang di proses',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // Subteks Panduan Bayar / Pengiriman
                Center(
                  child: Text(
                    isCod
                        ? 'Tunggu pesanan sampai tujuan, lalu bayar di tempat!'
                        : 'Tunggu pesanan sampai tujuan, pesanan sedang diproses!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // 3. Tombol Putih "Lihat Pesanan"
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Langsung diarahkan ke tab Order (index 3) di KeranjangScreen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KeranjangScreen(initialNavIndex: 3),
                        ),
                        (route) => route.isFirst,
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 56.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F6F0),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Lihat Pesanan',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF52B788),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                // 4. Judul Section "Produk Lainnya"
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Produk Lainnya',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // 5. Grid 2 Kolom Produk Lainnya Presisi Mockup Figma
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = (constraints.maxWidth - 12) / 2;

                      return Wrap(
                        spacing: 12,
                        runSpacing: 14,
                        children: _otherProducts.map((product) {
                          return _buildProductCard(context, product, cardWidth, vibrantGreen);
                        }).toList(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Card Produk dengan Rounded Rectangle & Drop Shadow (x: 0, y: 4, blur: 4, 25%)
  Widget _buildProductCard(
    BuildContext context,
    OrderSuccessProduct p,
    double width,
    Color vibrantGreen,
  ) {
    return GestureDetector(
      onTap: () {
        final title = '${p.titleLine1} ${p.titleLine2}';
        final isWagyu = title.contains('Daging') || title.contains('Wagyu');
        final isPakChoi = title.contains('Pak Choi');
        final isBimoli = title.contains('Bimoli');
        final isPanci = title.contains('Panci');
        final isDimsum = title.contains('Dimsum');
        final isSalmon = title.contains('Salmon');
        final hasStore = isWagyu || isPakChoi || isBimoli || isPanci || isDimsum || isSalmon;

        String? storeName;
        String? storeImage;
        if (isWagyu) {
          storeName = 'Toko Daging Mas Rusdi';
          storeImage = 'assets/images/avatar_rusdi.png';
        } else if (isPakChoi) {
          storeName = 'FreshOasis Market';
          storeImage = 'assets/images/avatar_freshoasis.png';
        } else if (isBimoli) {
          storeName = 'Warung Sembako Lestari';
          storeImage = 'assets/images/avatar_lestari.png';
        } else if (isPanci) {
          storeName = 'Toserba Pak Zul';
          storeImage = 'assets/images/avatar_pakzul.png';
        } else if (isDimsum) {
          storeName = 'Saji Cepat Frozen';
          storeImage = 'assets/images/avatar_sajicepat.png';
        } else if (isSalmon) {
          storeName = 'Dapur Sejahtera Store';
          storeImage = 'assets/images/avatar_dapursejahtera.png';
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProdukDagingScreen(
              productName: '${p.titleLine1}\n${p.titleLine2}',
              productPrice: p.price,
              productImage: p.image,
              productRating: p.rating,
              productLocation: p.location,
              productSold: p.sold,
              hasStore: hasStore,
              storeName: storeName,
              storeImage: storeImage,
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 4),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk dengan margin keliling di dalam card
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 132,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.asset(
                    p.image,
                    fit: p.isCover ? BoxFit.cover : BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 44,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris 1: Judul Line 1 & Sold Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          p.titleLine1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E2022),
                            height: 1.15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        p.sold,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: Color(0xFF263238),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  // Baris 2: Judul Line 2 & Badge (Terlaris jika ada)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          p.titleLine2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E2022),
                            height: 1.15,
                          ),
                        ),
                      ),
                      if (p.badge != null) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: vibrantGreen, width: 0.9),
                          ),
                          child: Text(
                            p.badge!,
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.bold,
                              color: vibrantGreen,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Harga Produk Hijau
                  Text(
                    p.price,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: vibrantGreen,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Rating Bintang Oranye & Lokasi Toko Hijau
                  Row(
                    children: [
                      Text(
                        p.rating,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E2022),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFB020),
                        size: 15,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.location_on_outlined,
                        color: vibrantGreen,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          p.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: vibrantGreen,
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

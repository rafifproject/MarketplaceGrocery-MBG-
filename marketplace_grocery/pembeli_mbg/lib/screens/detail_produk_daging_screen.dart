import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../services/cart_service.dart';
import 'keranjang_screen.dart';
import 'konfirmasi_pesanan_screen.dart';
import 'toko_mas_rusdi_screen.dart';

class DetailProdukDagingScreen extends StatefulWidget {
  final String? productName;
  final String? productPrice;
  final int? productPriceNumber;
  final String? productImage;
  final String? productRating;
  final String? productLocation;
  final String? productSold;
  final String? productDescription;
  final bool? isStoreFollowed;
  final bool fromStore;
  final bool hasStore;
  final String? storeName;
  final String? storeImage;

  const DetailProdukDagingScreen({
    super.key,
    this.productName,
    this.productPrice,
    this.productPriceNumber,
    this.productImage,
    this.productRating,
    this.productLocation,
    this.productSold,
    this.productDescription,
    this.isStoreFollowed,
    this.fromStore = false,
    this.hasStore = true,
    this.storeName,
    this.storeImage,
  });

  static const brandThemeGreen = Color(0xFF7BB87B);

  @override
  State<DetailProdukDagingScreen> createState() => _DetailProdukDagingScreenState();
}

class _DetailProdukDagingScreenState extends State<DetailProdukDagingScreen> {
  late bool _isFollowed;

  static const brandThemeGreen = DetailProdukDagingScreen.brandThemeGreen;

  int get _numericPrice {
    if (widget.productPriceNumber != null && widget.productPriceNumber! > 0) {
      return widget.productPriceNumber!;
    }
    if (widget.productPrice != null) {
      final parsed = int.tryParse(widget.productPrice!.replaceAll(RegExp(r'[^0-9]'), ''));
      if (parsed != null && parsed > 0) return parsed;
    }
    return 289900;
  }

  String get _resolvedDescription {
    if (widget.productDescription != null && widget.productDescription!.isNotEmpty) {
      return widget.productDescription!;
    }
    final name = widget.productName?.toLowerCase() ?? '';
    if (name.contains('pak choi')) {
      return 'Baby Pak Choi segar berkualitas tinggi yang dipanen langsung dari kebun hidroponik lokal terpercaya. Memiliki tekstur renyah, rasa manis alami yang segar, dan kaya akan nutrisi, zat besi, serta vitamin untuk kebutuhan sayuran harian keluarga Anda.';
    } else if (name.contains('salak')) {
      return 'Salak Pondoh pilihan dengan daging buah tebal, rasa manis alami, renyah, dan tidak sepat. Dipetik langsung dari kebun petani lokal di puncak masa panen untuk menjaga kesegaran dan cita rasa terbaik sampai ke tangan Anda.';
    } else if (name.contains('bimoli') || name.contains('minyak')) {
      return 'Minyak Goreng Bimoli Spesial diproduksi dari kelapa sawit pilihan berkualitas terbaik dengan proses pemurnian terstandar. Menghasilkan minyak goreng jernih yang tahan panas dan membuat setiap masakan gorengan menjadi lebih renyah, gurih, dan lezat.';
    } else if (name.contains('panci')) {
      return 'Panci Susu / Milk Pot stainless steel premium anti karat dengan gagang ergonomis tahan panas. Sangat cocok digunakan untuk memasak susu, mie instan, sup, saus, dan aneka hidangan keluarga sehari-hari dengan distribusi panas yang merata.';
    } else if (name.contains('dimsum')) {
      return 'Dimsum Keju Frozen isi 4 pcs dengan isian daging ayam dan udang gurih berpadu lelehan keju lumer di dalamnya. Sangat praktis disajikan cukup dikukus atau digoreng selama beberapa menit untuk camilan istimewa.';
    } else if (name.contains('bakso')) {
      return 'Bakso Ikan Besar Go 500gr terbuat dari olahan daging ikan segar pilihan berkualitas tinggi. Tekstur kenyal pas, gurih alami tanpa pengawet berbahaya, sangat cocok untuk hidangan sup, mie, maupun steamboat.';
    } else if (name.contains('cumi')) {
      return 'Cumi Asin pilihan kualitas super dengan rasa gurih pas dan tidak terlalu asin. Tekstur empuk tidak alot, telah dibersihkan secara higienis dan siap diolah menjadi aneka tumisan lezat.';
    } else if (name.contains('salmon')) {
      return 'Norwegian Salmon 500gr kualitas sashimi-grade kaya akan omega-3 dan protein hewani. Daging lembut dengan lapisan lemak sehat khas salmon Norwegia yang lezat dipanggang atau dinikmati mentah.';
    }
    return 'Produk berkualitas tinggi yang dipilih langsung dari mitra terpercaya. Disimpan dan dikemas secara higienis untuk menjaga mutu dan kesegaran terbaik saat sampai ke tangan Anda.';
  }

  String get _reviewVariantName {
    if (widget.productName != null && widget.productName!.isNotEmpty) {
      return widget.productName!.replaceAll('\n', ' ');
    }
    return 'Daging Sapi Wagyu A5 250gr';
  }

  List<String> get _reviewPhotos {
    if (widget.productImage != null && widget.productImage!.isNotEmpty) {
      return [
        widget.productImage!,
        widget.productImage!,
      ];
    }
    return const [
      'assets/images/review_windah_photo.png',
      'assets/images/detail_wagyu.png',
    ];
  }

  String _getReviewComment(int index) {
    final name = widget.productName?.toLowerCase() ?? '';
    if (name.contains('pak choi')) {
      return index == 1
          ? 'Sayurnya sueger rek, alias fresh banget! Daunnya hijau segar tanpa layu, batangnya renyah manis saat ditumis.'
          : 'Pengiriman kilat, packing rapi banget dan pak choi masih segar bugar pas sampai rumah. Mantap FreshOasis!';
    } else if (name.contains('salak')) {
      return index == 1
          ? 'Salaknya manis banget, tidak ada yang busuk, renyah dan daging buahnya tebal. Mantap!'
          : 'Buahnya segar pilihan, kakek sampai suka banget. Kualitas bintang 5 belanja di FreshOasis!';
    } else if (name.contains('bimoli') || name.contains('minyak')) {
      return index == 1
          ? 'Minyaknya jernih, original Bimoli. Gorengan jadi renyah garing dan tidak cepat keruh.'
          : 'Packing sangat aman terlindungi bubble wrap tebal, tidak ada bocor sama sekali. Terimakasih Warung Sembako Lestari.';
    } else if (name.contains('panci')) {
      return index == 1
          ? 'Pancinya bagus banget, stainless tebal dan gagangnya kokoh nyaman dipegang. Masak mie dan susu jadi praktis!'
          : 'Kualitas mantap dari Toserba Pak Zul! Packing kardus tebal dan tidak ada penyok sama sekali.';
    } else if (name.contains('dimsum')) {
      return index == 1
          ? 'Dimsumnya enak banget rek, kejunya beneran lumer pas digigit! Bikin nagih, besok mau repeat order.'
          : 'Keluarga suka banget dimsumnya, gurih dan lembut. Pengiriman cepat beku tetap terjaga aman. Sukses Saji Cepat Frozen!';
    } else if (name.contains('bakso')) {
      return index == 1
          ? 'Bakso ikannya kenyal mantap, terasa ikannya bukan tepung doang. Enak banget buat kuah sup!'
          : 'Segar dan bersih, pengemasan dengan ice gel rapi sehingga tidak rusak di jalan. Kualitas top!';
    } else if (name.contains('cumi')) {
      return index == 1
          ? 'Cumi asinnya mantap, asinnya pas dan tidak alot saat dimasak oseng cabe ijo. Enak parah!'
          : 'Produk seafoodnya bersih, tidak bau amis menyengat. Pengiriman cepat dan higienis. Recommended!';
    } else if (name.contains('salmon')) {
      return index == 1
          ? 'Salmonnya fresh banget, warna oranye cerah dan lembut lumer di mulut. Bintang 5 buat Dapur Sejahtera Store!'
          : 'Kualitas restoran bintang lima, potongan rapi tebal dan tidak ada duri. Pasti langganan di sini!';
    }
    return index == 1
        ? 'Dagingnya sueger rek, alias fresh hehe, besok mau beli lagi satu truck'
        : 'Oh iya bang, makasih bang dagingnya fresh, kakek buyut saya sampai ingin pesan lagi, sukses selalu bang.';
  }

  @override
  void initState() {
    super.initState();
    _isFollowed = widget.isStoreFollowed ?? true;
  }

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

              // 1. Top Header Pill (Stadium Shape Presisi Figma)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      // Tombol Back dengan Curved Return Arrow Figma warna hijau
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: Image.asset(
                            'assets/images/kategori_back_arrow.png',
                            width: 26,
                            height: 20,
                            fit: BoxFit.contain,
                            color: brandThemeGreen,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.undo_rounded,
                              color: brandThemeGreen,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Detail Produk',
                          style: TextStyle(
                            color: brandThemeGreen,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      // Icon Cart Hijau di Kanan dengan Badge Notifikasi
                      ValueListenableBuilder<int>(
                        valueListenable: CartService.instance.cartCount,
                        builder: (context, count, _) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const KeranjangScreen(),
                                ),
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_rounded,
                                  color: brandThemeGreen,
                                  size: 26,
                                ),
                                if (count > 0)
                                  Positioned(
                                    top: -4,
                                    right: -6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 1.5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE53935),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      constraints: const BoxConstraints(minWidth: 16),
                                      alignment: Alignment.center,
                                      child: Text(
                                        count > 99 ? '99+' : '$count',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // 2. Scrollable Body Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 95),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2.1 Hero Product Image Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 330 / 240,
                            child: Image.asset(
                              widget.productImage ?? 'assets/images/detail_wagyu.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: const Color(0xFFF1F5F9),
                                alignment: Alignment.center,
                                child: const Icon(Icons.set_meal, color: brandThemeGreen, size: 48),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // 2.2 Product Information Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                            // Nama Produk & Harga (Ukuran Font Besar Sesuai Figma)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.productName ?? 'Daging Sapi Wagyu\nA5 250gr',
                                    style: const TextStyle(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1E293B),
                                      height: 1.25,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.productPrice ?? 'Rp289.900',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF12B76A),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // Delivery, Location, Rating Row (Pas Ujung Kiri, Tengah, dan Ujung Kanan)
                            Row(
                              children: [
                                // Ujung Kiri: 15–30 min
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/icon_motor_orange.png',
                                        width: 17,
                                        height: 17,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          Icons.two_wheeler_rounded,
                                          color: Color(0xFFF79009),
                                          size: 17,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        '15–30 min',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFF79009),
                                          letterSpacing: -0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Pembatas Vertikal 1
                                Container(
                                  width: 1.0,
                                  height: 14.0,
                                  color: const Color(0xFFD1D5DB),
                                ),

                                // Tengah: Blang Pulo
                                Expanded(
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/images/icon_lokasi.png',
                                          width: 8.5,
                                          height: 13.5,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          widget.productLocation ?? 'Blang Pulo',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF12B76A),
                                            letterSpacing: -0.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Pembatas Vertikal 2
                                Container(
                                  width: 1.0,
                                  height: 14.0,
                                  color: const Color(0xFFD1D5DB),
                                ),

                                // Ujung Kanan: 5.0 ★ • 2 Ulasan
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.productRating ?? '5.0',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1E293B),
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        const Icon(Icons.star_rounded, color: Color(0xFFF79009), size: 14),
                                        SizedBox(width: 3),
                                        Text(
                                          '• 2 Ulasan',
                                          style: TextStyle(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF64748B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Store Section (Toko Daging Mas Rusdi or Placeholder for Unconfigured Stores)
                            Row(
                              children: [
                                // Avatar Bulat dengan Border Hijau / Abu-abu Placeholder
                                Container(
                                  width: 52,
                                  height: 52,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                          ? const Color(0xFF12B76A)
                                          : const Color(0xFFD1D5DB),
                                      width: 1.8,
                                    ),
                                    color: const Color(0xFFF8FAFC),
                                  ),
                                  child: (widget.hasStore && (widget.storeImage != null || widget.storeName != null || widget.productName == null || (widget.productName?.contains('Wagyu') ?? false)))
                                      ? ClipOval(
                                          child: Image.asset(
                                            widget.storeImage ?? StoreData.getStoreByName(widget.storeName).avatar,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => const Icon(
                                              Icons.storefront_rounded,
                                              color: Color(0xFF12B76A),
                                              size: 26,
                                            ),
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.storefront_outlined,
                                            color: Color(0xFFCBD5E1),
                                            size: 24,
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                        Text(
                                          widget.storeName ?? 'Toko Daging Mas Rusdi',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF1E293B),
                                          ),
                                        )
                                      else
                                        // Kolom kosong untuk nama toko jika belum dibuat tokonya
                                        Container(
                                          height: 20,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F9),
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: const Color(0xFFE2E8F0)),
                                          ),
                                        ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          // Tombol Ikuti / Diikuti (Toggle atau Placeholder)
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.hasStore && (widget.storeName?.isNotEmpty ?? true)) {
                                                setState(() {
                                                  _isFollowed = !_isFollowed;
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Toko untuk produk ini belum tersedia'),
                                                    duration: Duration(seconds: 1),
                                                  ),
                                                );
                                              }
                                            },
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                                    ? (_isFollowed ? const Color(0xFF8192A6) : const Color(0xFFD8A854))
                                                    : const Color(0xFFE2E8F0),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                                    ? (_isFollowed ? 'Diikuti' : 'Ikuti')
                                                    : 'Ikuti',
                                                style: TextStyle(
                                                  color: (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                                      ? Colors.white
                                                      : const Color(0xFF94A3B8),
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Tombol Lihat Toko (Aktif atau Placeholder)
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.hasStore && (widget.storeName?.isNotEmpty ?? true)) {
                                                if (widget.fromStore) {
                                                  Navigator.pop(context, _isFollowed);
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => TokoMasRusdiScreen(
                                                        storeName: widget.storeName,
                                                        storeAvatar: widget.storeImage,
                                                        initialFollowed: _isFollowed,
                                                      ),
                                                    ),
                                                  ).then((value) {
                                                    if (value is bool && mounted) {
                                                      setState(() {
                                                        _isFollowed = value;
                                                      });
                                                    }
                                                  });
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Toko untuk produk ini belum tersedia'),
                                                    duration: Duration(seconds: 1),
                                                  ),
                                                );
                                              }
                                            },
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                                    ? const Color(0xFFD8A854)
                                                    : const Color(0xFFE2E8F0),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Lihat Toko',
                                                    style: TextStyle(
                                                      color: (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                                          ? Colors.white
                                                          : const Color(0xFF94A3B8),
                                                      fontSize: 13.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Image.asset(
                                                    'assets/images/icon_store.png',
                                                    width: 14,
                                                    height: 14,
                                                    color: (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                                        ? Colors.white
                                                        : const Color(0xFF94A3B8),
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (context, error, stackTrace) => Icon(
                                                      Icons.store_rounded,
                                                      color: (widget.hasStore && (widget.storeName?.isNotEmpty ?? true))
                                                          ? Colors.white
                                                          : const Color(0xFF94A3B8),
                                                      size: 14,
                                                    ),
                                                  ),
                                                ],
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

                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
                            ),

                            // Deskripsi
                            const Text(
                              'Deskripsi',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF12B76A),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _resolvedDescription,
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Color(0xFF334155),
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // 2.3 Ulasan Section Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                            // Judul Ulasan Terpusat
                            const Center(
                              child: Text(
                                'Ulasan',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF4A6B4A),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
                            ),

                            // Reviewer 1 (Windah BaruSadar)
                            _buildReviewItem(
                              avatarPath: 'assets/images/avatar_windah.png',
                              name: 'Windah BaruSadar',
                              username: '@gamersganteng123',
                              rating: 5,
                              variant: _reviewVariantName,
                              photos: _reviewPhotos,
                              comment: _getReviewComment(1),
                            ),

                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
                            ),

                            // Reviewer 2 (Panggil Aja Rahul)
                            _buildReviewItem(
                              avatarPath: 'assets/images/avatar_rahul.png',
                              name: 'Panggil Aja Rahul',
                              username: '@rahulay19',
                              rating: 5,
                              variant: _reviewVariantName,
                              photos: _reviewPhotos,
                              comment: _getReviewComment(2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 3. Fixed Bottom Action Bar (Presisi Figma dengan Green Square Buttons)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              offset: Offset(0, -3),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            // Tombol Pesan Sekarang
            Expanded(
              child: GestureDetector(
                onTap: () => _showPesanSekarangSheet(context),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: brandThemeGreen,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(0, 3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Pesan sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Tombol Chat (Icon Hijau Asli Figma)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KeranjangScreen(initialNavIndex: 4),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Image.asset(
                    'assets/images/btn_chat_green.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: BoxDecoration(
                        color: brandThemeGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Tombol Cart (Icon Hijau Asli Figma)
            GestureDetector(
              onTap: () => _showAddToCartSheet(context),
              behavior: HitTestBehavior.opaque,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Image.asset(
                    'assets/images/btn_cart_green.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: BoxDecoration(
                        color: brandThemeGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modal 1: Gambar 2 - Alur Tekan Keranjang di samping Chat
  void _showAddToCartSheet(BuildContext context) {
    int quantity = 0;
    const maxStock = 20;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: EdgeInsets.fromLTRB(
                14,
                16,
                14,
                18 + MediaQuery.of(context).viewPadding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row 1: Foto Thumbnail + Harga/Stok + Counter [- 0 +] + Tombol "Masukkan Keranjang"
                  Row(
                    children: [
                      // Thumbnail Produk
                      Container(
                        width: 56,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF1E1E1E), width: 1.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.5),
                          child: Image.asset(
                            widget.productImage ?? 'assets/images/detail_wagyu.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Harga & Stok
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.productPrice ?? 'Rp289.000',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Stok : 20',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Counter Kuantitas [-] 0 [+]
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 0) {
                                setSheetState(() => quantity--);
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: quantity > 0
                                    ? const Color(0xFF5BBF85)
                                    : const Color(0xFF8E8E93),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.remove, color: Colors.white, size: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (quantity < maxStock) {
                                setSheetState(() => quantity++);
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF5BBF85),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.add, color: Colors.white, size: 16),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 8),

                      // Tombol "Masukkan Keranjang" (Berubah hijau saat quantity > 0)
                      GestureDetector(
                        onTap: quantity > 0
                            ? () {
                                CartService.instance.addItem(quantity: quantity);
                                Navigator.pop(sheetCtx);
                                _showTopNotification(context);
                              }
                            : null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: quantity > 0
                                ? const Color(0xFF5BBF85)
                                : const Color(0xFF9E9E9E),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'Masukkan Keranjang',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Row 2: Bottom Bar (Pesan sekarang berubah hijau saat quantity > 0 + Chat + Cart)
                  Row(
                    children: [
                      // Tombol Pesan Sekarang
                      Expanded(
                        child: GestureDetector(
                          onTap: quantity > 0
                              ? () {
                                  Navigator.pop(sheetCtx);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KonfirmasiPesananScreen(
                                        items: [
                                          CheckoutProductItem(
                                            storeName: (widget.hasStore && (widget.storeName?.isNotEmpty ?? false))
                                                ? widget.storeName!
                                                : (widget.storeName ?? 'Toko MBG'),
                                            productTitle: (widget.productName ?? 'Daging Sapi Wagyu A5 250gr').replaceAll('\n', ' '),
                                            productImage: widget.productImage ?? 'assets/images/detail_wagyu.png',
                                            unitPrice: _numericPrice,
                                            quantity: quantity,
                                          ),
                                        ],
                                        initialQuantity: quantity,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: quantity > 0
                                  ? brandThemeGreen
                                  : const Color(0xFF9E9E9E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Pesan sekarang',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Tombol Chat
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/images/btn_chat_green.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF7BB87B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 24),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Tombol Cart
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/images/btn_cart_green.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF7BB87B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Modal 2: Gambar 3 - Alur Tekan "Pesan sekarang"
  void _showPesanSekarangSheet(BuildContext context) {
    int quantity = 0;
    const maxStock = 20;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: EdgeInsets.fromLTRB(
                18,
                18,
                18,
                20 + MediaQuery.of(context).viewPadding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1: Foto Thumbnail + Harga/Stok
                  Row(
                    children: [
                      // Thumbnail Produk
                      Container(
                        width: 78,
                        height: 66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF1E1E1E), width: 1.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.5),
                          child: Image.asset(
                            widget.productImage ?? 'assets/images/detail_wagyu.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Harga & Stok
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.productPrice ?? 'Rp289.000',
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Stok : 20',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Row 2: Counter Kuantitas [- 0 +] + Tombol "Beli Sekarang"
                  Row(
                    children: [
                      // Counter Kuantitas [-] 0 [+]
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 0) {
                                setSheetState(() => quantity--);
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: quantity > 0
                                    ? const Color(0xFF5BBF85)
                                    : const Color(0xFF8E8E93),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.remove, color: Colors.white, size: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (quantity < maxStock) {
                                setSheetState(() => quantity++);
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF5BBF85),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.add, color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 16),

                      // Tombol "Beli Sekarang" (Berubah hijau saat quantity > 0)
                      Expanded(
                        child: GestureDetector(
                          onTap: quantity > 0
                              ? () {
                                  Navigator.pop(sheetCtx);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KonfirmasiPesananScreen(
                                        items: [
                                          CheckoutProductItem(
                                            storeName: (widget.hasStore && (widget.storeName?.isNotEmpty ?? false))
                                                ? widget.storeName!
                                                : (widget.storeName ?? 'Toko MBG'),
                                            productTitle: (widget.productName ?? 'Daging Sapi Wagyu A5 250gr').replaceAll('\n', ' '),
                                            productImage: widget.productImage ?? 'assets/images/detail_wagyu.png',
                                            unitPrice: _numericPrice,
                                            quantity: quantity,
                                          ),
                                        ],
                                        initialQuantity: quantity,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: quantity > 0
                                  ? brandThemeGreen
                                  : const Color(0xFF9E9E9E),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Beli Sekarang',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReviewItem({
    required String avatarPath,
    required String name,
    required String username,
    required int rating,
    required String variant,
    required List<String> photos,
    required String comment,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(avatarPath),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: List.generate(
                      rating,
                      (index) => const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF79009),
                        size: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    variant,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Review Photos Row
        if (photos.isNotEmpty) ...[
          Row(
            children: photos.map((p) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    p,
                    width: 105,
                    height: 92,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
        ],

        // Comment Text
        Text(
          comment,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF334155),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // Notifikasi Floating Pill di Bagian Atas Sesuai Mockup Figma
  void _showTopNotification(BuildContext context) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (ctx) => _TopToastWidget(
        message: 'Produk ini telah ditambahkan ke keranjang',
        onDismissed: () {
          if (entry.mounted) {
            entry.remove();
          }
        },
      ),
    );

    overlay.insert(entry);
  }
}

class _TopToastWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismissed;

  const _TopToastWidget({
    required this.message,
    required this.onDismissed,
  });

  @override
  State<_TopToastWidget> createState() => _TopToastWidgetState();
}

class _TopToastWidgetState extends State<_TopToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2300), () async {
      if (mounted) {
        await _controller.reverse();
        if (mounted) {
          widget.onDismissed();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 10,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.20),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1E1E),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

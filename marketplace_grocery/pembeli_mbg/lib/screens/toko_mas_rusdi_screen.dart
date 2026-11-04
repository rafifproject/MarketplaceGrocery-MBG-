import 'package:flutter/material.dart';
import 'keranjang_screen.dart';
import 'detail_produk_daging_screen.dart';
import 'chat_detail_screen.dart';
import '../widgets/beef_asset_image.dart';

// Model Produk Toko
class StoreProductItem {
  final String titleLine1;
  final String titleLine2;
  final String image;
  final String price;
  final int priceNumber;
  final String rating;
  final String location;
  final String sold;
  final int soldCount;
  final bool isCover;
  final bool isTerlaris;

  const StoreProductItem({
    required this.titleLine1,
    required this.titleLine2,
    required this.image,
    required this.price,
    required this.priceNumber,
    required this.rating,
    required this.location,
    required this.sold,
    required this.soldCount,
    this.isCover = false,
    this.isTerlaris = false,
  });

  String get fullTitle => '$titleLine1 $titleLine2'.trim();
}

// Data Konfigurasi Toko untuk FreshOasis Market, Warung Sembako Lestari, dan Toko Daging Mas Rusdi
class StoreData {
  final String name;
  final String handle;
  final String avatar;
  final int followersCount;
  final List<StoreProductItem> products;

  const StoreData({
    required this.name,
    required this.handle,
    required this.avatar,
    required this.followersCount,
    required this.products,
  });

  // 1. FreshOasis Market (Baby Pak Choi, Salak Pondoh, dll)
  static const StoreData freshOasis = StoreData(
    name: 'FreshOasis Market',
    handle: '@FreshLohYaa67',
    avatar: 'assets/images/avatar_freshoasis.png',
    followersCount: 212,
    products: [
      StoreProductItem(
        titleLine1: 'Baby Pak Choi',
        titleLine2: '1 Ikat',
        image: 'assets/images/sayur_pak_choi.png',
        price: 'Rp7.000',
        priceNumber: 7000,
        rating: '4.7',
        location: 'Batuphat',
        sold: '25 Terjual',
        soldCount: 25,
        isCover: true,
        isTerlaris: true,
      ),
      StoreProductItem(
        titleLine1: 'Salak Pondoh',
        titleLine2: '1 kg',
        image: 'assets/images/sayur_salak.png',
        price: 'Rp36.000',
        priceNumber: 36000,
        rating: '5.0',
        location: 'Batuphat',
        sold: '25 Terjual',
        soldCount: 25,
        isCover: true,
        isTerlaris: true,
      ),
    ],
  );

  // 2. Warung Sembako Lestari (Minyak Goreng Bimoli 1 L, dll)
  static const StoreData sembakoLestari = StoreData(
    name: 'Warung Sembako Lestari',
    handle: '@LestariSembako34',
    avatar: 'assets/images/avatar_lestari.png',
    followersCount: 212,
    products: [
      StoreProductItem(
        titleLine1: 'Minyak Goreng',
        titleLine2: 'Bimoli 1 L',
        image: 'assets/images/sembako_minyak.png',
        price: 'Rp21.000',
        priceNumber: 21000,
        rating: '4.7',
        location: 'Krueng Geukueh',
        sold: '6 Terjual',
        soldCount: 6,
        isCover: true,
        isTerlaris: true,
      ),
    ],
  );

  // 3. Toko Daging Mas Rusdi (Wagyu, Ribeye, Sirloin, dll)
  static const StoreData masRusdi = StoreData(
    name: 'Toko Daging Mas Rusdi',
    handle: '@rusdidaging23',
    avatar: 'assets/images/avatar_rusdi.png',
    followersCount: 213,
    products: [
      StoreProductItem(
        titleLine1: 'Daging Sapi',
        titleLine2: 'Wagyu A5 250gr',
        image: 'assets/images/product_wagyu.png',
        price: 'Rp289.900',
        priceNumber: 289900,
        rating: '5.0',
        location: 'Blang Pulo',
        sold: '10 Terjual',
        soldCount: 10,
        isCover: true,
      ),
      StoreProductItem(
        titleLine1: 'Fresh Beef Ribeye',
        titleLine2: 'Steak 500gr',
        image: 'assets/images/product_beef_ribeye.png',
        price: 'Rp536.000',
        priceNumber: 536000,
        rating: '4.7',
        location: 'Blang Pulo',
        sold: '25 Terjual',
        soldCount: 25,
        isCover: false,
        isTerlaris: true,
      ),
      StoreProductItem(
        titleLine1: 'Beef Sirloin Steak',
        titleLine2: '1953',
        image: 'assets/images/product_beef_sirloin.png',
        price: 'Rp109.000',
        priceNumber: 109000,
        rating: '4.7',
        location: 'Blang Pulo',
        sold: '16 Terjual',
        soldCount: 16,
        isCover: true,
      ),
      StoreProductItem(
        titleLine1: 'Daging Sapi',
        titleLine2: 'Yoshinoya Beef Slice 500gr',
        image: 'assets/images/product_beef_yoshinoya.png',
        price: 'Rp74.000',
        priceNumber: 74000,
        rating: '4.7',
        location: 'Blang Pulo',
        sold: '9 Terjual',
        soldCount: 9,
        isCover: false,
      ),
      StoreProductItem(
        titleLine1: 'Iga Sapi Backribs',
        titleLine2: '500 gram',
        image: 'assets/images/product_beef_backribs.png',
        price: 'Rp75.000',
        priceNumber: 75000,
        rating: '5.0',
        location: 'Blang Pulo',
        sold: '34 Terjual',
        soldCount: 34,
        isCover: true,
        isTerlaris: true,
      ),
      StoreProductItem(
        titleLine1: 'Daging Giling Sapi',
        titleLine2: 'Minced Beef',
        image: 'assets/images/product_beef_minced.png',
        price: 'Rp55.000',
        priceNumber: 55000,
        rating: '5.0',
        location: 'Blang Pulo',
        sold: '25 Terjual',
        soldCount: 25,
        isCover: false,
        isTerlaris: true,
      ),
    ],
  );

  // 4. Toserba Pak Zul (Panci Susu/Milk Pot, dll)
  static const StoreData toserbaPakZul = StoreData(
    name: 'Toserba Pak Zul',
    handle: '@ToserbaPakZul44',
    avatar: 'assets/images/avatar_pakzul.png',
    followersCount: 212,
    products: [
      StoreProductItem(
        titleLine1: 'Panci Susu/',
        titleLine2: 'Milk Pot',
        image: 'assets/images/product_panci.png',
        price: 'Rp34.000',
        priceNumber: 34000,
        rating: '4.7',
        location: 'Banda Sakti',
        sold: '9Terjual',
        soldCount: 9,
        isCover: false,
        isTerlaris: true,
      ),
    ],
  );

  // 5. Saji Cepat Frozen (Bakso Ikan Besar, Dimsum Keju Frozen, dll)
  static const StoreData sajiCepatFrozen = StoreData(
    name: 'Saji Cepat Frozen',
    handle: '@FrozenCepat65',
    avatar: 'assets/images/avatar_sajicepat.png',
    followersCount: 212,
    products: [
      StoreProductItem(
        titleLine1: 'Bakso Ikan Besar',
        titleLine2: 'Go 500gr',
        image: 'assets/images/frozen_bakso_ikan_go.png',
        price: 'Rp28.000',
        priceNumber: 28000,
        rating: '5.0',
        location: 'Blang Pulo',
        sold: '10 Terjual',
        soldCount: 10,
        isCover: true,
        isTerlaris: true,
      ),
      StoreProductItem(
        titleLine1: 'Dimsum Keju',
        titleLine2: 'Frozen (4 pcs)',
        image: 'assets/images/frozen_dimsum_keju.png',
        price: 'Rp20.000',
        priceNumber: 20000,
        rating: '5.0',
        location: 'Blang Pulo',
        sold: '34 Terjual',
        soldCount: 34,
        isCover: true,
        isTerlaris: true,
      ),
    ],
  );

  // 6. Dapur Sejahtera Store (Cumi Asin, Norwegian Salmon, dll)
  static const StoreData dapurSejahtera = StoreData(
    name: 'Dapur Sejahtera Store',
    handle: '@dapursejahtera123',
    avatar: 'assets/images/avatar_dapursejahtera.png',
    followersCount: 212,
    products: [
      StoreProductItem(
        titleLine1: 'Cumi Asin',
        titleLine2: '250 gr',
        image: 'assets/images/seafood_cumi_asin.png',
        price: 'Rp7.000',
        priceNumber: 7000,
        rating: '4.7',
        location: 'Batuphat',
        sold: '25 Terjual',
        soldCount: 25,
        isCover: true,
        isTerlaris: true,
      ),
      StoreProductItem(
        titleLine1: 'Norwegian',
        titleLine2: 'Salmon 500gr',
        image: 'assets/images/seafood_salmon.png',
        price: 'Rp152.000',
        priceNumber: 152000,
        rating: '5.0',
        location: 'Batuphat',
        sold: '25 Terjual',
        soldCount: 25,
        isCover: true,
        isTerlaris: true,
      ),
    ],
  );
  // Alias agar kompatibel
  static const StoreData dapurSeafood = dapurSejahtera;

  static StoreData getStoreByName(String? name) {
    if (name == null || name.isEmpty) return masRusdi;
    final lower = name.toLowerCase();
    if (lower.contains('fresh') || lower.contains('oasis') || lower.contains('sayur')) {
      return freshOasis;
    }
    if (lower.contains('lestari') || lower.contains('sembako') || lower.contains('warung')) {
      return sembakoLestari;
    }
    if (lower.contains('zul') || lower.contains('toserba') || lower.contains('panci')) {
      return toserbaPakZul;
    }
    if (lower.contains('frozen') || lower.contains('saji') || lower.contains('cepat') || lower.contains('dimsum') || lower.contains('bakso')) {
      return sajiCepatFrozen;
    }
    if (lower.contains('sejahtera') || lower.contains('seafood') || lower.contains('cumi') || lower.contains('salmon') || lower.contains('dapur')) {
      return dapurSejahtera;
    }
    return masRusdi;
  }
}

// Alias agar kompatibel baik sebagai TokoMasRusdiScreen maupun TokoScreen umum
typedef TokoScreen = TokoMasRusdiScreen;

class TokoMasRusdiScreen extends StatefulWidget {
  final bool initialFollowed;
  final String? storeName;
  final String? storeHandle;
  final String? storeAvatar;
  final int? followersCount;
  final List<StoreProductItem>? products;

  const TokoMasRusdiScreen({
    super.key,
    this.initialFollowed = true,
    this.storeName,
    this.storeHandle,
    this.storeAvatar,
    this.followersCount,
    this.products,
  });

  @override
  State<TokoMasRusdiScreen> createState() => _TokoMasRusdiScreenState();
}

class _TokoMasRusdiScreenState extends State<TokoMasRusdiScreen> {
  late bool _isFollowed;
  late int _followersCount;
  late String _storeName;
  late String _storeHandle;
  late String _storeAvatar;
  late List<StoreProductItem> _allProducts;

  // Tab filter: 0 = Semua Produk, 1 = Produk Terlaris
  int _selectedFilterIndex = 0;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _isFollowed = widget.initialFollowed;

    final preset = StoreData.getStoreByName(widget.storeName);
    _storeName = widget.storeName ?? preset.name;
    _storeHandle = widget.storeHandle ?? preset.handle;
    _storeAvatar = widget.storeAvatar ?? preset.avatar;
    _followersCount = widget.followersCount ?? preset.followersCount;
    _allProducts = widget.products ?? preset.products;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<StoreProductItem> get _displayedProducts {
    List<StoreProductItem> list = _allProducts;

    // Filter jika tab Produk Terlaris dipilih (produk dengan isTerlaris atau terjual >= 20)
    if (_selectedFilterIndex == 1) {
      list = list.where((p) => p.isTerlaris || p.soldCount >= 20).toList();
    }

    // Filter berdasarkan query pencarian di toko
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((p) => p.fullTitle.toLowerCase().contains(q)).toList();
    }

    return list;
  }


  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF00AA5B);
    const orangeSearch = Color(0xFFE2A84F);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, _isFollowed);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAF7),
        body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Section dengan Foto Daging, Tombol Navigasi, Card Toko Hijau, & Search Bar (Presisi Figma)
            Stack(
              children: [
                // Background Foto Daging & Overlay Gelap
                Positioned.fill(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      buildBeefImage(
                        'assets/images/product_beef_backribs.png',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.35),
                              Colors.black.withValues(alpha: 0.20),
                              Colors.black.withValues(alpha: 0.40),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content Header
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Back & Tombol Home di atas foto
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Tombol Back (Sesuai Tombol Asli Figma User)
                            GestureDetector(
                              onTap: () => Navigator.pop(context, _isFollowed),
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 4),
                                      blurRadius: 4.0,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/images/btn_toko_back.png',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF11B76B).withValues(alpha: 0.50),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.undo_rounded,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Tombol Home (Sesuai Tombol Asli Figma User)
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const KeranjangScreen(initialNavIndex: 0),
                                  ),
                                  (route) => route.isFirst,
                                );
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 4),
                                      blurRadius: 4.0,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/images/btn_toko_home.png',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF11B76B).withValues(alpha: 0.50),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.home_outlined,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Card Profil Toko Hijau (Toko Daging Mas Rusdi)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF078248), // Hijau pekat/tua di sebelah kiri
                                Color(0xFF0D9B57), // Transisi pembatas di pertengahan
                                Color(0xFF14BE6C), // Hijau muda segar di sebelah kanan
                              ],
                              stops: [0.0, 0.48, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 4),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Avatar Toko Dinamis
                              Container(
                                width: 58,
                                height: 58,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2.0),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    _storeAvatar,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.storefront_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Info Toko & Tombol Aksi
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _storeName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      _storeHandle,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Baris 3 Item: Pengikut, Diikuti, Chat
                                    Row(
                                      children: [
                                        // Pill Pengikut
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              buildBeefImage(
                                                'assets/images/icon_store_followers.png',
                                                width: 18,
                                                height: 14,
                                                fit: BoxFit.contain,
                                              ),
                                              const SizedBox(width: 4),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '$_followersCount',
                                                    style: const TextStyle(
                                                      color: brandGreen,
                                                      fontSize: 9.0,
                                                      fontWeight: FontWeight.w800,
                                                      height: 1.0,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Pengikut',
                                                    style: TextStyle(
                                                      color: brandGreen,
                                                      fontSize: 7.5,
                                                      fontWeight: FontWeight.w600,
                                                      height: 1.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        // Tombol Diikuti / Ikuti
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isFollowed = !_isFollowed;
                                              if (_isFollowed) {
                                                _followersCount++;
                                              } else {
                                                _followersCount--;
                                              }
                                            });
                                          },
                                          behavior: HitTestBehavior.opaque,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              _isFollowed ? 'Diikuti' : 'Ikuti',
                                              style: TextStyle(
                                                color: _isFollowed ? const Color(0xFF64748B) : brandGreen,
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        // Tombol Chat Toko
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatDetailScreen(
                                                  storeName: _storeName,
                                                  avatar: _storeAvatar,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                              Icons.chat_bubble_outline_rounded,
                                              color: brandGreen,
                                              size: 15,
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

                        const SizedBox(height: 12),

                        // Search Bar "Cari Produk Toko ini"
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      offset: Offset(0, 3),
                                      blurRadius: 4.0,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (val) {
                                    setState(() {
                                      _searchQuery = val;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Cari Produk Toko ini',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 13.5,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Tombol Search Oranye
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: Container(
                                height: 44,
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: orangeSearch,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.20),
                                      offset: Offset(0, 3),
                                      blurRadius: 4.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.search_rounded, color: Colors.white, size: 18),
                                    SizedBox(width: 4),
                                    Text(
                                      'Search',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
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
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 3. Tab Filter: [Semua Produk] & [Produk Terlaris]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Tab 0: Semua Produk
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = 0;
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: _selectedFilterIndex == 0 ? brandGreen : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: brandGreen,
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              offset: Offset(0, 3),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Semua Produk',
                          style: TextStyle(
                            color: _selectedFilterIndex == 0 ? Colors.white : const Color(0xFF64748B),
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Tab 1: Produk Terlaris (Filter penjualan > 20)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = 1;
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: _selectedFilterIndex == 1 ? brandGreen : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: brandGreen,
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              offset: Offset(0, 3),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Produk Terlaris',
                          style: TextStyle(
                            color: _selectedFilterIndex == 1 ? Colors.white : const Color(0xFF64748B),
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 4. Grid 2 Kolom Produk (Kotak Putih, Drop Shadow Figma)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = (constraints.maxWidth - 12) / 2;
                  final products = _displayedProducts;

                  if (products.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.center,
                      child: const Text(
                        'Tidak ada produk yang sesuai',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return Wrap(
                    spacing: 12,
                    runSpacing: 14,
                    children: products.map((product) {
                      return _buildStoreProductCard(context, product, cardWidth, brandGreen);
                    }).toList(),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // 5. Footer: "Ups! kamu sudah mencapai akhir"
            const Center(
              child: Text(
                'Ups! kamu sudah mencapai akhir',
                style: TextStyle(
                  color: Color(0xFF263238),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    ),
    );
  }

  // Card Produk Toko dengan Kotak Putih & Drop Shadow
  Widget _buildStoreProductCard(
    BuildContext context,
    StoreProductItem p,
    double width,
    Color brandGreen,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProdukDagingScreen(
              productName: '${p.titleLine1} ${p.titleLine2}',
              productPrice: p.price,
              productPriceNumber: p.priceNumber,
              productImage: p.image,
              productRating: p.rating,
              productLocation: p.location,
              productSold: p.sold,
              isStoreFollowed: _isFollowed,
              fromStore: true,
              hasStore: true,
              storeName: _storeName,
              storeImage: _storeAvatar,
            ),
          ),
        ).then((value) {
          if (value is bool && mounted) {
            setState(() {
              _isFollowed = value;
            });
          }
        });
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
                  child: buildBeefImage(
                    p.image,
                    fit: p.isCover ? BoxFit.cover : BoxFit.contain,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris 1: Judul Line 1 & Terjual
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
                            fontSize: 13.0,
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

                  // Baris 2: Judul Line 2
                  Text(
                    p.titleLine2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E2022),
                      height: 1.15,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Harga Hijau
                  Text(
                    p.price,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: brandGreen,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Rating & Lokasi Toko Hijau
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
                        color: brandGreen,
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
                            color: brandGreen,
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

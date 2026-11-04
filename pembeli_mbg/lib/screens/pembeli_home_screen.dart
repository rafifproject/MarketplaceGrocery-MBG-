import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import 'kategori_sayur_screen.dart';
import 'kategori_daging_screen.dart';
import 'kategori_sembako_screen.dart';
import 'kategori_seafood_screen.dart';
import 'kategori_frozen_screen.dart';
import 'detail_produk_daging_screen.dart';
import 'chat_detail_screen.dart';
import 'notifikasi_screen.dart';
import 'profile_screen.dart';
import 'keranjang_screen.dart';
import 'informasi_order_screen.dart';
import 'rincian_pesanan_screen.dart';
import 'nilai_pesanan_screen.dart';
import '../services/language_service.dart';
import '../services/cart_service.dart';

class ProductItem {
  final String title;
  final String image;
  final String price;
  final String rating;
  final String location;
  final String sold;
  final String? badge;

  const ProductItem({
    required this.title,
    required this.image,
    required this.price,
    required this.rating,
    required this.location,
    required this.sold,
    this.badge,
  });
}

class OrderItemData {
  final String storeName;
  final String? storeAction;
  final String productTitle;
  final String productImage;
  final String price;
  final String quantity;
  final String? productAction;
  final String? deliveryAsset;
  final IconData? deliveryIcon;
  final String? deliveryTime;
  final String? deliveryNote;
  final String totalPrice;
  final String statusText;
  final Color statusColor;
  final String categoryStatus;

  const OrderItemData({
    required this.storeName,
    this.storeAction,
    required this.productTitle,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.productAction,
    this.deliveryAsset,
    this.deliveryIcon,
    this.deliveryTime,
    this.deliveryNote,
    required this.totalPrice,
    required this.statusText,
    required this.statusColor,
    required this.categoryStatus,
  });
}

class ChatItemData {
  final String storeName;
  final String username;
  final String lastMessage;
  final String time;
  final String avatar;
  final bool isOnline;
  final bool isUnread;
  final int unreadCount;

  const ChatItemData({
    required this.storeName,
    required this.username,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    this.isOnline = false,
    this.isUnread = false,
    this.unreadCount = 0,
  });
}

class PembeliHomeScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const PembeliHomeScreen({super.key, required this.onLogout});

  @override
  State<PembeliHomeScreen> createState() => _PembeliHomeScreenState();
}

class _PembeliHomeScreenState extends State<PembeliHomeScreen> {
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;
  int _currentNavIndex = 0;
  int _selectedOrderTabIndex = 0;
  int _selectedChatFilterIndex = 0; // 0: Semua, 1: Belum Dibaca
  final TextEditingController _chatSearchController = TextEditingController();
  String _chatSearchQuery = '';
  late List<ChatItemData> _chatItems;

  final List<String> _orderTabs = const [
    'Semua',
    'Dikemas',
    'Dikirim',
    'Selesai',
    'Dibatalkan',
  ];

  final List<OrderItemData> _orderItems = const [
    OrderItemData(
      storeName: 'Toko Daging Mas Rusdi',
      productTitle: 'Daging Sapi Wagyu A5 250gr',
      productImage: 'assets/images/product_wagyu.png',
      price: 'Rp289.900',
      quantity: 'x1',
      deliveryAsset: 'assets/images/icon_order_box.png',
      deliveryTime: '5–10 min',
      deliveryNote: 'Sedang Dikemas oleh penjual',
      totalPrice: 'Rp289.900',
      statusText: 'Dikemas',
      statusColor: Color(0xFF01A852),
      categoryStatus: 'Dikemas',
    ),
    OrderItemData(
      storeName: 'FreshOasis Market',
      storeAction: 'Lihat',
      productTitle: 'Baby Pak Choi 1 Ikat',
      productImage: 'assets/images/product_pakchoi.png',
      price: 'Rp7.000',
      quantity: 'x2',
      productAction: 'Detail',
      deliveryAsset: 'assets/images/icon_order_motor.png',
      deliveryTime: '20–35 min',
      deliveryNote: 'Sedang dikirim oleh driver',
      totalPrice: 'Rp14.000',
      statusText: 'Dikirim',
      statusColor: Color(0xFF01A852),
      categoryStatus: 'Dikirim',
    ),
    OrderItemData(
      storeName: 'Dapur Sejahtera Store',
      storeAction: 'Nilai',
      productTitle: 'Norwegian Salmon 500gr',
      productImage: 'assets/images/product_salmon.png',
      price: 'Rp152.000',
      quantity: 'x1',
      deliveryAsset: 'assets/images/icon_order_motor.png',
      deliveryTime: '20–35 min',
      deliveryNote: 'Pesanan sampai tujuan',
      totalPrice: 'Rp152.000',
      statusText: 'Selesai',
      statusColor: Color(0xFF01A852),
      categoryStatus: 'Selesai',
    ),
    OrderItemData(
      storeName: 'Toserba Pak Zul',
      productTitle: 'Panci Susu/Milk Pot',
      productImage: 'assets/images/product_panci.png',
      price: 'Rp34.000',
      quantity: 'x1',
      totalPrice: 'Rp152.000',
      statusText: 'Dibatalkan',
      statusColor: Color(0xFFE53935),
      categoryStatus: 'Dibatalkan',
    ),
  ];

  final List<String> _banners = [
    'assets/images/banner_promo_green.png',
    'assets/images/banner_promo_blue.png',
  ];

  final List<ProductItem> _products = const [
    ProductItem(
      title: 'Daging Sapi\nWagyu A5 250gr',
      image: 'assets/images/product_wagyu.png',
      price: 'Rp289.900',
      rating: '5.0',
      location: 'Blang Pulo',
      sold: '10 Terjual',
    ),
    ProductItem(
      title: 'Baby Pak Choi\n1 Ikat',
      image: 'assets/images/product_pakchoi.png',
      price: 'Rp7.000',
      rating: '4.7',
      location: 'Batuphat',
      sold: '25 Terjual',
    ),
    ProductItem(
      title: 'Bimoli Spesial\n2L',
      image: 'assets/images/product_bimoli.png',
      price: 'Rp21.000',
      rating: '4.7',
      location: 'Krueng Geukueh',
      sold: '50 Terjual',
    ),
    ProductItem(
      title: 'Panci Stainless\nSteel 18cm',
      image: 'assets/images/product_panci.png',
      price: 'Rp34.000',
      rating: '4.7',
      location: 'Banda Sakti',
      sold: '18 Terjual',
    ),
    ProductItem(
      title: 'Dimsum Keju\nFrozen (4 pcs)',
      image: 'assets/images/product_dimsum.png',
      price: 'Rp20.000',
      rating: '5.0',
      location: 'Blang Pulo',
      sold: '34 Terjual',
      badge: 'Terlaris',
    ),
    ProductItem(
      title: 'Norwegian\nSalmon 500gr',
      image: 'assets/images/product_salmon.png',
      price: 'Rp152.000',
      rating: '5.0',
      location: 'Batuphat',
      sold: '25 Terjual',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _chatItems = [
      const ChatItemData(
        storeName: 'Toko Daging Mas Rusdi',
        username: '@rusdidaging23',
        lastMessage: 'Anda : Boleh, Mas',
        time: '11.16',
        avatar: 'assets/images/avatar_rusdi.png',
        isOnline: true,
        isUnread: false,
        unreadCount: 0,
      ),
      const ChatItemData(
        storeName: 'FreshOasis Market',
        username: '@FreshLohYaa67',
        lastMessage: 'Halo kak! Sayur segar siap kami kirim ya 🌱',
        time: '10.13',
        avatar: 'assets/images/avatar_freshoasis.png',
        isOnline: true,
        isUnread: true,
        unreadCount: 1,
      ),
      const ChatItemData(
        storeName: 'Warung Sembako Lestari',
        username: '@LestariSembako34',
        lastMessage: 'Minyak Bimoli sudah kami packing aman ya kak',
        time: '08.45',
        avatar: 'assets/images/avatar_lestari.png',
        isOnline: false,
        isUnread: false,
        unreadCount: 0,
      ),
      const ChatItemData(
        storeName: 'Toserba Pak Zul',
        username: '@ToserbaPakZul44',
        lastMessage: 'Panci susu ready stock ya kak!',
        time: 'Kemarin',
        avatar: 'assets/images/avatar_pakzul.png',
        isOnline: true,
        isUnread: false,
        unreadCount: 0,
      ),
      const ChatItemData(
        storeName: 'Saji Cepat Frozen',
        username: '@FrozenCepat65',
        lastMessage: 'Dimsum dan bakso ikan sudah dikemas beku kak 🥟',
        time: 'Kemarin',
        avatar: 'assets/images/avatar_sajicepat.png',
        isOnline: false,
        isUnread: false,
        unreadCount: 0,
      ),
      const ChatItemData(
        storeName: 'Dapur Sejahtera Store',
        username: '@dapursejahtera123',
        lastMessage: 'Salmon dan cumi asin fresh siap kirim kak 🐟',
        time: '12 Okt',
        avatar: 'assets/images/avatar_dapursejahtera.png',
        isOnline: false,
        isUnread: false,
        unreadCount: 0,
      ),
    ];
    // Smart animation: changes banner with 1000ms transition every 3.5s
    _bannerTimer = Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      if (mounted) {
        setState(() {
          _currentBannerIndex = (_currentBannerIndex + 1) % _banners.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _chatSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF01A852);
    const searchGold = Color(0xFFE5A84D);

    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.language,
      builder: (context, currentLang, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Background: Jika tab Promo atau Order, gunakan background gradien hijau #9FC89F; jika bukan, MbgBackground
              if (_currentNavIndex == 2 || _currentNavIndex == 3)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF9FC89F),
                          Color(0xFF9FC89F),
                          Color(0xFFCBE2CC),
                          Color(0xFFBAD1BA),
                          Color(0xFFE2EFE3),
                        ],
                        stops: [0.0, 0.25, 0.50, 0.75, 1.0],
                      ),
                    ),
                  ),
                )
              else
                // Background dengan Gradiasi Bulatan Khas MBG (W: 361, H: 365.69)
                Positioned.fill(
                  child: MbgBackground(child: const SizedBox.expand()),
                ),

              // Main View
              Column(
                children: [
                  // Top App Bar Header (Tab Promo, Order & Chat tidak menampilkan top bar putih terpisah)
                  if (_currentNavIndex == 0)
                    SafeArea(bottom: false, child: _buildTopAppBar(brandGreen))
                  else if (_currentNavIndex != 2 && _currentNavIndex != 3 && _currentNavIndex != 4)
                    _buildOtherTopAppBar(_currentNavIndex),

                  // Content View Sesuai Tab Aktif
                  Expanded(child: _buildTabContent(brandGreen, searchGold)),
                ],
              ),

              // Pinned Bottom Navigation Bar dengan Rounded Top & Drop Shadow
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomNavBar(brandGreen),
              ),
            ],
          ),
        );
      },
    );
  }

  // Header Bagian Atas: Rounded Bottom + Drop Shadow (x: 0, y: 4, color: hitam 25%)
  Widget _buildTopAppBar(Color brandGreen) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 10.0,
        bottom: 14.0,
      ),
      child: Row(
        children: [
          // Logo MBG
          Image.asset(
            'assets/images/logo.png',
            height: 38,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),

          // Title & Subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'My Big Grocery',
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF01A852),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                LanguageService.instance.tr('Beranda', 'Home'),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5AB688),
                  height: 1.1,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Notification Bell
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF5AB688),
              size: 24,
            ),
            tooltip: LanguageService.instance.tr('Notifikasi', 'Notifications'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotifikasiScreen(),
                ),
              );
            },
          ),

          // Amba Profile Avatar (Navigasi ke ProfileScreen)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    onLogout: widget.onLogout,
                  ),
                ),
              );
            },
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF01A852), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/images/avatar_amba.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Search Bar: Input Box dengan Stroke #E0AA54 & Tombol Search tanpa stroke
  Widget _buildSearchBar(Color searchGold) {
    return Row(
      children: [
        // Input text field dengan stroke warna #E0AA54
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFE0AA54),
                width: 1.2,
              ), // Stroke warna E0AA54
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
            child: TextField(
              style: const TextStyle(fontSize: 13.5),
              decoration: InputDecoration(
                hintText: LanguageService.instance.tr('Cari Produk', 'Search Product'),
                hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 13.5),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Search Button tanpa stroke
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: searchGold,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search, color: Colors.white, size: 20),
              const SizedBox(width: 5),
              Text(
                LanguageService.instance.tr('Cari', 'Search'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Banner Promo dengan Smart Animation Blur Transition (TANPA drop shadow sesuai request)
  Widget _buildSmartAnimationBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000), // Smart animation 1000ms
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              final double blurValue = (1.0 - animation.value) * 12.0;

              return ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: blurValue.clamp(0.001, 14.0),
                  sigmaY: blurValue.clamp(0.001, 14.0),
                ),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
          );
        },
        child: SizedBox(
          key: ValueKey<int>(_currentBannerIndex),
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 336 / 106,
            child: Image.asset(
              _banners[_currentBannerIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // Kategori Produk Section - Responsif Otomatis Mengikuti Layar HP
  Widget _buildKategoriSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LanguageService.instance.tr('Kategori Produk', 'Product Categories'),
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 14),

        // 5 Icon Kategori Responsif & Proporsional di Semua Ukuran Layar
        LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            // Menghitung gap (~12-16px) dan ukuran kotak (~55-64px) proporsional
            final gap = (availableWidth * 0.038).clamp(11.0, 16.0);
            final boxSize = ((availableWidth - (4 * gap)) / 5).clamp(
              52.0,
              64.0,
            );
            final iconSize = boxSize * 0.525; // Rasio icon 26.26 / 50 = 0.5252
            final radius = boxSize * 0.30; // Rasio radius 15 / 50 = 0.30

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryCard(
                  'assets/images/cat_icon_frozen.png',
                  LanguageService.instance.tr('Sayur & Buah', 'Veg & Fruits'),
                  const Color(0xFF5EC494),
                  boxSize,
                  iconSize,
                  radius,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KategoriSayurScreen(),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  'assets/images/cat_icon_seafood.png',
                  LanguageService.instance.tr('Daging', 'Meat'),
                  const Color(0xFFE8B87C),
                  boxSize,
                  iconSize,
                  radius,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KategoriDagingScreen(),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  'assets/images/cat_icon_sembako.png',
                  LanguageService.instance.tr('Sembako', 'Groceries'),
                  const Color(0xFFB6C874),
                  boxSize,
                  iconSize,
                  radius,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KategoriSembakoScreen(),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  'assets/images/cat_icon_daging.png',
                  LanguageService.instance.tr('Seafood', 'Seafood'),
                  const Color(0xFF5EC494),
                  boxSize,
                  iconSize,
                  radius,
                  scale: 1.3,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KategoriSeafoodScreen(),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  'assets/images/cat_icon_sayur.png',
                  LanguageService.instance.tr('Frozen Food', 'Frozen Food'),
                  const Color(0xFF9AC4E8),
                  boxSize,
                  iconSize,
                  radius,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KategoriFrozenScreen(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    String iconPath,
    String title,
    Color bgColor,
    double boxSize,
    double iconSize,
    double radius, {
    double scale = 1.0,
    VoidCallback? onTap,
  }) {
    final effectiveIconSize = iconSize * scale;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(radius),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              iconPath,
              width: effectiveIconSize,
              height: effectiveIconSize,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontSize: (boxSize * 0.17).clamp(9.5, 11.0),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  // Grid Produk (2 kolom)
  Widget _buildProductGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 12) / 2;

        return Wrap(
          spacing: 12,
          runSpacing: 14,
          children: _products
              .map((p) => _buildProductCard(p, cardWidth))
              .toList(),
        );
      },
    );
  }

  // Card Produk dengan Rounded Rectangle & Drop Shadow (x: 0, y: 4, color: hitam 25%)
  Widget _buildProductCard(ProductItem p, double width) {
    const brandGreen = Color(0xFF01A852);

    return GestureDetector(
      onTap: () {
        final isWagyu = p.title.contains('Wagyu');
        final isPakChoi = p.title.contains('Pak Choi');
        final isBimoli = p.title.contains('Bimoli');
        final isPanci = p.title.contains('Panci');
        final isDimsum = p.title.contains('Dimsum');
        final isSalmon = p.title.contains('Salmon');
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
              productName: p.title,
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
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEAEAEA), width: 1.1),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(13),
              ),
              child: AspectRatio(
                aspectRatio: 157 / 125,
                child: Container(
                  color: const Color(0xFFF9F9F9),
                  child: Image.asset(p.image, fit: BoxFit.contain),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row: Nama Produk (kiri) & Terjual + Badge (kanan)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          p.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            p.sold,
                            style: const TextStyle(
                              fontSize: 9.5,
                              color: Colors.black, // Hitam
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (p.badge != null) ...[
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: brandGreen,
                                  width: 0.6,
                                ),
                              ),
                              child: Text(
                                p.badge!,
                                style: const TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                  color: brandGreen,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Harga (langsung rapat di bawah nama produk)
                  Text(
                    p.price,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: brandGreen,
                    ),
                  ),
                  const SizedBox(height: 3),

                  // Rating & Lokasi dengan Garis Pemisah Abu-abu & Icon Lokasi Baru
                  Row(
                    children: [
                      Text(
                        p.rating,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFB800),
                        size: 11,
                      ),
                      const SizedBox(width: 5),
                      // Garis lurus pemisah abu-abu
                      Container(
                        width: 1.0,
                        height: 9.0,
                        color: const Color(0xFFD1D5DB),
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        'assets/images/icon_lokasi.png',
                        width: 8,
                        height: 13,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          p.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF01A852),
                            fontWeight: FontWeight.w500,
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

  // Top App Bar untuk Tab Keranjang / Promo / Order / Chat Sesuai Mockup Asli Figma
  Widget _buildOtherTopAppBar(int index) {
    String title = 'Keranjang';
    if (index == 2) title = 'Promo';
    if (index == 3) title = 'Order';
    if (index == 4) title = 'Chat';

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 80,
          child: Stack(
            children: [
              // Tombol Back Melingkar Abu-Abu dengan Icon Lengkung Putih di Kiri Atas Sesuai Figma
              Positioned(
                left: 18,
                top: 6,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentNavIndex = 0;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD4DCD4),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/kategori_back_arrow.png',
                      width: 22,
                      height: 18,
                      fit: BoxFit.contain,
                      color: Colors.white,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.undo_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),

              // Judul Hijau Besar Sesuai Figma di Tengah
              Positioned.fill(
                child: Align(
                  alignment: const Alignment(0, 0.25),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF52B788),
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tampilan Konten Sesuai Tab
  Widget _buildTabContent(Color brandGreen, Color searchGold) {
    if (_currentNavIndex == 1) {
      // Tab Keranjang (Belum Melakukan Pesanan / Kosong Sesuai Mockup)
      return const SizedBox.expand();
    } else if (_currentNavIndex == 2) {
      // Tab Promo Sesuai Mockup Figma (Font Baloo Tammudu 2 & Warna Hijau 9FC89F)
      return _buildPromoTabContent();
    } else if (_currentNavIndex == 0) {
      // Tab Beranda
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),

            // Search Bar + Tombol Search dengan Stroke dan Drop Shadow (x:0 y:4 25%)
            _buildSearchBar(searchGold),

            const SizedBox(height: 16),

            // Banner Promo dengan Smart Animation Blur ("change to", durasi 1000 ms) & Drop Shadow (x:0 y:4 25%)
            _buildSmartAnimationBanner(),

            const SizedBox(height: 22),

            // Kategori Produk Section dengan 5 Icon HD Asli & Drop Shadow (x:0 y:4 25%)
            _buildKategoriSection(),

            const SizedBox(height: 18),

            // Grid Produk dengan rounded rectangle & drop shadow (x:0 y:4 25%)
            _buildProductGrid(),

            const SizedBox(height: 90),
          ],
        ),
      );
    } else if (_currentNavIndex == 3) {
      // Tab Order Sesuai Mockup Figma 100%
      return _buildOrderTabContent();
    } else if (_currentNavIndex == 4) {
      // Tab Chat Sesuai Mockup Figma 100%
      return _buildChatTabContent();
    } else {
      return const SizedBox.expand();
    }
  }

  // Konten Tab Order Sesuai Mockup Figma (Font Baloo Tammudu 2 & Warna Hijau 9FC89F)
  Widget _buildOrderTabContent() {
    final filteredOrders = _selectedOrderTabIndex == 0
        ? _orderItems
        : _orderItems
            .where((item) =>
                item.categoryStatus.toLowerCase() ==
                _orderTabs[_selectedOrderTabIndex].toLowerCase())
            .toList();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          const SizedBox(height: 18),

          // Judul "Order" Putih dengan Font Baloo Tammudu 2 & Drop Shadow
          Text(
            'Order',
            style: const TextStyle(
              fontFamily: 'Baloo Tammudu 2',
              fontSize: 64.0,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
              height: 0.95,
              shadows: [
                Shadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 4),
                  blurRadius: 4.0,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Tab Bar Filter (Semua, Dikemas, Dikirim, Selesai, Dibatalkan)
          _buildOrderFilterBar(),

          const SizedBox(height: 12),

          // List Card Pesanan
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 4, bottom: 90),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final item = filteredOrders[index];
                return _buildOrderCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Tab Bar Filter untuk Halaman Order (Bisa digeser kanan-kiri dengan mulus)
  Widget _buildOrderFilterBar() {
    return Column(
      children: [
        SizedBox(
          height: 34,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: List.generate(_orderTabs.length, (index) {
                final isSelected = _selectedOrderTabIndex == index;
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < _orderTabs.length - 1 ? 8.0 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOrderTabIndex = index;
                      });
                    },
                    child: Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE0AA54) : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                            offset: Offset(0, 1.5),
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Text(
                        _orderTabs[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Garis hijau pemisah di bawah tab filter sesuai mockup
        Container(
          width: double.infinity,
          height: 1.0,
          color: const Color(0xFF7C9D7C),
        ),
      ],
    );
  }

  Widget _buildCardDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1.0, color: const Color(0xFFEFEDED)),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Container(height: 1.0, color: const Color(0xFFEFEDED)),
        ),
      ],
    );
  }

  // Card Item Pesanan Sesuai Mockup 100%
  Widget _buildOrderCard(OrderItemData item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
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
          // 1. Header Toko
          Row(
            children: [
              Image.asset(
                'assets/images/icon_order_store.png',
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.storefront_rounded,
                  color: Color(0xFFE0AA54),
                  size: 22,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.storeName,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              if (item.storeAction != null) ...[
                GestureDetector(
                  onTap: () {
                    if (item.storeAction == 'Lihat') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InformasiOrderScreen(),
                        ),
                      );
                    } else if (item.storeAction == 'Nilai') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NilaiPesananScreen(),
                        ),
                      );
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF01A852), width: 1.2),
                    ),
                    child: Text(
                      item.storeAction!,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF01A852),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 8),
          // Garis pemisah terbelah dua sesuai mockup Figma
          _buildCardDivider(),
          const SizedBox(height: 10),

          // 2. Detail Produk: Tinggi 80 disesuaikan batas atas nama & batas bawah harga
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk (Tinggi 80)
              Container(
                width: 90,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF9F9F9),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.productImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Info Nama Produk (Batas Atas) & Harga (Batas Bawah)
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                          height: 1.2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.price,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFFE0AA54),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF4F8EB),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      item.quantity,
                                      style: const TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF65A30D),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (item.productAction != null) ...[
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                if (item.productAction == 'Detail') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RincianPesananScreen(),
                                    ),
                                  );
                                }
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFF01A852), width: 1.2),
                                ),
                                child: Text(
                                  item.productAction!,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF01A852),
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

          const SizedBox(height: 10),
          // Garis pemisah terbelah dua di atas status pengiriman sesuai mockup Figma
          _buildCardDivider(),
          const SizedBox(height: 8),

          // 3. Footer: Estimasi Waktu Pengiriman & Total Harga
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.deliveryAsset != null || item.deliveryIcon != null || item.deliveryTime != null)
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.deliveryAsset != null)
                        Image.asset(
                          item.deliveryAsset!,
                          width: 24,
                          height: 22,
                          fit: BoxFit.contain,
                        )
                      else if (item.deliveryIcon != null)
                        Icon(
                          item.deliveryIcon,
                          color: const Color(0xFFE0AA54),
                          size: 22,
                        ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.deliveryTime != null)
                              Text(
                                item.deliveryTime!,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFE0AA54),
                                ),
                              ),
                            if (item.deliveryNote != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                item.deliveryNote!,
                                style: const TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total harga : ${item.totalPrice}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF01A852),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.statusText,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: item.statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Konten Tab Promo Sesuai Mockup Figma (Font Baloo Tammudu 2 & Warna Hijau 9FC89F)
  Widget _buildPromoTabContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 14),

            // Judul "Promo" Putih dengan Font Baloo Tammudu 2 & Drop Shadow
            Text(
              'Promo',
              style: TextStyle(
                fontFamily: 'Baloo Tammudu 2',
                fontSize: 64.0,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
                height: 0.95,
                shadows: const [
                  Shadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Banner 1: Diskon s.d. 50% (Hijau)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: AspectRatio(
                  aspectRatio: 328 / 106,
                  child: Image.asset(
                    'assets/images/banner_promo_green.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 13),

            // Banner 2: Cashback s.d. 25% (Biru)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: AspectRatio(
                  aspectRatio: 328 / 106,
                  child: Image.asset(
                    'assets/images/banner_promo_blue.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  // Konten Tab Chat Sesuai Mockup Figma Asli (Font Baloo Tammudu 2, Search Gold, Filter "Semua" & "Belum Dibaca", Drop Shadow)
  Widget _buildChatTabContent() {
    final filteredChats = _chatItems.where((chat) {
      if (_selectedChatFilterIndex == 1 && !chat.isUnread) {
        return false;
      }
      if (_chatSearchQuery.isNotEmpty) {
        final query = _chatSearchQuery.toLowerCase();
        return chat.storeName.toLowerCase().contains(query) ||
            chat.username.toLowerCase().contains(query) ||
            chat.lastMessage.toLowerCase().contains(query);
      }
      return true;
    }).toList();

    return Column(
      children: [
        // Rektanggel Header Putih (Meliputi Title "Chat" & Search Bar dengan Rounded Bottom & Drop Shadow Sesuai Mockup)
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.20),
                offset: Offset(0, 4),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 6),

                // Judul "Chat" Hijau Sage dengan Font Baloo Tammudu 2 & Drop Shadow Sesuai Mockup
                const Text(
                  'Chat',
                  style: TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 64.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7DA37D),
                    letterSpacing: -0.5,
                    height: 0.95,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(0, 4),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Search Bar: Input box dengan Stroke #E0AA54 & Tombol Search Gold
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      // Input box "Cari nama toko" dengan border #E0AA54 & drop shadow
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE0AA54),
                              width: 1.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.12),
                                offset: Offset(0, 3),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: _chatSearchController,
                            onChanged: (value) {
                              setState(() {
                                _chatSearchQuery = value;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF334155),
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: 'Cari nama toko',
                              hintStyle: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Tombol Search Gold dengan Icon & Text "Search"
                      Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0AA54),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.20),
                              offset: Offset(0, 4),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 19,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

          // Kategori Filter Tabs: "Semua" & "Belum Dibaca"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tab "Semua"
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedChatFilterIndex = 0;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Semua',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: _selectedChatFilterIndex == 0
                              ? const Color(0xFF6DA06D)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        height: 2.2,
                        width: 48,
                        decoration: BoxDecoration(
                          color: _selectedChatFilterIndex == 0
                              ? const Color(0xFF6DA06D)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab "Belum Dibaca"
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedChatFilterIndex = 1;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Belum Dibaca',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: _selectedChatFilterIndex == 1
                              ? const Color(0xFF6DA06D)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        height: 2.2,
                        width: 84,
                        decoration: BoxDecoration(
                          color: _selectedChatFilterIndex == 1
                              ? const Color(0xFF6DA06D)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Daftar Chat Items dengan White Card + Drop Shadow
          Expanded(
            child: filteredChats.isEmpty
                ? Column(
                    children: [
                      const SizedBox(height: 36),
                      Image.asset(
                        'assets/images/ic_chat_empty.png',
                        width: 74,
                        height: 92,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        _selectedChatFilterIndex == 1
                            ? 'Ups! tidak ada pesan yang belum dibaca'
                            : _chatSearchQuery.trim().isNotEmpty
                                ? 'Ups! tidak ada pesan ditemukan'
                                : 'Ups! belum ada pesan',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF222222),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 4, bottom: 90),
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final item = filteredChats[index];
                      return _buildChatCard(item);
                    },
                  ),
          ),
        ],
      );
  }

  // Card Pesanan Chat Persis Figma (Avatar dengan status online, Nama Toko, Handle, Last Message, Time & Badge)
  Widget _buildChatCard(ChatItemData item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              storeName: item.storeName,
              avatar: item.avatar,
              isUnread: item.isUnread,
              onChatRead: () {
                setState(() {
                  final idx = _chatItems.indexWhere((c) => c.storeName == item.storeName);
                  if (idx != -1) {
                    _chatItems[idx] = ChatItemData(
                      storeName: _chatItems[idx].storeName,
                      username: _chatItems[idx].username,
                      lastMessage: _chatItems[idx].lastMessage,
                      time: _chatItems[idx].time,
                      avatar: _chatItems[idx].avatar,
                      isOnline: _chatItems[idx].isOnline,
                      isUnread: false,
                      unreadCount: 0,
                    );
                  }
                });
              },
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.20),
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar dengan Online Indicator jika Online
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(item.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (item.isOnline)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ADE80),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 10),

          // Informasi Nama Toko, Username, & Pesan Terakhir
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.storeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF689968),
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  item.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8CB38C),
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: item.isUnread ? FontWeight.w600 : FontWeight.w400,
                    color: item.isUnread ? const Color(0xFF334155) : const Color(0xFF64748B),
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Kolom Kanan: Waktu Pesan & Badge Belum Dibaca
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.time,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 6),
              if (item.unreadCount > 0)
                Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6BA06B),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${item.unreadCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                )
              else
                const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    ),
  );
}

  // Bottom Navigation Bar dengan Rounded Top, Drop Shadow, Icon Proporsional & Spacing Harmonis
  Widget _buildBottomNavBar(Color brandGreen) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.18),
            blurRadius: 6,
            offset: Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 14),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _buildNavItem(
              0,
              'assets/images/nav_beranda.png',
              Icons.home_outlined,
              LanguageService.instance.tr('Beranda', 'Home'),
              brandGreen,
            ),
            ValueListenableBuilder<int>(
              valueListenable: CartService.instance.cartCount,
              builder: (context, cartCount, _) {
                return _buildNavItem(
                  1,
                  'assets/images/nav_keranjang.png',
                  Icons.shopping_cart_rounded,
                  LanguageService.instance.tr('Keranjang', 'Cart'),
                  brandGreen,
                  badgeCount: cartCount,
                );
              },
            ),
            _buildNavItem(
              2,
              'assets/images/nav_promo.png',
              Icons.discount_outlined,
              LanguageService.instance.tr('Promo', 'Promo'),
              brandGreen,
            ),
            _buildNavItem(
              3,
              'assets/images/nav_order.png',
              Icons.assignment_outlined,
              LanguageService.instance.tr('Order', 'Orders'),
              brandGreen,
            ),
            _buildNavItem(
              4,
              'assets/images/nav_chat.png',
              Icons.chat_bubble_outline_rounded,
              LanguageService.instance.tr('Chat', 'Chat'),
              brandGreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String assetPath,
    IconData fallbackIcon,
    String label,
    Color brandGreen, {
    int badgeCount = 0,
  }) {
    final isActive = _currentNavIndex == index;
    final color = isActive ? brandGreen : const Color(0xFF8E8E93);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KeranjangScreen()),
            );
            return;
          }
          setState(() {
            _currentNavIndex = index;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  assetPath,
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                  color: color,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(fallbackIcon, color: color, size: 28),
                ),
                if (badgeCount > 0)
                  Positioned(
                    top: -3,
                    right: -7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(minWidth: 16),
                      alignment: Alignment.center,
                      child: Text(
                        badgeCount > 99 ? '99+' : '$badgeCount',
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
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

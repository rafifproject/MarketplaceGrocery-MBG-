import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import 'penjual_notification_screen.dart';
import 'penjual_produk_menu_screen.dart';
import 'penjual_chat_screen.dart';
import 'penjual_profile_screen.dart';
import 'total_pendapatan_screen.dart';
import 'pesanan_masuk_screen.dart';
import 'produk_terlaris_screen.dart';

class PenjualHomeScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const PenjualHomeScreen({super.key, required this.onLogout});

  @override
  State<PenjualHomeScreen> createState() => _PenjualHomeScreenState();
}

class _PenjualHomeScreenState extends State<PenjualHomeScreen> {
  static const Color brandGreen = Color(0xFF01A852);

  int _currentIndex = 0;
  bool _hideBottomNav = false;

  // Mock list of incoming orders
  final List<Map<String, dynamic>> _incomingOrders = [
    {
      'id': 'MBG-2026-8821',
      'customer': 'Budi Santoso',
      'item': 'Daging Sapi Wagyu A5 250gr (2x)',
      'total': 'Rp579.800',
      'time': '10 menit yang lalu',
      'status': 'Perlu Dikonfirmasi',
    },
    {
      'id': 'MBG-2026-8822',
      'customer': 'Siti Aminah',
      'item': 'Daging Ayam Boiler 1 Ekor (1x)',
      'total': 'Rp38.000',
      'time': '25 menit yang lalu',
      'status': 'Siap Dikemas',
    },
    {
      'id': 'MBG-2026-8823',
      'customer': 'Rian Pratama',
      'item': 'Daging Ribeye Steak 200gr (1x)',
      'total': 'Rp115.000',
      'time': '1 jam yang lalu',
      'status': 'Menunggu Kurir',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Full-screen MBG ambient radial glow background
          Positioned.fill(
            child: MbgBackground(child: const SizedBox.expand()),
          ),

          // 2. Main foreground view
          Column(
            children: [
              // Top App Bar / Header (only on Beranda)
              if (_currentIndex == 0) _buildTopHeader(),

              // Main Content Area based on tab
              Expanded(
                child: _buildBody(),
              ),
            ],
          ),

          // 3. Pinned Bottom Navigation Bar with Rounded Top & Drop Shadow (Hidden on full-bleed subpages like Semua Produk)
          if (!_hideBottomNav)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNav(),
            ),
        ],
      ),
    );
  }

  /// Top App Bar matching the design: Full bleed to top status bar, rounded bottom corners & drop shadow
  Widget _buildTopHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.20),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            right: 18.0,
            top: 10.0,
            bottom: 14.0,
          ),
          child: Row(
            children: [
              // Logo MBG Shopping Cart
              Image.asset(
                'assets/images/logo.png',
                height: 38,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.shopping_cart,
                  color: brandGreen,
                  size: 32,
                ),
              ),
              const SizedBox(width: 10),

              // Title & Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'My Big Grocery Seller',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF01A852),
                      height: 1.1,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Beranda',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5AB688),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Profile Avatar with border matching Figma
              GestureDetector(
                onTap: _navigateToProfile,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/images/avatar_seller_figma.png'),
                      fit: BoxFit.contain,
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

  /// Body switcher based on active bottom navigation tab
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildBerandaTab();
      case 1:
        return PenjualNotificationScreen(
          onBack: () {
            setState(() {
              _currentIndex = 0;
            });
          },
        );
      case 2:
        return PenjualProdukMenuScreen(
          onBack: () {
            setState(() {
              _hideBottomNav = false;
              _currentIndex = 0;
            });
          },
          onToggleBottomNav: (show) {
            setState(() {
              _hideBottomNav = !show;
            });
          },
        );
      case 3:
        return PenjualChatScreen(
          onBack: () {
            setState(() {
              _currentIndex = 0;
            });
          },
        );
      default:
        return _buildBerandaTab();
    }
  }

  /// Beranda Tab - Responsive cards maintaining exact Figma aspect ratio (326 / 121)
  Widget _buildBerandaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(17, 48, 17, 95),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Total Pendapatan Card (p : l = 326 : 121)
          _buildTotalPendapatanCard(),
          const SizedBox(height: 24),

          // 2. Pesanan Masuk Card (p : l = 326 : 121)
          _buildPesananMasukCard(),
          const SizedBox(height: 24),

          // 3. Produk Terlaris Card (p : l = 326 : 121)
          _buildProdukTerlarisCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Banner 1: Total Pendapatan (Yellow/Amber Card) - Aspect Ratio 326 / 121 Presisi Figma
  Widget _buildTotalPendapatanCard() {
    return AspectRatio(
      aspectRatio: 326 / 121,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardW = constraints.maxWidth;
          final cardH = constraints.maxHeight;
          final scale = cardW / 326.0;

          return InkWell(
            onTap: _showTotalPendapatanSheet,
            borderRadius: BorderRadius.circular(18 * scale),
            child: Container(
              width: cardW,
              height: cardH,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18 * scale),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE8C27E),
                  Color(0xFFD6AE68),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.22),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Left Text & Button
                Padding(
                  padding: EdgeInsets.only(left: 18 * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 30 * scale,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF3E270A),
                              height: 1.0,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(width: 12 * scale),
                          // "Lihat" Pill Button
                          InkWell(
                            onTap: _showTotalPendapatanSheet,
                            borderRadius: BorderRadius.circular(12 * scale),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16 * scale,
                                vertical: 4.5 * scale,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFBE9C5F),
                                borderRadius: BorderRadius.circular(12 * scale),
                              ),
                              child: Text(
                                'Lihat',
                                style: TextStyle(
                                  color: const Color(0xFF3E270A),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11.5 * scale,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5 * scale),
                      Text(
                        'Pendapatan',
                        style: TextStyle(
                          fontSize: 30 * scale,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF3E270A),
                          height: 1.0,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Money Bag Image (Slightly Overflowing Top Knot Like Figma)
                Positioned(
                  right: 6 * scale,
                  top: -16 * scale,
                  bottom: -4 * scale,
                  child: GestureDetector(
                    onTap: _showTotalPendapatanSheet,
                    child: Image.asset(
                      'assets/images/money_bag.png',
                      height: 140 * scale,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          );
        },
      ),
    );
  }

  /// Banner 2: Pesanan Masuk (Green Card) - Aspect Ratio 326 / 121 Presisi Figma
  Widget _buildPesananMasukCard() {
    return AspectRatio(
      aspectRatio: 326 / 121,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardW = constraints.maxWidth;
          final cardH = constraints.maxHeight;
          final scale = cardW / 326.0;

          return Container(
            width: cardW,
            height: cardH,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18 * scale),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFB2D5B4),
                  Color(0xFF96C398),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.22),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Left Cardboard Delivery Box Image
                Positioned(
                  left: -4 * scale,
                  top: 4 * scale,
                  bottom: 4 * scale,
                  child: GestureDetector(
                    onTap: _showPesananMasukSheet,
                    child: Image.asset(
                      'assets/images/box_delivery.png',
                      height: 118 * scale,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Right Text & Actions
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 18 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Pesanan',
                          style: TextStyle(
                            fontSize: 29 * scale,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1B4E1F),
                            height: 1.0,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 2 * scale),
                        Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 29 * scale,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1B4E1F),
                            height: 1.0,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 6 * scale),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // "Lihat" Pill Button
                            InkWell(
                              onTap: _showPesananMasukSheet,
                              borderRadius: BorderRadius.circular(12 * scale),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16 * scale,
                                  vertical: 4 * scale,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF61CA63),
                                  borderRadius: BorderRadius.circular(12 * scale),
                                ),
                                child: Text(
                                  'Lihat',
                                  style: TextStyle(
                                    color: const Color(0xFF1B4E1F),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 11.5 * scale,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10 * scale),
                            Text(
                              'Total  : ${_incomingOrders.length}',
                              style: TextStyle(
                                color: const Color(0xFF1B4E1F),
                                fontWeight: FontWeight.w900,
                                fontSize: 15 * scale,
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
          );
        },
      ),
    );
  }

  /// Banner 3: Produk Terlaris (Soft Sky Blue Card) - Aspect Ratio 326 / 121 Presisi Figma
  Widget _buildProdukTerlarisCard() {
    return AspectRatio(
      aspectRatio: 326 / 121,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardW = constraints.maxWidth;
          final cardH = constraints.maxHeight;
          final scale = cardW / 326.0;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProdukTerlarisScreen(),
                ),
              );
            },
            child: Container(
              width: cardW,
              height: cardH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18 * scale),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFB7E3F1),
                    Color(0xFF8EBAD5),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.22),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Left Text: "Produk Terlaris"
                  Padding(
                    padding: EdgeInsets.only(left: 18 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Produk',
                          style: TextStyle(
                            fontSize: 30 * scale,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF122858),
                            height: 1.05,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          'Terlaris',
                          style: TextStyle(
                            fontSize: 30 * scale,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF122858),
                            height: 1.05,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Wire Basket Image overflowing slightly above the card top edge
                  Positioned(
                    right: 4 * scale,
                    top: -22 * scale,
                    bottom: -4 * scale,
                    child: Image.asset(
                      'assets/images/basket_terlaris.png',
                      height: 148 * scale,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Bottom Navigation Bar with 4 items matching pembeli_mbg pattern exactly
  Widget _buildBottomNav() {
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
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 1. Beranda (Home)
            _buildNavItem(
              index: 0,
              iconWidget: Icon(
                Icons.home_outlined,
                size: 38,
                color: _currentIndex == 0 ? brandGreen : const Color(0xFF8E8E93),
              ),
              tooltip: 'Beranda',
            ),

            // 2. Notifikasi (Bell)
            _buildNavItem(
              index: 1,
              iconWidget: Icon(
                Icons.notifications_none_outlined,
                size: 36,
                color: _currentIndex == 1 ? brandGreen : const Color(0xFF8E8E93),
              ),
              tooltip: 'Notifikasi',
            ),

            // 3. Kelola Produk (Box Icon from asset)
            _buildNavItem(
              index: 2,
              iconWidget: Image.asset(
                'assets/images/nav_box.png',
                width: 35,
                height: 35,
                color: _currentIndex == 2 ? brandGreen : const Color(0xFF8E8E93),
                errorBuilder: (_, __, ___) => Icon(
                  Icons.inventory_2_outlined,
                  size: 35,
                  color: _currentIndex == 2 ? brandGreen : const Color(0xFF8E8E93),
                ),
              ),
              tooltip: 'Produk',
            ),

            // 4. Chat (Speech bubble with lines from Figma)
            _buildNavItem(
              index: 3,
              iconWidget: Image.asset(
                'assets/images/nav_chat.png',
                width: 35,
                height: 33,
                color: _currentIndex == 3 ? brandGreen : const Color(0xFF8E8E93),
                errorBuilder: (_, __, ___) => Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 35,
                  color: _currentIndex == 3 ? brandGreen : const Color(0xFF8E8E93),
                ),
              ),
              tooltip: 'Pesan',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required Widget iconWidget,
    required String tooltip,
  }) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
          _hideBottomNav = false;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: AnimatedScale(
          scale: isSelected ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 180),
          child: iconWidget,
        ),
      ),
    );
  }

  // --- SECONDARY TABS ---





  // --- MODAL BOTTOM SHEETS FOR INTERACTIVE CARDS ---

  /// Navigate to Total Pendapatan Screen
  void _showTotalPendapatanSheet() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TotalPendapatanScreen(),
      ),
    );
  }

  /// Navigate to full Pesanan Masuk Page
  void _showPesananMasukSheet() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PesananMasukScreen(),
      ),
    );
  }


  /// Navigasi ke Halaman Profil Penjual
  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PenjualProfileScreen(
          onLogout: widget.onLogout,
        ),
      ),
    );
  }


}

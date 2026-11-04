import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../services/cart_service.dart';
import 'pembeli_home_screen.dart';
import 'chat_detail_screen.dart';
import 'konfirmasi_pesanan_screen.dart';
import 'informasi_order_screen.dart';
import 'rincian_pesanan_screen.dart';
import 'nilai_pesanan_screen.dart';

class KeranjangScreen extends StatefulWidget {
  final int initialNavIndex;

  const KeranjangScreen({super.key, this.initialNavIndex = 1});

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  late int _currentNavIndex;
  int _selectedOrderTabIndex = 0;
  int _selectedChatFilterIndex = 0; // 0: Semua, 1: Belum Dibaca
  final TextEditingController _chatSearchController = TextEditingController();
  String _chatSearchQuery = '';
  late List<ChatItemData> _chatItems;

  // State Keranjang Belanja
  bool _hasItem = false;
  int _cartQuantity = 0;
  bool _isSelected = false;

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

  @override
  void initState() {
    super.initState();
    _currentNavIndex = widget.initialNavIndex;
    _syncCartFromService();
    CartService.instance.cartCount.addListener(_onCartCountChanged);
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
  }

  void _syncCartFromService() {
    final count = CartService.instance.count;
    _cartQuantity = count;
    _hasItem = count > 0;
    if (!_hasItem) {
      _isSelected = false;
    }
  }

  void _onCartCountChanged() {
    if (mounted) {
      setState(() {
        _syncCartFromService();
      });
    }
  }

  @override
  void dispose() {
    CartService.instance.cartCount.removeListener(_onCartCountChanged);
    _chatSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF12B76A);

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
            // Background Gradient Khas MBG
            Positioned.fill(
              child: MbgBackground(child: const SizedBox.expand()),
            ),

          // Main View Layout
          Column(
            children: [
              // Top App Bar Rectangle Presisi Figma (Hanya jika bukan Promo, bukan Order, dan bukan Chat)
              if (_currentNavIndex != 2 && _currentNavIndex != 3 && _currentNavIndex != 4)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
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
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    _currentNavIndex = 0;
                                  });
                                }
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
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.undo_rounded,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                ),
                              ),
                            ),
                          ),

                          // Judul Keranjang Hijau Besar Sesuai Figma di Tengah
                          Positioned.fill(
                            child: Align(
                              alignment: const Alignment(0, 0.25),
                              child: Text(
                                _getTitleForIndex(_currentNavIndex),
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
                ),

              // Area Tengah
              Expanded(child: _buildBodyForIndex(_currentNavIndex)),
            ],
          ),

          // Pinned Bottom Section Presisi (Checkout Bar + Bottom Navigation Bar)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bottom Checkout Bar (Hanya muncul di Tab Keranjang jika ada produk)
                if (_currentNavIndex == 1 && _hasItem)
                  _buildBottomCheckoutBar(),
                // Pinned Bottom Navigation Bar dengan Rounded Top & Drop Shadow
                _buildBottomNavBar(brandGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Beranda';
      case 1:
        return 'Keranjang';
      case 2:
        return 'Promo';
      case 3:
        return 'Order';
      case 4:
        return 'Chat';
      default:
        return 'Keranjang';
    }
  }

  Widget _buildBodyForIndex(int index) {
    if (index == 1) {
      return _buildKeranjangBody();
    } else if (index == 2) {
      return _buildPromoBody();
    } else if (index == 3) {
      return _buildOrderBody();
    } else if (index == 4) {
      return _buildChatBody();
    }
    return Center(
      child: Text(
        'Halaman ${_getTitleForIndex(index)}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }

  // Format angka ke format mata uang Rupiah
  String _formatRupiah(int price) {
    final priceStr = price.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < priceStr.length; i++) {
      if (i > 0 && (priceStr.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(priceStr[i]);
    }
    return 'Rp${buffer.toString()}';
  }

  // Konten Utama Tab Keranjang (Sesuai Desain Figma Gambar 1 & 3)
  Widget _buildKeranjangBody() {
    if (!_hasItem) {
      return _buildEmptyCart();
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildStoreCard(),
          const SizedBox(height: 180),
        ],
      ),
    );
  }

  // Card Toko & Item Produk Presisi Mockup Figma
  Widget _buildStoreCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Toko & Kotak Checkbox
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
              const Expanded(
                child: Text(
                  'Toko Daging Mas Rusdi',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              _buildCheckbox(
                isSelected: _isSelected,
                onTap: () {
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 8),
          // Garis Pemisah Halus
          Container(
            width: double.infinity,
            height: 1.0,
            color: const Color(0xFFF1F5F9),
          ),
          const SizedBox(height: 12),

          // 2. Baris Produk Wagyu A5
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk
              Container(
                width: 84,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF8FAFC),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/product_wagyu.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/detail_wagyu.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Detail Nama Produk, Harga, & Stepper Pengurang/Penambah
              Expanded(
                child: SizedBox(
                  height: 72,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daging Sapi Wagyu A5 250gr',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                          height: 1.2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Rp289.900',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFC27803),
                            ),
                          ),
                          _buildStepper(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Stepper Bulat Hijau Pengurang (-) dan Penambah (+)
  Widget _buildStepper() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Minus
        GestureDetector(
          onTap: _onMinusTapped,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: Color(0xFF00B359),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.remove,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$_cartQuantity',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
        // Tombol Plus
        GestureDetector(
          onTap: _onPlusTapped,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: Color(0xFF00B359),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  // Aksi Tombol Minus (-)
  Future<void> _onMinusTapped() async {
    if (_cartQuantity > 1) {
      setState(() {
        _cartQuantity--;
        CartService.instance.setCount(_cartQuantity);
      });
    } else if (_cartQuantity == 1) {
      // Ubah angka counter ke 0 terlebih dahulu sesuai tampilan background Gambar 2
      setState(() {
        _cartQuantity = 0;
      });

      // Tampilkan popup konfirmasi penghapusan produk persis Gambar 2
      final shouldDelete = await _showDeleteConfirmationDialog();

      if (shouldDelete == true) {
        setState(() {
          _hasItem = false;
          _cartQuantity = 0;
          _isSelected = false;
          CartService.instance.clearCart();
        });
      } else {
        // Jika batal / klik Tidak, kembalikan quantity ke 1
        setState(() {
          _cartQuantity = 1;
          CartService.instance.setCount(1);
        });
      }
    }
  }

  // Aksi Tombol Plus (+)
  void _onPlusTapped() {
    setState(() {
      _cartQuantity++;
      CartService.instance.setCount(_cartQuantity);
    });
  }

  // Modal Dialog Konfirmasi Hapus Produk Persis Gambar 2
  Future<bool?> _showDeleteConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x66000000),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 48),
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 22, 20, 18),
                child: Text(
                  'Yakin ingin menghapus produk ini?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFE2E8F0),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    // Tombol Ya (Merah)
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(dialogContext, true),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                        ),
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          child: const Text(
                            'Ya',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFF3030),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Garis Pemisah Vertikal
                    Container(
                      width: 1,
                      color: const Color(0xFFE2E8F0),
                    ),
                    // Tombol Tidak (Abu-Abu)
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(dialogContext, false),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(14),
                        ),
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          child: const Text(
                            'Tidak',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Komponen Kotak Checkbox (Kotak Tak Berwarna -> Berwarna Hijau) Sesuai Figma
  Widget _buildCheckbox({
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 19,
        height: 19,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00B359) : Colors.transparent,
          borderRadius: BorderRadius.circular(2.5),
          border: Border.all(
            color: const Color(0xFF1E293B),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // Bottom Checkout Bar (Di Atas Bottom Navigation Bar Sesuai Gambar 1 & 3)
  Widget _buildBottomCheckoutBar() {
    final totalPrice = _isSelected ? (289900 * _cartQuantity) : 0;
    final formattedPrice = totalPrice == 0 ? 'Rp0' : _formatRupiah(totalPrice);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            offset: Offset(0, -2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Kolom Kiri: Checkbox + Semua + (Estimasi Pengiriman Motor jika terpilih)
          GestureDetector(
            onTap: () {
              setState(() {
                _isSelected = !_isSelected;
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCheckbox(
                      isSelected: _isSelected,
                      onTap: () {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Semua',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                if (_isSelected) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/icon_motor_orange.png',
                        width: 18,
                        height: 16,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.delivery_dining_rounded,
                          color: Color(0xFFE0AA54),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '15–30 Min',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE0AA54),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          const Spacer(),

          // Total Harga Sesuai Kalkulasi Dinamis
          Text(
            formattedPrice,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),

          const SizedBox(width: 14),

          // Tombol Pesan Hijau
          GestureDetector(
            onTap: () {
              if (!_isSelected) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pilih produk terlebih dahulu untuk checkout'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KonfirmasiPesananScreen(
                    initialQuantity: _cartQuantity,
                  ),
                ),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF00B359),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Pesan',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tampilan ketika keranjang kosong
  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/grocery_basket.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Keranjang Anda Kosong',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Yuk pilih dan masukkan produk kebutuhan harianmu ke keranjang!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _currentNavIndex = 0;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B359),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Mulai Belanja',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Konten Tab Order Sesuai Mockup Figma (Font Baloo Tammudu 2 & Warna Hijau 9FC89F)
  Widget _buildOrderBody() {
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
  Widget _buildPromoBody() {
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
  Widget _buildChatBody() {
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

  // Bottom Navigation Bar Presisi Figma (Icon Otomatis Hijau Sesuai yang Diklik)
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
              'Beranda',
              brandGreen,
            ),
            ValueListenableBuilder<int>(
              valueListenable: CartService.instance.cartCount,
              builder: (context, cartCount, _) {
                return _buildNavItem(
                  1,
                  'assets/images/nav_keranjang.png',
                  Icons.shopping_cart_rounded,
                  'Keranjang',
                  brandGreen,
                  badgeCount: _currentNavIndex == 1 ? 0 : cartCount,
                );
              },
            ),
            _buildNavItem(
              2,
              'assets/images/nav_promo.png',
              Icons.discount_outlined,
              'Promo',
              brandGreen,
            ),
            _buildNavItem(
              3,
              'assets/images/nav_order.png',
              Icons.assignment_outlined,
              'Order',
              brandGreen,
            ),
            _buildNavItem(
              4,
              'assets/images/nav_chat.png',
              Icons.chat_bubble_outline_rounded,
              'Chat',
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
          if (index == 0 && Navigator.canPop(context)) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else {
            setState(() {
              _currentNavIndex = index;
            });
          }
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
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      alignment: Alignment.center,
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
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

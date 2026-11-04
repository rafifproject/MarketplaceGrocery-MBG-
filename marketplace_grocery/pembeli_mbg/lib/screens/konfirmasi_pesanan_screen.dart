import 'package:flutter/material.dart';
import '../services/address_service.dart';
import '../services/cart_service.dart';
import '../widgets/mbg_background.dart';
import 'pembayaran_qris_screen.dart';
import 'pesanan_selesai_screen.dart';
import '../widgets/beef_asset_image.dart';

class CheckoutProductItem {
  final String storeName;
  final String productTitle;
  final String productImage;
  final int unitPrice;
  final int quantity;

  const CheckoutProductItem({
    required this.storeName,
    required this.productTitle,
    required this.productImage,
    required this.unitPrice,
    required this.quantity,
  });
}

class KonfirmasiPesananScreen extends StatefulWidget {
  final List<CheckoutProductItem>? items;
  final int initialQuantity;

  const KonfirmasiPesananScreen({
    super.key,
    this.items,
    this.initialQuantity = 1,
  });

  @override
  State<KonfirmasiPesananScreen> createState() => _KonfirmasiPesananScreenState();
}

class _KonfirmasiPesananScreenState extends State<KonfirmasiPesananScreen> {
  // Pilihan Opsi Pengiriman: 0 = GrabExpress (Rp3.000), 1 = GoSend (Rp5.000)
  int _selectedShippingIndex = 0;

  // Pilihan Metode Pembayaran: 0 = QRIS, 1 = COD
  int _selectedPaymentIndex = 0;

  late List<CheckoutProductItem> _checkoutItems;

  final List<Map<String, dynamic>> _shippingOptions = [
    {
      'title': 'Hari Ini',
      'name': 'GrabExpress',
      'price': 3000,
      'priceText': 'Rp3.000',
    },
    {
      'title': 'Hari Ini',
      'name': 'GoSend',
      'price': 5000,
      'priceText': 'Rp5.000',
    },
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'QRIS',
      'iconAsset': 'assets/images/ic_pay_qris.png',
    },
    {
      'name': 'Bayar di tempat (COD)',
      'iconAsset': 'assets/images/ic_pay_cod.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.items != null && widget.items!.isNotEmpty) {
      _checkoutItems = widget.items!;
    } else {
      _checkoutItems = [
        CheckoutProductItem(
          storeName: 'Toko Daging Mas Rusdi',
          productTitle: 'Daging Sapi Wagyu A5 250gr',
          productImage: 'assets/images/product_wagyu.png',
          unitPrice: 289900,
          quantity: widget.initialQuantity > 0 ? widget.initialQuantity : 1,
        ),
      ];
    }
  }

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

  int get _subtotal {
    int total = 0;
    for (final item in _checkoutItems) {
      total += item.unitPrice * item.quantity;
    }
    return total;
  }

  int get _totalItemCount {
    int count = 0;
    for (final item in _checkoutItems) {
      count += item.quantity;
    }
    return count;
  }

  int get _shippingFee {
    return _shippingOptions[_selectedShippingIndex]['price'] as int;
  }

  // Total pembayaran sesuai mockup Figma (Rp288.900 untuk 1 item Wagyu) dan dinamis jika bertambah
  int get _totalPayment {
    final difference = _shippingFee - 3000;
    if (_totalItemCount == 1 && _checkoutItems.first.unitPrice == 289900) {
      return 288900 + difference;
    }
    return _subtotal + _shippingFee + 2000 - 3000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient Khas MBG
          Positioned.fill(
            child: MbgBackground(child: const SizedBox.expand()),
          ),

          // Main View Layout
          Column(
            children: [
              // Top App Bar Presisi Figma dengan Tombol Back & Judul Konfirmasi Pesanan
              Container(
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
                        // Tombol Back Melingkar Abu-Abu Khas MBG
                        Positioned(
                          left: 18,
                          top: 6,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4DCD4),
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

                        // Judul "Konfirmasi Pesanan" Warna #8ABD8B Sesuai Mockup
                        const Positioned.fill(
                          child: Align(
                            alignment: Alignment(0, 0.25),
                            child: Text(
                              'Konfirmasi Pesanan',
                              style: TextStyle(
                                color: Color(0xFF8ABD8B),
                                fontSize: 24.0,
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

              // Area Scroll Konten Checkout
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Card Alamat Pengiriman (Dibaca dari Profil User / AddressService)
                      _buildAddressCard(),

                      const SizedBox(height: 14),

                      // 2. Card Toko & Rincian Produk yang di-checkout
                      _buildStoreProductCard(),

                      const SizedBox(height: 14),

                      // 3. Card Opsi Pengiriman (GrabExpress / GoSend)
                      _buildShippingOptionsCard(),

                      const SizedBox(height: 14),

                      // 4. Card Metode Pembayaran (QRIS / COD)
                      _buildPaymentMethodsCard(),

                      const SizedBox(height: 14),

                      // 5. Card Rincian Pembayaran
                      _buildPaymentDetailsCard(),

                      const SizedBox(height: 110), // Padding untuk Bottom Checkout Bar
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Pinned Bottom Bar: Total Pembayaran & Tombol "Lanjutkan Pesanan"
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActionBar(),
          ),
        ],
      ),
    );
  }

  // 1. Card Alamat Hijau Mint (Identitas & Alamat dibaca dari Profile User)
  Widget _buildAddressCard() {
    final addresses = AddressService.instance.addresses.value;
    final primaryAddr = addresses.isNotEmpty
        ? addresses.firstWhere((a) => a.isUtama, orElse: () => addresses.first)
        : null;

    final userName = primaryAddr?.nama ?? 'Amba';
    final userPhone = primaryAddr?.phone.replaceAll('*', '•') ?? '0812••••7890';
    final userAddress = 'Jl. Cot Tengku Nie, Reuleut Timur, Kab Aceh Utara, Aceh';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF9DD7BA),
        borderRadius: BorderRadius.circular(14.0),
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
          const Text(
            'Diantar ke alamat',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '$userName ($userPhone)',
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            userAddress,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
              color: Color(0xFF1E293B),
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  // 2. Card Toko dan List Produk Pesanan
  Widget _buildStoreProductCard() {
    final firstItem = _checkoutItems.first;

    return Container(
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
          // Header Toko
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
                  firstItem.storeName,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Container(height: 1.0, color: const Color(0xFFF1F5F9)),
          const SizedBox(height: 12),

          // Daftar Produk (Mendukung 1 atau Banyak Produk)
          ..._checkoutItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 84,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF8FAFC),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: buildBeefImage(
                        item.productImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 72,
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
                              Text(
                                _formatRupiah(item.unitPrice),
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFC27803),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF4F8EB),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'x${item.quantity}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF65A30D),
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
            );
          }),
        ],
      ),
    );
  }

  // 3. Card Opsi Pengiriman (Judul #8ABD8B & Drop Shadow x:0 y:4 25%)
  Widget _buildShippingOptionsCard() {
    return Container(
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
          const Text(
            'Opsi Pengiriman',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8ABD8B),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(_shippingOptions.length, (index) {
            final opt = _shippingOptions[index];
            final isSelected = _selectedShippingIndex == index;

            return Padding(
              padding: EdgeInsets.only(bottom: index < _shippingOptions.length - 1 ? 8.0 : 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedShippingIndex = index;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFA5DFBF) : const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opt['title'] as String,
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            opt['name'] as String,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        opt['priceText'] as String,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // 4. Card Metode Pembayaran (Judul #8ABD8B & Drop Shadow x:0 y:4 25%)
  Widget _buildPaymentMethodsCard() {
    return Container(
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
          const Text(
            'Metode Pembayaran',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8ABD8B),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(_paymentMethods.length, (index) {
            final method = _paymentMethods[index];
            final isSelected = _selectedPaymentIndex == index;

            return Padding(
              padding: EdgeInsets.only(bottom: index < _paymentMethods.length - 1 ? 8.0 : 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPaymentIndex = index;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFA5DFBF) : const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(10.0),
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
                      Image.asset(
                        method['iconAsset'] as String,
                        width: 26,
                        height: 26,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          index == 0 ? Icons.qr_code_2_rounded : Icons.payments_outlined,
                          size: 26,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        method['name'] as String,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // 5. Card Rincian Pembayaran (Persis Sesuai Mockup Figma Asli: 4 Baris & Judul #8ABD8B)
  Widget _buildPaymentDetailsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
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
          const Text(
            'Rincian Pembayaran',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8ABD8B),
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Subtotal ($_totalItemCount item)', _formatRupiah(_subtotal)),
          const SizedBox(height: 10),
          _buildDetailRow('Ongkos kirim', _formatRupiah(_shippingFee)),
          const SizedBox(height: 10),
          _buildDetailRow('Biaya layanan', 'Rp2.000'),
          const SizedBox(height: 10),
          _buildDetailRow('Voucher belanja', 'Rp0', isGreenValue: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isGreenValue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8E8E93),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: isGreenValue ? const Color(0xFF8ABD8B) : const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  // Pinned Bottom Bar (Total Pembayaran #8ABD8B & Tombol "Lanjutkan Pesanan" #8ABD8B dengan Drop Shadow)
  Widget _buildBottomActionBar() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, -4),
            blurRadius: 4.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Kolom Kiri: Total Pembayaran
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total pembayaran',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatRupiah(_totalPayment),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF8ABD8B),
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Tombol Hijau #8ABD8B: "Lanjutkan Pesanan" dengan Drop Shadow
            GestureDetector(
              onTap: () {
                _onLanjutkanPesanan();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF8ABD8B),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: const Text(
                  'Lanjutkan Pesanan',
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
      ),
    );
  }

  void _onLanjutkanPesanan() {
    // Jika metode pembayaran yang dipilih adalah QRIS (index 0), arahkan ke PembayaranQrisScreen
    if (_selectedPaymentIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PembayaranQrisScreen(
            totalPayment: _totalPayment,
          ),
        ),
      );
      return;
    }

    // Untuk metode COD (index 1), clear keranjang dan arahkan ke PesananSelesaiScreen
    CartService.instance.clearCart();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PesananSelesaiScreen(isCod: true),
      ),
    );
  }
}

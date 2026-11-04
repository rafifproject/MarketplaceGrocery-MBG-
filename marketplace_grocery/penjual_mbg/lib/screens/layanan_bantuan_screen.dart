import 'package:flutter/material.dart';

class LayananBantuanScreen extends StatefulWidget {
  const LayananBantuanScreen({super.key});

  @override
  State<LayananBantuanScreen> createState() => _LayananBantuanScreenState();
}

class _LayananBantuanScreenState extends State<LayananBantuanScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _expandedFaqIndex;

  // FAQ items matching Figma Screen 2 exactly
  final List<Map<String, String>> _allFaqs = [
    {
      'category': 'Masalah Pesanan Masuk',
      'question': 'Bagaimana cara memproses atau menerima pesanan baru dari pembeli?',
      'answer':
          'Buka tab Pesanan di aplikasi Penjual, pilih pesanan yang baru masuk, pastikan ketersediaan stok produk Anda, lalu klik "Terima Pesanan" dan segera lakukan pengemasan sebelum kurir menjemput.',
    },
    {
      'category': 'Keuangan dan Saldo',
      'question': 'Kapan saldo hasil penjualan masuk dan bagaimana cara melakukan tarik dana',
      'answer':
          'Saldo hasil penjualan akan otomatis masuk ke Saldo Toko maksimal 1x24 jam setelah pembeli mengonfirmasi penerimaan barang. Penarikan dana dapat dilakukan kapan saja melalui menu Keuangan & Pembayaran ke rekening bank atau e-wallet Anda.',
    },
    {
      'category': 'Produk dan Stok',
      'question': 'Bagaimana cara memperbarui harga atau stok produk daging/sembako yang habis?',
      'answer':
          'Masuk ke halaman Beranda Toko atau Manajemen Produk, cari produk yang ingin disesuaikan, klik tombol "Tambah Stok", lalu simpan perubahan. Stok di etalase pembeli akan langsung terupdate seketika.',
    },
    {
      'category': 'Kendala Pengiriman',
      'question': 'Apa yang harus dilakukan jika kurir belum datang mengambil pesanan yang sudah dikemas?',
      'answer':
          'Jika kurir belum tiba dalam 30 menit setelah status pesanan diubah ke "Siap Dikirim", gunakan fitur "Lacak / Hubungi Kurir" di detail pesanan atau hubungi CS MBG untuk penugasan kurir cadangan.',
    },
  ];

  List<Map<String, String>> get _filteredFaqs {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _allFaqs;
    return _allFaqs.where((faq) {
      final q = faq['question']!.toLowerCase();
      final c = faq['category']!.toLowerCase();
      return q.contains(query) || c.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showActionFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF00AA5B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.04, 0.70, 1.0],
            colors: [
              Color(0xFF9FC89F), // 4% in Figma #9FC89F
              Color(0xFFEBF6EE), // soft transition
              Color(0xFFFFFFFF), // 100% in Figma #FFFFFF
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header with curved back button & Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    // Circular back button with curved arrow icon matching user asset
                    GestureDetector(
                      key: const Key('btn_back'),
                      onTap: () => Navigator.pop(context),
                      behavior: HitTestBehavior.opaque,
                      child: Image.asset(
                        'assets/images/btn_back_curved_green.png',
                        width: 38,
                        height: 38,
                        errorBuilder: (_, __, ___) => Container(
                          width: 38,
                          height: 38,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD4E7D6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.reply,
                            color: Color(0xFF00AA5B),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Layanan dan Bantuan',
                      style: TextStyle(
                        fontFamily: 'Baloo Tammudu 2',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Greeting Headline
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Halo! Ada yang bisa kami bantu?',
                  style: TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 3. Search Bar (Input + Search Button)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    // Input Text Field
                    Expanded(
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF00AA5B), width: 1.2),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.08),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          style: const TextStyle(fontSize: 13.5, color: Color(0xFF1E2022)),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari masalah kamu',
                            hintStyle: TextStyle(
                              fontSize: 13.5,
                              color: Color(0xFF9E9E9E),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Search Button
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8ABF93),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.search, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 4. Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section: Topik/Pertanyaan populer
                      const Text(
                        'Topik/Pertanyaan populer',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2022),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // FAQ White Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.10),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            children: [
                              for (int i = 0; i < _filteredFaqs.length; i++) ...[
                                _buildFaqItem(i, _filteredFaqs[i]),
                                if (i < _filteredFaqs.length - 1)
                                  const Divider(height: 1, color: Color(0xFFE5E5E5)),
                              ],
                              if (_filteredFaqs.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: Text(
                                    'Topik tidak ditemukan. Coba kata kunci lain atau hubungi CS kami di bawah.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13, color: Colors.grey),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Section: Opsi bantuan lainnya
                      const Text(
                        'Opsi bantuan lainnya',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2022),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Button 1: Hubungi Via WhatsApp
                      _buildContactButton(
                        title: 'Hubungi Via WhatsApp',
                        onTap: () {
                          _showActionFeedback('Membuka percakapan WhatsApp Customer Care MBG...');
                        },
                      ),
                      const SizedBox(height: 12),

                      // Button 2: Kirim email ke mybiggrocery54@gmail.com
                      _buildContactButton(
                        title: 'Kirim email ke mybiggrocery54@gmail.com',
                        onTap: () {
                          _showActionFeedback('Membuka aplikasi email ke mybiggrocery54@gmail.com...');
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(int index, Map<String, String> item) {
    final isExpanded = _expandedFaqIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _expandedFaqIndex = isExpanded ? null : index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category label
            Text(
              item['category'] ?? '',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8E8E93),
              ),
            ),
            const SizedBox(height: 4),

            // Question text
            Text(
              item['question'] ?? '',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E2022),
                height: 1.3,
              ),
            ),

            // Expanded answer
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAF7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD3E7D5)),
                ),
                child: Text(
                  item['answer'] ?? '',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF2C4A2E),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFB5D7BA),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              offset: Offset(0, 3),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E2022),
            letterSpacing: -0.1,
          ),
        ),
      ),
    );
  }
}

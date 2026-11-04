import 'package:flutter/material.dart';
import '../services/language_service.dart';

class PusatBantuanScreen extends StatefulWidget {
  const PusatBantuanScreen({super.key});

  @override
  State<PusatBantuanScreen> createState() => _PusatBantuanScreenState();
}

class _PusatBantuanScreenState extends State<PusatBantuanScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> _faqList = [
    {
      'category': 'Masalah Pesanan Produk',
      'categoryEn': 'Product Order Issues',
      'question': 'Bagaimana jika sayur/buah yang diterima tidak segar/\nrusak?',
      'questionEn': 'What if the vegetables/fruits received are not fresh/\ndamaged?',
      'answer': 'Anda dapat mengajukan komplain dalam waktu 1x24 jam setelah pesanan diterima dengan melampirkan foto produk yang rusak melalui chat atau menu Bantuan.',
      'answerEn': 'You can file a complaint within 24 hours of receiving your order with photos of the damaged items via chat or Help menu.',
    },
    {
      'category': 'Pengiriman dan Kurir',
      'categoryEn': 'Delivery and Courier',
      'question': 'Pesanan terlambat sampai/ kurir tidak bisa dihubungi',
      'questionEn': 'Order is late / courier cannot be contacted',
      'answer': 'Silakan pantau status pengiriman pada riwayat pesanan atau hubungi CS kami melalui WhatsApp untuk konfirmasi posisi kurir.',
      'answerEn': 'Please track the delivery status in order history or contact our CS via WhatsApp to verify the courier position.',
    },
    {
      'category': 'Pengiriman dan Kurir',
      'categoryEn': 'Delivery and Courier',
      'question': 'Cara pengajuan pengembalian dana (refund) untuk\nbarang kosong',
      'questionEn': 'How to apply for a refund for\nout of stock items',
      'answer': 'Dana untuk barang yang kosong akan otomatis dikembalikan ke saldo atau metode pembayaran asal dalam waktu 1-3 hari kerja.',
      'answerEn': 'Funds for unavailable items will be automatically refunded to your original payment method within 1-3 business days.',
    },
    {
      'category': 'Alamat/Akun',
      'categoryEn': 'Address/Account',
      'question': 'Cara mengganti nomor handphone/alamat pengiriman',
      'questionEn': 'How to change phone number/shipping address',
      'answer': 'Anda dapat mengganti nomor telepon di menu Pengaturan Akun dan mengganti alamat pada menu Alamat Saya di halaman Profil.',
      'answerEn': 'You can change your phone number in Account Settings and change addresses in My Address under Profile.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFaqDetail(Map<String, String> item, String Function(String, String) tr) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              tr(item['category']!, item['categoryEn']!),
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF9E9E9E),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              tr(item['question']!, item['questionEn']!).replaceAll('\n', ' '),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              tr(item['answer']!, item['answerEn']!),
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF444444),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF70B88A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  tr('Tutup', 'Close'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.language,
      builder: (context, lang, _) {
        final tr = LanguageService.instance.tr;

        final filteredFaqs = _faqList.where((item) {
          if (_searchQuery.trim().isEmpty) return true;
          final q = _searchQuery.toLowerCase();
          final question = tr(item['question']!, item['questionEn']!).toLowerCase();
          final category = tr(item['category']!, item['categoryEn']!).toLowerCase();
          return question.contains(q) || category.contains(q);
        }).toList();

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFA5CBA5), // Exact top green sampled from Figma
                  Color(0xFFC4DFC4),
                  Color(0xFFE4EFE4),
                  Color(0xFFFEFFFE), // Bottom soft white
                ],
                stops: [0.0, 0.35, 0.70, 1.0],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Top Navigation Bar: Exact Back Button Asset & "Pusat Bantuan"
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 4),
                    child: Row(
                      children: [
                        // Exact circular back button asset with drop shadow (media_1792747275552)
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          behavior: HitTestBehavior.opaque,
                          child: Image.asset(
                            'assets/images/btn_back_white_circle.png',
                            width: 38,
                            height: 38,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Title: Pusat Bantuan (White bold 20px Baloo Tammudu 2 sesuai Figma)
                        Text(
                          tr('Pusat Bantuan', 'Help Center'),
                          style: const TextStyle(
                            fontFamily: 'Baloo Tammudu 2',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          // Greeting: "Halo! Ada yang bisa kami bantu?" (Baloo Tammudu 2 Bold 19.5px sesuai Figma)
                          Center(
                            child: Text(
                              tr('Halo! Ada yang bisa kami bantu?', 'Halo! Ada yang bisa kami bantu?'),
                              style: const TextStyle(
                                fontFamily: 'Baloo Tammudu 2',
                                fontSize: 19.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Search Bar Row with Drop Shadows (Sesuai Figma)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                // Input Box: White background, green border, drop shadow
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color(0xFF67B583),
                                        width: 1.4,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.22),
                                          blurRadius: 4,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: (val) {
                                        setState(() {
                                          _searchQuery = val;
                                        });
                                      },
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF1E1E1E),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: tr('Cari masalah kamu', 'Search your issue'),
                                        hintStyle: const TextStyle(
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 13,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                // Search Button: Green background, drop shadow
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF70B88A),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.22),
                                          blurRadius: 4,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.search,
                                          color: Colors.white,
                                          size: 19,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          tr('Search', 'Search'),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Section 1: "Topik/Pertanyaan populer"
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              tr('Topik/Pertanyaan populer', 'Popular Topics/Questions'),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // White FAQ Card with Drop Shadow (Tinggi & Padding presisi ~285px sesuai Figma)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.18),
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: filteredFaqs.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 24),
                                    child: Center(
                                      child: Text(
                                        tr('Tidak ada pertanyaan yang sesuai', 'No matching questions found'),
                                        style: const TextStyle(
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(filteredFaqs.length, (index) {
                                      final item = filteredFaqs[index];
                                      final isLast = index == filteredFaqs.length - 1;

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () => _showFaqDetail(item, tr),
                                            behavior: HitTestBehavior.opaque,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Category label
                                                  Text(
                                                    tr(item['category']!, item['categoryEn']!),
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Color(0xFF9E9E9E),
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  // Question text
                                                  Text(
                                                    tr(item['question']!, item['questionEn']!),
                                                    style: const TextStyle(
                                                      fontSize: 12.5,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xFF1E1E1E),
                                                      height: 1.35,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (!isLast)
                                            const Divider(
                                              color: Color(0xFFE5E5E5),
                                              height: 1,
                                              thickness: 0.8,
                                            ),
                                        ],
                                      );
                                    }),
                                  ),
                          ),

                          const SizedBox(height: 26),

                          // Section 2: "Opsi bantuan lainnya"
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              tr('Opsi bantuan lainnya', 'Other Help Options'),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Button 1: Hubungi Via WhatsApp (with Drop Shadow)
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(tr('Membuka WhatsApp...', 'Opening WhatsApp...')),
                                  backgroundColor: const Color(0xFF00B359),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              height: 46,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBBD7BF),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.18),
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                tr('Hubungi Via WhatsApp', 'Contact Via WhatsApp'),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Button 2: Kirim email ke mybigrocery54@gmail.com (with Drop Shadow)
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(tr('Membuka aplikasi Email...', 'Opening Email app...')),
                                  backgroundColor: const Color(0xFF00B359),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              height: 46,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBBD7BF),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.18),
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Kirim email ke mybigrocery54@gmail.com',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 36),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

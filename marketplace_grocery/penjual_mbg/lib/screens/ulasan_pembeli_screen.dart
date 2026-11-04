import 'package:flutter/material.dart';

/// Halaman Ulasan Pembeli & Balasan Penjual
/// 100% Presisi Identik Desain Figma:
/// - Header pill hijau dengan tombol panah kembali & judul "Ulasan Pembeli"
/// - Card Ulasan Pembeli dengan Avatar berbingkai hijau, nama "Panggil Aja Rahul", username "@rahuluhuy19"
/// - Rating 5 bintang emas & nama produk "Daging Sapi Wagyu A5 250gr"
/// - Foto produk ulasan pembeli (Rahul memegang daging)
/// - Teks ulasan: "Oh iya bang, makasih bang dagingnya fresh, kakek buyut saya sampai ingin pesan lagi, sukses selalu bang."
/// - Form respon penjual (TextField "Respon Penjual") & Tombol "Balas"
/// - Notifikasi popup: Ceklis hijau + teks "Berhasil Mengirimkan Balasan"
/// - Transformasi tampilan respon penjual setelah balasan dikirimkan
class UlasanPembeliScreen extends StatefulWidget {
  final Map<String, dynamic>? order;

  const UlasanPembeliScreen({super.key, this.order});

  @override
  State<UlasanPembeliScreen> createState() => _UlasanPembeliScreenState();
}

class _UlasanPembeliScreenState extends State<UlasanPembeliScreen> {
  final TextEditingController _replyController = TextEditingController();
  bool _isReplied = false;
  String _sellerReply = '';

  @override
  void initState() {
    super.initState();
    if (widget.order != null && widget.order!['sellerReply'] != null) {
      _isReplied = true;
      _sellerReply = widget.order!['sellerReply'] as String;
    }
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _handleBalas() {
    FocusScope.of(context).unfocus();
    final input = _replyController.text.trim();
    final reply = input.isNotEmpty
        ? input
        : 'Aamiin, makasih atas ulasan baiknya, terima kasih sudah berbelanja di Toko Daging Mas Rusdi, yaa!';

    _showSuccessPopup();

    setState(() {
      _sellerReply = reply;
      _isReplied = true;
      if (widget.order != null) {
        widget.order!['sellerReply'] = reply;
      }
    });
  }

  /// Popup notifikasi sesuai screenshot figma Image 5:
  /// Ceklis hijau + teks "Berhasil Mengirimkan\nBalasan"
  void _showSuccessPopup() {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Subtle dim backdrop
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.15),
            ),
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.82, end: 1.0),
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) => Transform.scale(
                  scale: scale,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 52),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                          blurRadius: 22,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check_rounded,
                          color: Color(0xFF00C058),
                          size: 54,
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Berhasil Mengirimkan\nBalasan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Baloo Tammudu 2',
                            color: Color(0xFF8BBF8B),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(milliseconds: 1800), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final buyerName = widget.order?['buyerName'] as String? ?? 'Panggil Aja Rahul';
    final buyerUsername = widget.order?['buyerUsername'] as String? ?? '@rahuluhuy19';
    final productTitle = widget.order?['productTitle'] as String? ??
        widget.order?['title'] as String? ??
        'Daging Sapi Wagyu A5 250gr';
    final reviewText = widget.order?['reviewText'] as String? ??
        'Oh iya bang, makasih bang dagingnya fresh, kakek buyut saya sampai ingin pesan lagi, sukses selalu bang.';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // 1. Header Pill Hijau
            _buildHeaderPill(context),

            const SizedBox(height: 14),

            // 2. Konten Ulasan & Respon
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.08),
                          blurRadius: 14,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Profile & Star Rating
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar Pembeli dengan border hijau
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF00C058),
                                  width: 1.5,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/avatar_rahul.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.person,
                                    color: Color(0xFF00C058),
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    buyerName,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E2022),
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    buyerUsername,
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      color: Color(0xFF999999),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => const Icon(
                                        Icons.star,
                                        color: Color(0xFFE0AA54),
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    productTitle,
                                    style: const TextStyle(
                                      fontSize: 11.0,
                                      color: Color(0xFF888888),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Row 2: Foto Ulasan Pembeli
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/review_rahul_photo.png',
                            width: 118,
                            height: 132,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 118,
                              height: 132,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Row 3: Teks Ulasan Pembeli
                        Text(
                          reviewText,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF222222),
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Row 4: Area Respon Penjual
                        if (!_isReplied) ...[
                          // Form Input Respon Penjual
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _replyController,
                              maxLines: 4,
                              minLines: 2,
                              decoration: const InputDecoration(
                                hintText: 'Respon Penjual',
                                hintStyle: TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF888888),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF222222),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Tombol Balas
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: _handleBalas,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD5D5D5),
                                foregroundColor: const Color(0xFF1B381B),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Balas',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1B381B),
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          // Tampilan Respon Penjual Setelah Terkirim
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Respon Penjual',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _sellerReply,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: Color(0xFF222222),
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
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

  /// Header pill hijau presisi gambar Figma
  Widget _buildHeaderPill(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF96C496),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF1B381B),
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Center(
              child: Text(
                'Ulasan Pembeli',
                style: TextStyle(
                  fontFamily: 'Baloo Tammudu 2',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B381B),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 26),
        ],
      ),
    );
  }
}

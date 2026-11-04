import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

/// Halaman Nilai Pesanan & Penilaian Saya (Aplikasi Pembeli)
/// 100% Identik Screenshot Figma:
/// - Header pill hijau: "Nilai Pesanan" -> berubah "Penilaian Saya" setelah dikirim
/// - Bintang rating interaktif: dapat diisi sesuai pilihan (1-5 bintang full warna kuning)
/// - Kotak upload foto kamera
/// - Kotak review teks (placeholder: "Kualitas : \nKetahanan : ...")
/// - Tombol "Kirim Penilaian":
///   * Abu-abu saat belum diisi
///   * Berubah hijau saat sudah diisi rating / ulasan
///   * Saat ditekan, muncul bubble ceklis: "Pesanan anda sudah di unggah"
///   * Beralih ke tampilan "Penilaian Saya" dengan profil @ambalohya56 dan bintang penuh
class NilaiPesananScreen extends StatefulWidget {
  const NilaiPesananScreen({super.key});

  @override
  State<NilaiPesananScreen> createState() => _NilaiPesananScreenState();
}

class _NilaiPesananScreenState extends State<NilaiPesananScreen> {
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isSubmitted = false;
  bool _hasPhoto = false;

  @override
  void initState() {
    super.initState();
    _reviewController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  bool get _isFormFilled => _selectedRating > 0 || _reviewController.text.trim().isNotEmpty;

  void _handleStarTap(int index) {
    if (_isSubmitted) return;
    setState(() {
      _selectedRating = index;
    });
  }

  void _handleKirimPenilaian() {
    if (_isSubmitted) {
      Navigator.pop(context);
      return;
    }

    if (!_isFormFilled) return;

    // Tampilkan bubble ceklis sesuai permintaan: "Pesanan anda sudah di ungguh"
    _showSuccessBubble();

    setState(() {
      _isSubmitted = true;
      if (_selectedRating == 0) {
        _selectedRating = 5;
      }
    });
  }

  /// Menampilkan bubble ceklis floating di layar sesuai screenshot pengguna
  void _showSuccessBubble() {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dim backdrop
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.18),
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
                      color: const Color(0xFFEDEDED),
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
                          size: 56,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Penilaian Anda Sudah diunggah',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF1E2022),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: MbgBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Floating Header Pill (Nilai Pesanan / Penilaian Saya)
              _buildHeaderPill(
                context,
                _isSubmitted ? 'Penilaian Saya' : 'Nilai Pesanan',
              ),
              const SizedBox(height: 20),

              // Scrollable Review Content
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  children: [
                    _buildMainCard(),
                  ],
                ),
              ),

              // Bottom Button "Kirim Penilaian"
              _buildBottomButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// Floating Header Pill Sesuai Figma
  Widget _buildHeaderPill(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF96C496),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.18),
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
              Icons.undo_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Baloo Tammudu 2',
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Main Card (Input State atau Submitted State)
  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profil User (@ambalohya56) jika sudah dikirim (Sesuai Image 4)
          if (_isSubmitted) ...[
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/avatar_amba.png',
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF01A852),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  '@ambalohya56',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E2022),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],

          // Baris Produk Norwegian Salmon 500gr + Harga + Bintang
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk dalam kontainer hijau muda (Sesuai Figma)
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFD4E7D0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/product_salmon.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.set_meal,
                      size: 40,
                      color: Color(0xFF01A852),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Detail Info Produk
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Norwegian Salmon 500gr',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E2022),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Rp152.000',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFC47D2B),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 5 Bintang Interaktif (Bisa diisi full warna kuning)
                    Row(
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        final isFilled = starIndex <= _selectedRating;

                        return GestureDetector(
                          onTap: () => _handleStarTap(starIndex),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              isFilled ? Icons.star : Icons.star_border_rounded,
                              color: const Color(0xFFFFB800),
                              size: 22,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFCBD5E1)),
          const SizedBox(height: 14),

          // Jika BELUM dikirim: Tampilkan Tombol Kamera + Box Tulis Ulasan
          if (!_isSubmitted) ...[
            // Tombol Upload Foto Kamera (Kontainer hijau muda)
            GestureDetector(
              onTap: () {
                setState(() {
                  _hasPhoto = !_hasPhoto;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFD7E8D7),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.04),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        color: Color(0xFF5A7E5A),
                        size: 24,
                      ),
                      if (_hasPhoto) ...[
                        const SizedBox(width: 8),
                        const Text(
                          '1 Foto Dipilih',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A6E4A),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Label "Tulis ulasan minimal 10 karakter"
            const Text(
              'Tulis ulasan minimal 10 karakter',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 8),

            // Box Input Ulasan Abu-Abu Sesuai Figma
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _reviewController,
                maxLines: 8,
                minLines: 6,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF1E2022),
                  height: 1.4,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText:
                      'Kualitas :\nKetahanan :\n\nBantu Pengguna lain membuat pilihan yang lebih baik dengan membagikan penilaianmu!',
                  hintStyle: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF666666),
                    height: 1.45,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Tombol Bawah "Kirim Penilaian"
  /// - Berwarna abu-abu saat belum diisi
  /// - Berwarna hijau saat sudah diisi (atau saat status Penilaian Saya)
  Widget _buildBottomButton() {
    final isGreen = _isSubmitted || _isFormFilled;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: isGreen ? _handleKirimPenilaian : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isGreen ? const Color(0xFF86BA86) : const Color(0xFFA3A3A3),
            disabledBackgroundColor: const Color(0xFFA3A3A3),
            foregroundColor: const Color(0xFF1E2022),
            elevation: 3,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Kirim Penilaian',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E2022),
            ),
          ),
        ),
      ),
    );
  }
}

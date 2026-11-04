import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'detail_rekening_screen.dart';
import 'pin_transaksi_screen.dart';
import 'riwayat_penarikan_dana_screen.dart';
import 'metode_pembayaran_toko_screen.dart';

class KeuanganPembayaranScreen extends StatefulWidget {
  const KeuanganPembayaranScreen({super.key});

  @override
  State<KeuanganPembayaranScreen> createState() =>
      _KeuanganPembayaranScreenState();
}

class _KeuanganPembayaranScreenState extends State<KeuanganPembayaranScreen> {
  // Brand colors matching Figma exactly
  static const Color brandGreen = Color(0xFF9FC89F);
  static const Color textDarkGreen = Color(0xFF1F4827);
  static const Color buttonBgColor = Color(0xFFF1EDED);
  static const Color labelTextColor = Color(0xFF4A4A4A);

  // Accounts state matching Figma screens
  String _danaNamaBank = 'DANA';
  String _danaJenisLayanan = 'E-wallet';
  String _danaNomorAkun = '0834xxxxxxxxx';
  String _danaNamaPemilik = 'Rusdi Wara Wiri';

  String _bsiNamaBank = 'Bank Syariah Indonesia (BSI)';
  String _bsiJenisLayanan = 'E-wallet';
  String _bsiNomorAkun = '734*********';
  String _bsiNamaPemilik = 'Rusdi Wara Wiri';

  bool _danaDeleted = false;
  bool _bsiDeleted = false;

  Future<void> _navigateToDetail(AccountType type) async {
    final isDana = type == AccountType.dana;
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => DetailRekeningScreen(
          accountType: type,
          initialNamaBank: isDana ? _danaNamaBank : _bsiNamaBank,
          initialJenisLayanan: isDana ? _danaJenisLayanan : _bsiJenisLayanan,
          initialNomorAkun: isDana ? _danaNomorAkun : _bsiNomorAkun,
          initialNamaPemilik: isDana ? _danaNamaPemilik : _bsiNamaPemilik,
        ),
      ),
    );

    if (result != null && mounted) {
      if (result['deleted'] == true) {
        setState(() {
          if (isDana) {
            _danaDeleted = true;
          } else {
            _bsiDeleted = true;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${isDana ? 'DANA' : 'BSI'} berhasil dihapus'),
            backgroundColor: const Color(0xFF00AA5B),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        setState(() {
          if (isDana) {
            _danaNamaBank = result['namaBank'] ?? _danaNamaBank;
            _danaJenisLayanan = result['jenisLayanan'] ?? _danaJenisLayanan;
            _danaNomorAkun = result['nomorAkun'] ?? _danaNomorAkun;
            _danaNamaPemilik = result['namaPemilik'] ?? _danaNamaPemilik;
          } else {
            _bsiNamaBank = result['namaBank'] ?? _bsiNamaBank;
            _bsiJenisLayanan = result['jenisLayanan'] ?? _bsiJenisLayanan;
            _bsiNomorAkun = result['nomorAkun'] ?? _bsiNomorAkun;
            _bsiNamaPemilik = result['namaPemilik'] ?? _bsiNamaPemilik;
          }
        });
      }
    }
  }


  void _showTambahRekeningSheet() {
    String selectedType = 'Bank BSI';
    final nomorCtrl = TextEditingController();
    final namaCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final isValid = nomorCtrl.text.trim().isNotEmpty &&
                namaCtrl.text.trim().isNotEmpty;

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  MediaQuery.of(ctx).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tambah Rekening / E-Wallet',
                      style: TextStyle(
                        fontFamily: 'Baloo Tammudu 2',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: textDarkGreen,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Pilih Bank / E-Wallet',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelTextColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: buttonBgColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedType,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(value: 'Bank BSI', child: Text('Bank BSI (Syariah)')),
                            DropdownMenuItem(value: 'Bank BCA', child: Text('Bank Central Asia (BCA)')),
                            DropdownMenuItem(value: 'Bank BRI', child: Text('Bank Rakyat Indonesia (BRI)')),
                            DropdownMenuItem(value: 'Bank Mandiri', child: Text('Bank Mandiri')),
                            DropdownMenuItem(value: 'DANA', child: Text('DANA E-Wallet')),
                            DropdownMenuItem(value: 'GoPay', child: Text('GoPay')),
                            DropdownMenuItem(value: 'OVO', child: Text('OVO')),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setSheetState(() {
                                selectedType = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Nomor Rekening / HP',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelTextColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: buttonBgColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: nomorCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setSheetState(() {}),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Masukkan nomor rekening',
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Nama Pemilik Rekening',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelTextColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: buttonBgColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: namaCtrl,
                        onChanged: (_) => setSheetState(() {}),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Sesuai buku tabungan / akun',
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: isValid
                          ? () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '$selectedType berhasil ditambahkan!',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor: const Color(0xFF00AA5B),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }
                          : null,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          color: isValid ? brandGreen : buttonBgColor,
                          borderRadius: BorderRadius.circular(27),
                          boxShadow: [
                            BoxShadow(
                              color: isValid
                                  ? const Color.fromRGBO(0, 0, 0, 0.20)
                                  : const Color.fromRGBO(0, 0, 0, 0.08),
                              offset: const Offset(0, 3),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Simpan Rekening',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isValid ? textDarkGreen : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showPINSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'PIN Transaksi & Keamanan',
                  style: TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDarkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: textDarkGreen),
                  title: const Text('Status PIN Transaksi', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Aktif (Diperlukan saat penarikan saldo)'),
                  trailing: const Icon(Icons.check_circle, color: Color(0xFF00AA5B)),
                  contentPadding: EdgeInsets.zero,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.password, color: textDarkGreen),
                  title: const Text('Ubah PIN Transaksi', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Menu Ubah PIN Transaksi dibuka'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRiwayatPenarikanSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Riwayat Penarikan Dana',
                  style: TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDarkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.arrow_downward, color: Color(0xFF00AA5B)),
                  title: const Text('Penarikan ke Bank BSI', style: TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: const Text('28 Okt 2026, 14:30 WIB'),
                  trailing: const Text(
                    'Rp1.250.000\nBerhasil',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00AA5B)),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.arrow_downward, color: Color(0xFF00AA5B)),
                  title: const Text('Penarikan ke DANA', style: TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: const Text('20 Okt 2026, 10:15 WIB'),
                  trailing: const Text(
                    'Rp500.000\nBerhasil',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00AA5B)),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMetodePembayaranSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Metode Pembayaran Toko',
                  style: TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDarkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  value: true,
                  onChanged: (_) {},
                  title: const Text('QRIS Statis & Dinamis', style: TextStyle(fontWeight: FontWeight.w600)),
                  activeTrackColor: const Color(0xFF00AA5B),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: true,
                  onChanged: (_) {},
                  title: const Text('Transfer Bank (Virtual Account)', style: TextStyle(fontWeight: FontWeight.w600)),
                  activeTrackColor: const Color(0xFF00AA5B),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: true,
                  onChanged: (_) {},
                  title: const Text('E-Wallet (DANA, GoPay, OVO)', style: TextStyle(fontWeight: FontWeight.w600)),
                  activeTrackColor: const Color(0xFF00AA5B),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule ("Keuangan dan Pembayaran" with Back Button)
              PenjualCapsuleHeader(
                title: 'Keuangan dan Pembayaran',
                onBack: () => Navigator.pop(context),
              ),

              // 2. Content (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),

                      // SECTION 1: Rekening / E-wallet Terdaftar
                      _buildSectionLabel('Rekening / E-wallet Terdaftar'),
                      const SizedBox(height: 8),

                      // Interactive Saved Account Cards Asset with Tappable Detail buttons
                      _buildSavedAccountCardStack(),
                      const SizedBox(height: 16),

                      // Tombol "Tambah" (Green Capsule Button)
                      _buildTambahButton(),
                      const SizedBox(height: 28),

                      // SECTION 2: Manajemen Saldo & Keamanan
                      _buildSectionLabel('Manajemen Saldo & Keamanan'),
                      const SizedBox(height: 12),

                      // MENU PILL 1: PIN Transaksi & Keamanan
                      _buildMenuPill(
                        title: 'PIN Transaksi & Keamanan',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PinTransaksiScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 11),

                      // MENU PILL 2: Riwayat Penarikan Dana
                      _buildMenuPill(
                        title: 'Riwayat Penarikan Dana',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RiwayatPenarikanDanaScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 11),

                      // MENU PILL 3: Metode Pembayaran Toko
                      _buildMenuPill(
                        title: 'Metode Pembayaran Toko',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MetodePembayaranTokoScreen(),
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
  }

  /// Section Label Header
  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        color: labelTextColor,
        letterSpacing: -0.1,
      ),
    );
  }

  /// Saved Account Cards Stack matching Figma Image exactly
  Widget _buildSavedAccountCardStack() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        // Aspect ratio of the original asset is 316 / 224 ~ 1.41
        final cardHeight = cardWidth * (224 / 316);

        return Stack(
          children: [
            // The visual card graphic matching Figma 100%
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/saved_account_cards.png',
                width: cardWidth,
                height: cardHeight,
                fit: BoxFit.fill,
              ),
            ),

            // Top Detail Button Overlay (DANA card detail) - enlarged & accurately positioned
            if (!_danaDeleted)
              Positioned(
                right: cardWidth * 0.04,
                top: cardHeight * 0.17,
                width: cardWidth * 0.36,
                height: cardHeight * 0.23,
                child: GestureDetector(
                  key: const Key('dana_detail_button'),
                  onTap: () => _navigateToDetail(AccountType.dana),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),

            // Bottom Detail Button Overlay (BSI card detail) - enlarged & accurately positioned
            if (!_bsiDeleted)
              Positioned(
                right: cardWidth * 0.04,
                top: cardHeight * 0.41,
                width: cardWidth * 0.36,
                height: cardHeight * 0.25,
                child: GestureDetector(
                  key: const Key('bsi_detail_button'),
                  onTap: () => _navigateToDetail(AccountType.bsi),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  /// Tombol Tambah (Capsule Green Button with 100% Dead-Center Text)
  Widget _buildTambahButton() {
    return GestureDetector(
      onTap: _showTambahRekeningSheet,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: brandGreen,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.20),
              offset: Offset(0, 4),
              blurRadius: 6.0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'Tambah',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textDarkGreen,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }

  /// Single Menu Pill Card (100% Dead-Center Vertically)
  Widget _buildMenuPill({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: buttonBgColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: textDarkGreen,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

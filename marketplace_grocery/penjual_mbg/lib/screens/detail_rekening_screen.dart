import 'package:flutter/material.dart';
import '../widgets/auto_dismiss_dialog.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

enum AccountType { dana, bsi, custom }

class DetailRekeningScreen extends StatefulWidget {
  final AccountType accountType;
  final String initialNamaBank;
  final String initialJenisLayanan;
  final String initialNomorAkun;
  final String initialNamaPemilik;

  const DetailRekeningScreen({
    super.key,
    this.accountType = AccountType.dana,
    this.initialNamaBank = 'DANA',
    this.initialJenisLayanan = 'E-wallet',
    this.initialNomorAkun = '0834xxxxxxxxx',
    this.initialNamaPemilik = 'Rusdi Wara Wiri',
  });

  @override
  State<DetailRekeningScreen> createState() => _DetailRekeningScreenState();
}

class _DetailRekeningScreenState extends State<DetailRekeningScreen> {
  // Brand colors matching Figma exactly
  static const Color brandGreen = Color(0xFF9FC89F);
  static const Color textDarkGreen = Color(0xFF1F4827);
  static const Color deleteButtonBg = Color(0xFFEAAFB0);
  static const Color deleteTextColor = Color(0xFF5E1B1B);
  static const Color inputBgColor = Color(0xFFF1EDED);
  static const Color labelTextColor = Color(0xFF4A4A4A);

  late TextEditingController _namaBankController;
  late TextEditingController _nomorAkunController;
  late TextEditingController _namaPemilikController;
  late String _selectedJenisLayanan;

  @override
  void initState() {
    super.initState();
    _namaBankController = TextEditingController(text: widget.initialNamaBank);
    _nomorAkunController = TextEditingController(text: widget.initialNomorAkun);
    _namaPemilikController = TextEditingController(text: widget.initialNamaPemilik);
    _selectedJenisLayanan = widget.initialJenisLayanan;
  }

  @override
  void didUpdateWidget(covariant DetailRekeningScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialNamaBank != widget.initialNamaBank) {
      _namaBankController.text = widget.initialNamaBank;
    }
    if (oldWidget.initialNomorAkun != widget.initialNomorAkun) {
      _nomorAkunController.text = widget.initialNomorAkun;
    }
    if (oldWidget.initialNamaPemilik != widget.initialNamaPemilik) {
      _namaPemilikController.text = widget.initialNamaPemilik;
    }
    if (oldWidget.initialJenisLayanan != widget.initialJenisLayanan) {
      _selectedJenisLayanan = widget.initialJenisLayanan;
    }
  }

  @override
  void dispose() {
    _namaBankController.dispose();
    _nomorAkunController.dispose();
    _namaPemilikController.dispose();
    super.dispose();
  }

  void _onSimpan() {
    FocusScope.of(context).unfocus();

    // Show Success Dialog matching Figma Image exactly with auto-dismiss after ~1.8s
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AutoDismissDialog(
          duration: const Duration(milliseconds: 1800),
          child: Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/success_berhasil_menyimpan.png',
                    width: 220,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check,
                          color: Color(0xFF00AA5B),
                          size: 48,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Berhasil Menyimpan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Baloo Tammudu 2',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7CB88F),
                          ),
                        ),
                      ],
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

  void _onHapus() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text(
            'Hapus Rekening',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E2022)),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus ${_namaBankController.text} dari daftar rekening?',
            style: const TextStyle(color: Color(0xFF555555)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEAAFB0),
                foregroundColor: deleteTextColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(ctx); // Close dialog
                Navigator.pop(context, {'deleted': true}); // Pop screen with deleted flag
              },
              child: const Text('Hapus', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _handleBack() {
    Navigator.pop(context, {
      'namaBank': _namaBankController.text.trim(),
      'jenisLayanan': _selectedJenisLayanan,
      'nomorAkun': _nomorAkunController.text.trim(),
      'namaPemilik': _namaPemilikController.text.trim(),
      'deleted': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDana = widget.accountType == AccountType.dana;
    final cardAsset = isDana
        ? 'assets/images/card_dana.png'
        : 'assets/images/card_bsi.png';

    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule ("Detail Rekening/E-wallet" with Back Button)
              PenjualCapsuleHeader(
                title: 'Detail Rekening/E-wallet',
                onBack: _handleBack,
              ),

              // 2. Content (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // Card Graphic matching Figma (316 x 177 aspect ratio)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.16),
                                offset: Offset(0, 4),
                                blurRadius: 8.0,
                              ),
                            ],
                          ),
                          child: AspectRatio(
                            aspectRatio: 316 / 177,
                            child: Image.asset(
                              cardAsset,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // FIELD 1: Nama Bank/E-wallet
                      _buildFieldLabel('Nama Bank/E-wallet'),
                      const SizedBox(height: 8),
                      _buildSingleLineInput(controller: _namaBankController),
                      const SizedBox(height: 18),

                      // FIELD 2: Jenis Layanan Keuangan (Dropdown / Selector)
                      _buildFieldLabel('Jenis Layanan Keuangan'),
                      const SizedBox(height: 8),
                      _buildDropdownServiceType(),
                      const SizedBox(height: 18),

                      // FIELD 3: Nomor Akun
                      _buildFieldLabel('Nomor Akun'),
                      const SizedBox(height: 8),
                      _buildSingleLineInput(
                        controller: _nomorAkunController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 18),

                      // FIELD 4: Nama Pemilik
                      _buildFieldLabel('Nama Pemilik'),
                      const SizedBox(height: 8),
                      _buildSingleLineInput(controller: _namaPemilikController),
                      const SizedBox(height: 32),

                      // ACTION BUTTONS: Simpan & Hapus Side-by-Side
                      Row(
                        children: [
                          // SIMPAN BUTTON
                          Expanded(
                            child: GestureDetector(
                              onTap: _onSimpan,
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: brandGreen,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.18),
                                      offset: Offset(0, 3),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Simpan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: textDarkGreen,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // HAPUS BUTTON
                          Expanded(
                            child: GestureDetector(
                              onTap: _onHapus,
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: deleteButtonBg,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.16),
                                      offset: Offset(0, 3),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Hapus',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: deleteTextColor,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  /// Field Label
  Widget _buildFieldLabel(String label) {
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

  /// Single line capsule text field matching Figma
  Widget _buildSingleLineInput({
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            offset: Offset(0, 3),
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Dropdown for "Jenis Layanan Keuangan"
  Widget _buildDropdownServiceType() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            offset: Offset(0, 3),
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedJenisLayanan,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: textDarkGreen,
            size: 26,
          ),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          items: const [
            DropdownMenuItem(value: 'E-wallet', child: Text('E-wallet')),
            DropdownMenuItem(value: 'Rekening Bank', child: Text('Rekening Bank')),
            DropdownMenuItem(value: 'Virtual Account', child: Text('Virtual Account')),
          ],
          onChanged: (val) {
            if (val != null) {
              setState(() {
                _selectedJenisLayanan = val;
              });
            }
          },
        ),
      ),
    );
  }
}

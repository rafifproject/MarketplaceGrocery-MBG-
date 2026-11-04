import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'pin_penarikan_screen.dart';

class PenarikanDanaScreen extends StatefulWidget {
  final String providerName;
  final bool isBank;

  const PenarikanDanaScreen({
    super.key,
    required this.providerName,
    required this.isBank,
  });

  @override
  State<PenarikanDanaScreen> createState() => _PenarikanDanaScreenState();
}

class _PenarikanDanaScreenState extends State<PenarikanDanaScreen> {
  static const Color textBrown = Color(0xFF3E270A);
  static const Color goldBadge = Color(0xFFBE9C5F);
  static const List<Color> goldLinearTotalPendapatan = [
    Color(0xFFE8C27E),
    Color(0xFFD6AE68),
  ];

  final TextEditingController _nomorCtrl = TextEditingController();
  final TextEditingController _nominalCtrl = TextEditingController();

  String _formatRupiah(int number) {
    final str = number.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }
    return buffer.toString().split('').reversed.join('');
  }

  int get _parsedNominal {
    final cleaned = _nominalCtrl.text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  bool get _isValid {
    final hasNomor = _nomorCtrl.text.trim().isNotEmpty;
    final hasNominal = _parsedNominal >= 10000;
    return hasNomor && hasNominal;
  }

  void _showKonfirmasiSheet() {
    final nominal = _parsedNominal;
    const biayaLayanan = 2000;
    final total = nominal + biayaLayanan;
    final nomorLabel = widget.isBank ? 'Nomor Kartu' : 'Nomor Telepon';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildConfirmRow('Tujuan', ': ${widget.providerName}'),
                const SizedBox(height: 18),
                _buildConfirmRow('Nama Penerima', ': DNXD PXTRX PXDNG'),
                const SizedBox(height: 18),
                _buildConfirmRow(nomorLabel, ': ${_nomorCtrl.text.trim()}'),
                const SizedBox(height: 18),
                _buildConfirmRow('Nominal', ': Rp${_formatRupiah(nominal)},00'),
                const SizedBox(height: 18),
                _buildConfirmRow('Biaya Layanan', ': Rp${_formatRupiah(biayaLayanan)},00'),
                const SizedBox(height: 18),
                _buildConfirmRow('Total', ': Rp${_formatRupiah(total)},00'),
                const SizedBox(height: 32),

                // Bottom Buttons: Batal & Konfirmasi matching Image 2
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(ctx),
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.10),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'Batal',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2C2C2C),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(ctx);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PinPenarikanScreen(
                                  providerName: widget.providerName,
                                  isBank: widget.isBank,
                                  nomor: _nomorCtrl.text.trim(),
                                  nominal: nominal,
                                  biayaLayanan: biayaLayanan,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: goldLinearTotalPendapatan,
                              ) ,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.12),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'Konfirmasi',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: textBrown,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nomorCtrl.dispose();
    _nominalCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nomorLabel = widget.isBank ? 'Nomor Kartu :' : 'Nomor Telepon :';

    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule ("DANA" / Bank Name in Gold Gradient)
              PenjualCapsuleHeader(
                title: widget.providerName,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: goldLinearTotalPendapatan,
                ),
                textColor: textBrown,
                arrowColor: textBrown,
                height: 48,
                fontSize: 19,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                onBack: () => Navigator.pop(context),
              ),

              // 2. Body
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                  children: [
                    // Saldo Card matching Image 1
                    _buildSaldoCard(),
                    const SizedBox(height: 28),

                    // Field 1: Nomor Telepon / Nomor Kartu
                    Text(
                      nomorLabel,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F1F1),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.06),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _nomorCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.isBank
                              ? 'Masukkan nomor kartu'
                              : 'Masukkan nomor telepon',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFFA5A5A5),
                            fontSize: 14,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Field 2: Nominal
                    Text(
                      'Nominal :',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F1F1),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.06),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Left Gold "Rp" Circle Pill
                          Container(
                            width: 48,
                            height: 48,
                            margin: const EdgeInsets.all(2),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: goldLinearTotalPendapatan,
                              ),
                            ),
                            child: Text(
                              'Rp',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: textBrown,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Nominal TextField
                          Expanded(
                            child: TextField(
                              controller: _nominalCtrl,
                              keyboardType: TextInputType.number,
                              onChanged: (_) => setState(() {}),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFFA5A5A5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Subtitle: Minimal nominal pengisian
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 6),
                      child: Text(
                        'Minimal nominal pengisian Rp10.000,00',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF757575),
                        ),
                      ),
                    ),

                    const SizedBox(height: 120),

                    // Bottom "Lanjut" Button (Changes to Gold when valid)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _isValid ? _showKonfirmasiSheet : null,
                        borderRadius: BorderRadius.circular(26),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _isValid ? null : const Color(0xFFF0EEEE),
                            gradient: _isValid
                                ? const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: goldLinearTotalPendapatan,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: [
                              BoxShadow(
                                color: _isValid
                                    ? const Color.fromRGBO(0, 0, 0, 0.12)
                                    : const Color.fromRGBO(0, 0, 0, 0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'Lanjut',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: _isValid ? textBrown : const Color(0xFFA5A5A5),
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
        ),
      ),
    );
  }

  /// Saldo Card matching Image 1
  Widget _buildSaldoCard() {
    return Container(
      width: double.infinity,
      height: 108,
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: goldLinearTotalPendapatan,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "Saldo yang Anda miliki" Badge Pill
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 2),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
              decoration: BoxDecoration(
                color: goldBadge,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Saldo yang Anda miliki',
                style: GoogleFonts.plusJakartaSans(
                  color: textBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          // Amount Text: Rp15.000.000,00 centered edge-to-edge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Rp15.000.000',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: textBrown,
                          letterSpacing: -1.0,
                          height: 1.0,
                        ),
                      ),
                      TextSpan(
                        text: ',00',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: textBrown,
                          letterSpacing: -0.5,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

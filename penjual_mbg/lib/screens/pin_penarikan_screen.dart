import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'bukti_penarikan_screen.dart';

class PinPenarikanScreen extends StatefulWidget {
  final String providerName;
  final bool isBank;
  final String nomor;
  final int nominal;
  final int biayaLayanan;

  const PinPenarikanScreen({
    super.key,
    required this.providerName,
    required this.isBank,
    required this.nomor,
    required this.nominal,
    this.biayaLayanan = 2000,
  });

  @override
  State<PinPenarikanScreen> createState() => _PinPenarikanScreenState();
}

class _PinPenarikanScreenState extends State<PinPenarikanScreen> {
  static const Color textBrown = Color(0xFF3E270A);
  static const List<Color> goldLinearTotalPendapatan = [
    Color(0xFFE8C27E),
    Color(0xFFD6AE68),
  ];

  String _pin = '';

  void _onKeyPress(String val) {
    if (_pin.length < 6) {
      setState(() {
        _pin += val;
      });
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _submit() {
    if (_pin.length == 6) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BuktiPenarikanScreen(
            providerName: widget.providerName,
            isBank: widget.isBank,
            nomor: widget.nomor,
            nominal: widget.nominal,
            biayaLayanan: widget.biayaLayanan,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _pin.length == 6;

    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule ("Masukkan PIN Transaksi" in soft green matching Image 3)
              PenjualCapsuleHeader(
                title: 'Masukkan PIN Transaksi',
                backgroundColor: const Color(0xFF9FC89F),
                textColor: const Color(0xFF1F4827),
                arrowColor: const Color(0xFF1F4827),
                height: 48,
                fontSize: 18,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: 36),

              // 2. 6 PIN Boxes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    final hasDigit = index < _pin.length;
                    return Container(
                      width: 44,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F1F1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: hasDigit
                          ? Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF1A1A1A),
                              ),
                            )
                          : null,
                    );
                  }),
                ),
              ),

              const Spacer(),

              // 3. Button "Lanjut" (Turns gold when 6 digits entered)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: isValid ? _submit : null,
                    borderRadius: BorderRadius.circular(26),
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isValid ? null : const Color(0xFFF0EEEE),
                        gradient: isValid
                            ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: goldLinearTotalPendapatan,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: isValid
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
                          color: isValid ? textBrown : const Color(0xFFA5A5A5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 4. Custom Keypad matching Image 3
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F1F1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildKeypadRow(['1', '2', '3']),
                    const SizedBox(height: 10),
                    _buildKeypadRow(['4', '5', '6']),
                    const SizedBox(height: 10),
                    _buildKeypadRow(['7', '8', '9']),
                    const SizedBox(height: 10),
                    _buildKeypadBottomRow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      children: keys.map((key) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _onKeyPress(key),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.06),
                        blurRadius: 3,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  child: Text(
                    key,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeypadBottomRow() {
    return Row(
      children: [
        // ABC dummy key
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.06),
                    blurRadius: 3,
                    offset: Offset(0, 1.5),
                  ),
                ],
              ),
              child: Text(
                'ABC',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ),
          ),
        ),

        // '0' key
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _onKeyPress('0'),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.06),
                        blurRadius: 3,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  child: Text(
                    '0',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Backspace key
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _onBackspace,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.06),
                        blurRadius: 3,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.backspace_outlined,
                    size: 22,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

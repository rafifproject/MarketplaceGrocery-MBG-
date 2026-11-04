import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class UbahPinScreen extends StatefulWidget {
  const UbahPinScreen({super.key});

  @override
  State<UbahPinScreen> createState() => _UbahPinScreenState();
}

class _UbahPinScreenState extends State<UbahPinScreen> {
  static const Color textBrown = Color(0xFF3E270A);
  static const List<Color> goldLinear = [
    Color(0xFFE8C27E),
    Color(0xFFD6AE68),
  ];

  // Steps: 0 = masukkan PIN lama, 1 = masukkan PIN baru, 2 = konfirmasi PIN baru
  int _step = 0;
  String _pinLama = '';
  String _pinBaru = '';
  String _pinKonfirmasi = '';

  String get _currentPin {
    if (_step == 0) return _pinLama;
    if (_step == 1) return _pinBaru;
    return _pinKonfirmasi;
  }

  String get _headerTitle {
    if (_step == 0) return 'Masukkan PIN Lama';
    if (_step == 1) return 'Masukkan PIN Baru';
    return 'Konfirmasi PIN Baru';
  }

  void _onKeyPress(String val) {
    final cur = _currentPin;
    if (cur.length < 6) {
      setState(() {
        if (_step == 0) _pinLama += val;
        else if (_step == 1) _pinBaru += val;
        else _pinKonfirmasi += val;
      });
    }
  }

  void _onBackspace() {
    setState(() {
      if (_step == 0 && _pinLama.isNotEmpty) {
        _pinLama = _pinLama.substring(0, _pinLama.length - 1);
      } else if (_step == 1 && _pinBaru.isNotEmpty) {
        _pinBaru = _pinBaru.substring(0, _pinBaru.length - 1);
      } else if (_step == 2 && _pinKonfirmasi.isNotEmpty) {
        _pinKonfirmasi = _pinKonfirmasi.substring(0, _pinKonfirmasi.length - 1);
      }
    });
  }

  void _submit() {
    if (_currentPin.length != 6) return;
    if (_step == 0) {
      // Verifikasi PIN lama (simulasi selalu benar)
      setState(() {
        _step = 1;
      });
    } else if (_step == 1) {
      setState(() {
        _step = 2;
      });
    } else {
      // Step 2: konfirmasi
      if (_pinBaru == _pinKonfirmasi) {
        // Tampilkan popup "Berhasil Menyimpan PIN Transaksi"
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/success_pin_transaksi.png',
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        );

        // Otomatis menghilang dan kembali ke halaman PIN Transaksi & Keamanan
        Future.delayed(const Duration(milliseconds: 1400), () {
          if (mounted) {
            Navigator.of(context, rootNavigator: true).pop(); // Tutup dialog
            Navigator.pop(context); // Kembali ke page PIN Transaksi & Keamanan
          }
        });
      } else {
        // PIN tidak cocok
        setState(() {
          _pinKonfirmasi = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'PIN tidak cocok, coba lagi',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
            backgroundColor: const Color(0xFFD32F2F),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _currentPin.length == 6;

    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              PenjualCapsuleHeader(
                title: _headerTitle,
                backgroundColor: const Color(0xFF9FC89F),
                textColor: const Color(0xFF1F4827),
                arrowColor: const Color(0xFF1F4827),
                height: 48,
                fontSize: 18,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                onBack: () {
                  if (_step == 0) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      _step--;
                      if (_step == 1) _pinKonfirmasi = '';
                      if (_step == 0) _pinBaru = '';
                    });
                  }
                },
              ),

              const SizedBox(height: 36),

              // 6 PIN dots
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    final hasDigit = index < _currentPin.length;
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

              // Tombol Lanjut
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
                                colors: goldLinear,
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

              // Custom Keypad
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


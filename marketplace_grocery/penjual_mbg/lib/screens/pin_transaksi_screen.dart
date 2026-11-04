import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'ubah_pin_screen.dart';

class PinTransaksiScreen extends StatelessWidget {
  const PinTransaksiScreen({super.key});

  static const Color brandGreen = Color(0xFF9FC89F);
  static const Color textDarkGreen = Color(0xFF1F4827);
  static const Color buttonBgColor = Color(0xFFF1EDED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              PenjualCapsuleHeader(
                title: 'PIN Transaksi & Keamanan',
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: 16),

              // Menu pill: Ubah PIN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UbahPinScreen(),
                      ),
                    );
                  },
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
                    child: const Text(
                      'Ubah PIN',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: textDarkGreen,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


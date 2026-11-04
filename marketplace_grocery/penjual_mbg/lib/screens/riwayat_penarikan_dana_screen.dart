import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class RiwayatPenarikanDanaScreen extends StatelessWidget {
  const RiwayatPenarikanDanaScreen({super.key});

  static const Color textDarkGreen = Color(0xFF1F4827);
  static const Color cardBg = Color(0xFFF4F1F1);
  static const Color successGreen = Color(0xFF8DB88D);
  static const Color failRed = Color(0xFFD98080);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              PenjualCapsuleHeader(
                title: 'Riwayat Penarikan Dana',
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildRiwayatCard(
                      tujuan: 'Tarik ke DANA',
                      nominal: '-Rp200.000,00',
                      tanggal: '12 Oktober 2026, 14:30 WIB',
                      isSuccess: true,
                    ),
                    const SizedBox(height: 14),
                    _buildRiwayatCard(
                      tujuan: 'Tarik ke Bank Syariah Indonesia',
                      nominal: '-Rp200.000,00',
                      tanggal: '11 Oktober 2026, 11:30 WIB',
                      isSuccess: false,
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

  Widget _buildRiwayatCard({
    required String tujuan,
    required String nominal,
    required String tanggal,
    required bool isSuccess,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tujuan,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tanggal,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7A7A7A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  nominal,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),

          // Status badge bar
          Container(
            width: double.infinity,
            height: 32,
            decoration: BoxDecoration(
              color: isSuccess ? successGreen : failRed,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              isSuccess ? 'Berhasil' : 'Gagal',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


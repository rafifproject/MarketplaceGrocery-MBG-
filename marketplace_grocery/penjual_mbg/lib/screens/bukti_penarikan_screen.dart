import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class BuktiPenarikanScreen extends StatelessWidget {
  final String providerName;
  final bool isBank;
  final String nomor;
  final int nominal;
  final int biayaLayanan;
  final String namaPenerima;
  final String transaksiId;
  final String refNo;
  final String waktuTransaksi;

  const BuktiPenarikanScreen({
    super.key,
    required this.providerName,
    required this.isBank,
    required this.nomor,
    required this.nominal,
    this.biayaLayanan = 2000,
    this.namaPenerima = 'DNXD PXTRX PXDNG',
    this.transaksiId = 'TRXN356478',
    this.refNo = 'SSVGRHRHF',
    this.waktuTransaksi = '14/10/2026 - 15:00 WIB',
  });

  static const Color textBrown = Color(0xFF3E270A);
  static const List<Color> goldLinearTotalPendapatan = [
    Color(0xFFE8C27E),
    Color(0xFFD6AE68),
  ];

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

  @override
  Widget build(BuildContext context) {
    final total = nominal + biayaLayanan;
    final nomorLabel = isBank ? 'Nomor Kartu' : 'Nomor Telepon';

    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule matching Figma Image 4
              PenjualCapsuleHeader(
                title: 'Bukti Penarikan',
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

              // 2. Body Receipt Card
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
                  child: Column(
                    children: [
                      // White Receipt Container
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.08),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // MBG Logo & Title
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'My Big Grocery',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF00AA5B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Date & Time
                            Text(
                              waktuTransaksi,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF8A8A8A),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Details Table
                            _buildReceiptRow('Transaksi ID', ': $transaksiId'),
                            const SizedBox(height: 18),
                            _buildReceiptRow('Ref No.', ': $refNo'),
                            const SizedBox(height: 18),
                            _buildReceiptRow('Tujuan', ': $providerName'),
                            const SizedBox(height: 18),
                            _buildReceiptRow('Nama Penerima', ': $namaPenerima'),
                            const SizedBox(height: 18),
                            _buildReceiptRow(nomorLabel, ': $nomor'),
                            const SizedBox(height: 18),
                            _buildReceiptRow('Nominal', ': Rp${_formatRupiah(nominal)},00'),
                            const SizedBox(height: 18),
                            _buildReceiptRow('Biaya Layanan', ': Rp${_formatRupiah(biayaLayanan)},00'),
                            const SizedBox(height: 18),
                            _buildReceiptRow('Total', ': Rp${_formatRupiah(total)},00'),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Bottom Two Buttons: Kembali & Unduh Bukti
                      Row(
                        children: [
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
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
                                    'Kembali',
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Bukti penarikan berhasil diunduh!',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      backgroundColor: const Color(0xFF00AA5B),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                    ),
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
                                    'Unduh Bukti',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
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
}

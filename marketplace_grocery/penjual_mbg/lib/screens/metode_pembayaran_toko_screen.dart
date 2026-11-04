import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class MetodePembayaranTokoScreen extends StatelessWidget {
  const MetodePembayaranTokoScreen({super.key});

  static const Color brandGreen = Color(0xFF9FC89F);
  static const Color textDarkGreen = Color(0xFF1F4827);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              PenjualCapsuleHeader(
                title: 'Metode Pembayaran Toko',
                onBack: () => Navigator.pop(context),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 28),

                      // Title QRIS Toko
                      Text(
                        'QRIS Toko',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: textDarkGreen,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // QR Code Card (Clean, centered square)
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 320),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.08),
                              blurRadius: 14,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.asset(
                              'assets/images/qris_code.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Tombol Bagikan & Unduh
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _showBagikanSheet(context),
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: brandGreen,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Bagikan',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: textDarkGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'QR Code berhasil diunduh',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w600,
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
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: brandGreen,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Unduh',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: textDarkGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),
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

  void _showBagikanSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              24,
              16,
              24,
              MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
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
                const SizedBox(height: 24),

                // Social media icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialItem(
                      context: ctx,
                      assetPath: 'assets/images/ic_instagram.png',
                      label: 'Instagram',
                    ),
                    _buildSocialItem(
                      context: ctx,
                      assetPath: 'assets/images/ic_whatsapp.png',
                      label: 'WhatsApp',
                    ),
                    _buildSocialItem(
                      context: ctx,
                      assetPath: 'assets/images/ic_facebook.png',
                      label: 'Facebook',
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Tombol Bagikan
                GestureDetector(
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'QR Code berhasil dibagikan',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
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
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: brandGreen,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Bagikan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textDarkGreen,
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
  }

  Widget _buildSocialItem({
    required BuildContext context,
    required String assetPath,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Bagikan ke $label',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
            backgroundColor: const Color(0xFF1F4827),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Image.asset(
            assetPath,
            width: 52,
            height: 52,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}

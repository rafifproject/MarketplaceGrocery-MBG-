import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'penarikan_dana_screen.dart';

enum WithdrawalMethod {
  none,
  ewallet,
  bank,
}

class DompetSellerScreen extends StatefulWidget {
  const DompetSellerScreen({super.key});

  @override
  State<DompetSellerScreen> createState() => _DompetSellerScreenState();
}

class _DompetSellerScreenState extends State<DompetSellerScreen> {
  // Gold gradient matching Total Pendapatan & Dompet Seller
  static const Color textBrown = Color(0xFF3E270A);
  static const Color goldBadge = Color(0xFFBE9C5F);
  static const List<Color> goldLinearTotalPendapatan = [
    Color(0xFFE8C27E),
    Color(0xFFD6AE68),
  ];

  static const Color unselectedGrey = Color(0xFFD9D9D9);
  static const Color providerCardBg = Color(0xFFF4F1F1);

  WithdrawalMethod _selectedMethod = WithdrawalMethod.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule matching Figma
              PenjualCapsuleHeader(
                title: 'Dompet Seller',
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

              // 2. Scrollable Body
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                  children: [
                    // Saldo Card matching Figma
                    _buildSaldoCard(),
                    const SizedBox(height: 24),

                    // "Tarik Dana" Subtitle
                    Text(
                      'Tarik Dana',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Two Selection Pill Buttons: e-wallet & BANK
                    Row(
                      children: [
                        Expanded(
                          child: _buildMethodButton(
                            label: 'e-wallet',
                            iconAsset: 'assets/images/ic_ewallet.png',
                            isSelected: _selectedMethod == WithdrawalMethod.ewallet,
                            onTap: () {
                              setState(() {
                                _selectedMethod = WithdrawalMethod.ewallet;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _buildMethodButton(
                            label: 'BANK',
                            iconAsset: 'assets/images/ic_bank.png',
                            isSelected: _selectedMethod == WithdrawalMethod.bank,
                            onTap: () {
                              setState(() {
                                _selectedMethod = WithdrawalMethod.bank;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Provider options list when selected
                    if (_selectedMethod == WithdrawalMethod.ewallet) ...[
                      _buildProviderCard(
                        logoAsset: 'assets/images/logo_dana.png',
                        logoHeight: 36,
                        onTap: () => _openDetail(
                          namaBank: 'DANA',
                          isBank: false,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildProviderCard(
                        logoAsset: 'assets/images/logo_ovo.png',
                        logoHeight: 36,
                        onTap: () => _openDetail(
                          namaBank: 'OVO',
                          isBank: false,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildProviderCard(
                        logoAsset: 'assets/images/logo_gopay.png',
                        logoHeight: 32,
                        onTap: () => _openDetail(
                          namaBank: 'GoPay',
                          isBank: false,
                        ),
                      ),
                    ] else if (_selectedMethod == WithdrawalMethod.bank) ...[
                      _buildProviderCard(
                        logoAsset: 'assets/images/logo_bsi.png',
                        logoHeight: 36,
                        onTap: () => _openDetail(
                          namaBank: 'BSI',
                          isBank: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildProviderCard(
                        logoAsset: 'assets/images/logo_bri.png',
                        logoHeight: 36,
                        onTap: () => _openDetail(
                          namaBank: 'BRI',
                          isBank: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildProviderCard(
                        logoAsset: 'assets/images/logo_bsn.png',
                        logoHeight: 40,
                        onTap: () => _openDetail(
                          namaBank: 'BSN',
                          isBank: true,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Saldo Card matching Figma Image 2
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

  /// Selection Method Button (e-wallet or BANK)
  Widget _buildMethodButton({
    required String label,
    required String iconAsset,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? null : unselectedGrey,
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: goldLinearTotalPendapatan,
                  )
                : null,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconAsset,
                width: 44,
                height: 44,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? textBrown : const Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Provider Card (DANA, OVO, GoPay, BSI, BRI, BSN)
  Widget _buildProviderCard({
    required String logoAsset,
    required double logoHeight,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          height: 62,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: providerCardBg,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(
            logoAsset,
            height: logoHeight,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void _openDetail({
    required String namaBank,
    required bool isBank,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PenarikanDanaScreen(
          providerName: namaBank,
          isBank: isBank,
        ),
      ),
    );
  }
}

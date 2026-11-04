import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

/// Halaman Informasi Order (Tracking Pengiriman)
/// 100% Identik Screenshot Figma:
/// - Header pill hijau dengan tombol kembali melengkung: "Informasi Order"
/// - Estimasi Tiba : 20-30 min + GrabExpress
/// - Card Timeline Status Pengiriman (Orange dot active & Grey dots)
class InformasiOrderScreen extends StatelessWidget {
  const InformasiOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MbgBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Floating Green Header Pill
              _buildHeaderPill(context, 'Informasi Order'),
              const SizedBox(height: 24),

              // Estimasi Tiba & GrabExpress
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Estimasi Tiba : 20–30 min',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E2022),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'GrabExpress',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF475569),
                      ),
                    ),
                    SizedBox(height: 14),
                    Divider(height: 1, color: Color(0xFFCBD5E1)),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Tracking Card (Timeline)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        blurRadius: 14,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Step 1: Pesanan telah diserahkan ke kurir (Active - Orange Dot)
                      _buildTimelineStep(
                        isFirst: true,
                        isActive: true,
                        title: 'Pesanan Telah diserahkan Ke kurir',
                        date: '28 September 2026',
                        showConnectingLine: true,
                      ),

                      // Step 2: Pengirim telah mengatur pengiriman (Inactive - Grey Dot)
                      _buildTimelineStep(
                        isActive: false,
                        title:
                            'Pengirim telah mengatur pengiriman. Menunggu pesanan diserahkan ke pihak jasa kirim.',
                        date: '28 September 2026',
                        showConnectingLine: true,
                      ),

                      // Step 3: Pesanan dibuat (Inactive - Grey Dot)
                      _buildTimelineStep(
                        isLast: true,
                        isActive: false,
                        title: 'Pesanan dibuat',
                        date: '28 September 2026',
                        showConnectingLine: false,
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

  /// Floating Green Header Pill
  Widget _buildHeaderPill(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF96C496),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.18),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: const Icon(
              Icons.undo_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Baloo Tammudu 2',
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Timeline Step Component
  Widget _buildTimelineStep({
    bool isFirst = false,
    bool isLast = false,
    required bool isActive,
    required String title,
    required String date,
    required bool showConnectingLine,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column with Dot and Vertical Connecting Line
        Column(
          children: [
            Container(
              width: isActive ? 14 : 10,
              height: isActive ? 14 : 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? const Color(0xFFE0AA54) : const Color(0xFFCBD5E1),
              ),
            ),
            if (showConnectingLine)
              Container(
                width: 1.5,
                height: 56,
                color: const Color(0xFFCBD5E1),
              ),
          ],
        ),
        const SizedBox(width: 16),

        // Text Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? const Color(0xFF1E2022) : const Color(0xFF475569),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF888888),
                ),
              ),
              if (showConnectingLine) const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}

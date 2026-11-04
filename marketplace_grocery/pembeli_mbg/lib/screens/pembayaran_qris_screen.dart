import 'dart:async';
import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import 'pesanan_selesai_screen.dart';

class PembayaranQrisScreen extends StatefulWidget {
  final int totalPayment;

  const PembayaranQrisScreen({
    super.key,
    required this.totalPayment,
  });

  @override
  State<PembayaranQrisScreen> createState() => _PembayaranQrisScreenState();
}

class _PembayaranQrisScreenState extends State<PembayaranQrisScreen> {
  // Timer mundur countdown (dimulai dari 4 menit 59 detik = 299 detik)
  late int _remainingSeconds;
  Timer? _countdownTimer;

  // State apakah tombol "Download QR Code" sudah ditekan
  bool _isDownloaded = false;

  // State loading verifikasi pembayaran (Sesuai Gambar 3)
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 299; // 04:59
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (mounted) {
          setState(() {
            _remainingSeconds--;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTimer(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _handleDownloadQr() {
    setState(() {
      _isDownloaded = true;
    });

    // Simulasi alur otomatis: Setelah QR didownload dan discan,
    // tampilkan layar loading spinner (Gambar 3), lalu berhasil dan menuju halaman Order (Dikemas)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });

        // Simulasi verifikasi sukses pembayaran QRIS
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            CartService.instance.clearCart();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PesananSelesaiScreen(isCod: false),
              ),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading ? _buildLoadingView() : _buildQrisView(),
      ),
    );
  }

  // Tampilan Utama Pembayaran QRIS (Persis Gambar 1, 2, dan 4)
  Widget _buildQrisView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 36),

          // Judul Hijau "Pembayaran QRIS" Sesuai Mockup
          const Text(
            'Pembayaran QRIS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF01A852),
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 16),

          // Banner Notifikasi: "QR Code sudah di download" (Gambar 2)
          if (_isDownloaded) ...[
            Container(
              width: double.infinity,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFD2F4E2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'QR Code sudah di download',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ] else ...[
            const SizedBox(height: 30),
          ],

          // Card Kotak Abu-Abu Berisi Gambar QR Code, Timer, & Keterangan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 4),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gambar QR Code Resmi dari Mockup Asli Figma
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/qris_code.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.qr_code_2_rounded,
                        size: 200,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Waktu Mundur (Countdown Timer e.g. 04:59)
                Text(
                  _formatTimer(_remainingSeconds),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 6),

                // Teks Panduan Scan
                const Text(
                  'Scan waktu di atas berakhir',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // Tombol Hijau: "Download QR Code" dengan Peraturan Drop Shadow Figma
          GestureDetector(
            onTap: _handleDownloadQr,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF61C48C),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: const Text(
                'Download QR Code',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Tampilan Loading Spinner Hijau di Tengah Layar (Persis Gambar 3)
  Widget _buildLoadingView() {
    return Column(
      children: [
        const SizedBox(height: 36),
        const Text(
          'Pembayaran QRIS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF01A852),
            letterSpacing: -0.3,
          ),
        ),
        const Spacer(),
        Center(
          child: SizedBox(
            width: 72,
            height: 72,
            child: CircularProgressIndicator(
              strokeWidth: 6.5,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF61C48C)),
              backgroundColor: const Color(0xFF61C48C).withValues(alpha: 0.2),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

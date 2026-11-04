import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class TambahStokScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const TambahStokScreen({
    super.key,
    required this.product,
  });

  @override
  State<TambahStokScreen> createState() => _TambahStokScreenState();
}

class _TambahStokScreenState extends State<TambahStokScreen> {
  // Brand colors matching the app exactly
  static const Color brandGreen = Color(0xFF9FC89F);
  static const Color textDarkGreen = Color(0xFF1F4827);
  static const Color inputBgColor = Color(0xFFF1EDED);
  static const Color stepperIconColor = Color(0xFF8E8E93);

  late int _currentStock;

  @override
  void initState() {
    super.initState();
    // Initialize stock from product detail
    final rawStock = widget.product['stockPcs'] ?? widget.product['stock'] ?? 0;
    if (rawStock is int) {
      _currentStock = rawStock;
    } else {
      _currentStock = int.tryParse(rawStock.toString()) ?? 0;
    }
  }

  void _incrementStock() {
    setState(() {
      _currentStock++;
    });
  }

  void _decrementStock() {
    if (_currentStock > 0) {
      setState(() {
        _currentStock--;
      });
    }
  }

  void _onSimpanPressed() {
    Navigator.pop(context, _currentStock);
  }

  Widget _buildProductImage() {
    final imgFile = widget.product['imageFile'];
    if (imgFile is File) {
      return Image.file(
        imgFile,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.fastfood, color: Colors.grey, size: 60),
        ),
      );
    }

    final imgPath = widget.product['image'] as String?;
    if (imgPath != null && imgPath.isNotEmpty) {
      if (imgPath.startsWith('assets/')) {
        return Image.asset(
          imgPath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(Icons.fastfood, color: Colors.grey, size: 60),
          ),
        );
      } else {
        return Image.file(
          File(imgPath),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(Icons.fastfood, color: Colors.grey, size: 60),
          ),
        );
      }
    }

    return const Center(
      child: Icon(Icons.fastfood, color: Colors.grey, size: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Top Capsule Header: "Tambah Stok"
              PenjualCapsuleHeader(
                title: 'Tambah Stok',
                onBack: () => Navigator.pop(context),
              ),

              // 2. Main Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // PRODUCT IMAGE CARD (Centered rounded box matching Figma)
                      Center(
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxWidth: 320,
                            maxHeight: 240,
                          ),
                          height: 230,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.20),
                                offset: Offset(0, 5),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: _buildProductImage(),
                        ),
                      ),

                      const SizedBox(height: 38),

                      // STOCK STEPPER PILL (Left: "XX pcs", Right: [-] [+])
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: inputBgColor,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.16),
                              offset: Offset(0, 3),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Current Stock Text (e.g. "12 pcs") - Perfectly vertically centered
                            Text(
                              '$_currentStock pcs',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: textDarkGreen,
                                letterSpacing: -0.2,
                              ),
                            ),

                            // Stepper Controls [-] [+]
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Minus Button
                                GestureDetector(
                                  onTap: _decrementStock,
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.remove_circle,
                                      size: 30,
                                      color: stepperIconColor,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 14),

                                // Plus Button
                                GestureDetector(
                                  onTap: _incrementStock,
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.add_circle,
                                      size: 30,
                                      color: stepperIconColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),

                      // "Simpan" Capsule Button - Perfectly centered optical alignment matching Figma
                      GestureDetector(
                        onTap: _onSimpanPressed,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: brandGreen,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.22),
                                offset: Offset(0, 4),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Simpan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: textDarkGreen,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),
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
}

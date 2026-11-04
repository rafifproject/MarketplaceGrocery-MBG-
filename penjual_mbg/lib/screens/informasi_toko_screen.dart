import 'package:flutter/material.dart';
import '../widgets/auto_dismiss_dialog.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class InformasiTokoScreen extends StatefulWidget {
  final String initialNama;
  final String initialDeskripsi;
  final String initialTelepon;
  final String initialAlamat;
  final String initialStatus;

  const InformasiTokoScreen({
    super.key,
    this.initialNama = '',
    this.initialDeskripsi = '',
    this.initialTelepon = '',
    this.initialAlamat = '',
    this.initialStatus = '',
  });

  @override
  State<InformasiTokoScreen> createState() => _InformasiTokoScreenState();
}

class _InformasiTokoScreenState extends State<InformasiTokoScreen> {
  // Brand colors matching Figma exactly
  static const Color brandGreen = Color(0xFF9FC89F);
  static const Color textDarkGreen = Color(0xFF1F4827);
  static const Color inputBgColor = Color(0xFFF1EDED);
  static const Color disabledButtonColor = Color(0xFFF1EDED);
  static const Color disabledTextColor = Color(0xFF8E8E93);
  static const Color labelTextColor = Color(0xFF4A4A4A);
  static const Color successMintColor = Color(0xFF7CB88F);
  static const Color checkmarkGreen = Color(0xFF00AA5B);

  late TextEditingController _namaController;
  late TextEditingController _deskripsiController;
  late TextEditingController _teleponController;
  late TextEditingController _alamatController;

  String? _statusToko; // 'Buka' or 'Tutup'

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.initialNama);
    _deskripsiController = TextEditingController(text: widget.initialDeskripsi);
    _teleponController = TextEditingController(text: widget.initialTelepon);
    _alamatController = TextEditingController(text: widget.initialAlamat);
    _statusToko = widget.initialStatus.isNotEmpty ? widget.initialStatus : null;

    _namaController.addListener(_onFieldChanged);
    _deskripsiController.addListener(_onFieldChanged);
    _teleponController.addListener(_onFieldChanged);
    _alamatController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _namaController.removeListener(_onFieldChanged);
    _deskripsiController.removeListener(_onFieldChanged);
    _teleponController.removeListener(_onFieldChanged);
    _alamatController.removeListener(_onFieldChanged);

    _namaController.dispose();
    _deskripsiController.dispose();
    _teleponController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  bool get _isFormValid {
    return _namaController.text.trim().isNotEmpty &&
        _deskripsiController.text.trim().isNotEmpty &&
        _teleponController.text.trim().isNotEmpty &&
        _alamatController.text.trim().isNotEmpty &&
        (_statusToko != null && _statusToko!.isNotEmpty);
  }

  void _onStatusSelected(String status) {
    setState(() {
      _statusToko = status;
    });
  }

  void _onSimpanPressed() {
    if (!_isFormValid) return;

    // Unfocus keyboard so user can see full screen
    FocusScope.of(context).unfocus();

    // Show Success Dialog matching Image 2 exactly with auto-dismiss after ~1.8s
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AutoDismissDialog(
          duration: const Duration(milliseconds: 1800),
          child: Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/success_informasi_toko.png',
                    width: 240,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check,
                          color: checkmarkGreen,
                          size: 48,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Berhasil Menyimpan\nInformasi Toko',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Baloo Tammudu 2',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: successMintColor,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleBack() {
    Navigator.pop(context, {
      'nama': _namaController.text.trim(),
      'deskripsi': _deskripsiController.text.trim(),
      'telepon': _teleponController.text.trim(),
      'alamat': _alamatController.text.trim(),
      'status': _statusToko ?? '',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule ("Informasi Toko" with Back Button)
              PenjualCapsuleHeader(
                title: 'Informasi Toko',
                onBack: _handleBack,
              ),

              // 2. Form Content (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),

                      // FIELD 1: Nama Toko
                      _buildFieldLabel('Nama Toko'),
                      const SizedBox(height: 8),
                      _buildSingleLineInput(
                        controller: _namaController,
                        hintText: '',
                      ),
                      const SizedBox(height: 18),

                      // FIELD 2: Deskripsi Toko
                      _buildFieldLabel('Deskripsi Toko'),
                      const SizedBox(height: 8),
                      _buildMultiLineInput(
                        controller: _deskripsiController,
                        height: 120,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 18),

                      // FIELD 3: Nomor Telepon Toko
                      _buildFieldLabel('Nomor Telepon Toko'),
                      const SizedBox(height: 8),
                      _buildSingleLineInput(
                        controller: _teleponController,
                        hintText: '',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 18),

                      // FIELD 4: Alamat Toko
                      _buildFieldLabel('Alamat Toko'),
                      const SizedBox(height: 8),
                      _buildMultiLineInput(
                        controller: _alamatController,
                        height: 110,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 20),

                      // FIELD 5: Status Toko (Buka / Tutup buttons)
                      _buildFieldLabel('Status Toko'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatusButton(
                              label: 'Buka',
                              isSelected: _statusToko == 'Buka',
                              onTap: () => _onStatusSelected('Buka'),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildStatusButton(
                              label: 'Tutup',
                              isSelected: _statusToko == 'Tutup',
                              onTap: () => _onStatusSelected('Tutup'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),

                      // FIELD 6: Tombol Simpan
                      _buildSimpanButton(),
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

  /// Label Text with clean UI font matching Figma
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        color: labelTextColor,
        letterSpacing: -0.1,
      ),
    );
  }

  /// Single line capsule text field
  Widget _buildSingleLineInput({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            offset: Offset(0, 3),
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Multi line rounded rectangle text field
  Widget _buildMultiLineInput({
    required TextEditingController controller,
    required double height,
    required int maxLines,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            offset: Offset(0, 3),
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          height: 1.3,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: '',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Status Button ("Buka" / "Tutup") - turns green when selected
  Widget _buildStatusButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 52,
        decoration: BoxDecoration(
          color: isSelected ? brandGreen : inputBgColor,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color.fromRGBO(0, 0, 0, 0.18)
                  : const Color.fromRGBO(0, 0, 0, 0.12),
              offset: const Offset(0, 3),
              blurRadius: 6.0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isSelected ? textDarkGreen : labelTextColor,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }

  /// Simpan Button - Turns green when all fields are filled, dead-centered text
  Widget _buildSimpanButton() {
    final isValid = _isFormValid;

    return GestureDetector(
      onTap: isValid ? _onSimpanPressed : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: isValid ? brandGreen : disabledButtonColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: isValid
                  ? const Color.fromRGBO(0, 0, 0, 0.22)
                  : const Color.fromRGBO(0, 0, 0, 0.10),
              offset: const Offset(0, 4),
              blurRadius: 6.0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          'Simpan',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isValid ? textDarkGreen : disabledTextColor,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

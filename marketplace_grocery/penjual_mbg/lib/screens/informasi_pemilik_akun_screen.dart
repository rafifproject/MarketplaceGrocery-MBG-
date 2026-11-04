import 'package:flutter/material.dart';
import '../widgets/auto_dismiss_dialog.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class InformasiPemilikAkunScreen extends StatefulWidget {
  final String initialNama;
  final String initialTelepon;
  final String initialEmail;
  final String initialPassword;

  const InformasiPemilikAkunScreen({
    super.key,
    this.initialNama = '',
    this.initialTelepon = '',
    this.initialEmail = '',
    this.initialPassword = '',
  });

  @override
  State<InformasiPemilikAkunScreen> createState() =>
      _InformasiPemilikAkunScreenState();
}

class _InformasiPemilikAkunScreenState
    extends State<InformasiPemilikAkunScreen> {
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
  late TextEditingController _teleponController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _konfirmasiController;

  bool _obscurePassword = true;
  bool _obscureKonfirmasi = true;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.initialNama);
    _teleponController = TextEditingController(text: widget.initialTelepon);
    _emailController = TextEditingController(text: widget.initialEmail);
    _passwordController = TextEditingController(text: widget.initialPassword);
    _konfirmasiController = TextEditingController(text: widget.initialPassword);

    _namaController.addListener(_onFieldChanged);
    _teleponController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
    _konfirmasiController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _namaController.removeListener(_onFieldChanged);
    _teleponController.removeListener(_onFieldChanged);
    _emailController.removeListener(_onFieldChanged);
    _passwordController.removeListener(_onFieldChanged);
    _konfirmasiController.removeListener(_onFieldChanged);

    _namaController.dispose();
    _teleponController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  bool get _isPasswordMatch {
    return _passwordController.text == _konfirmasiController.text;
  }

  bool get _isFormValid {
    return _namaController.text.trim().isNotEmpty &&
        _teleponController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _konfirmasiController.text.isNotEmpty &&
        _isPasswordMatch;
  }

  Future<void> _onSimpanPressed() async {
    if (!_isPasswordMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sandi dan konfirmasi sandi harus sama'),
          backgroundColor: Color(0xFFD32F2F),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (!_isFormValid) return;

    // Unfocus keyboard
    FocusScope.of(context).unfocus();

    // Show Success Dialog matching Figma style with auto-dismiss after ~1.8s
    await showDialog(
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
                  // Thick Green Checkmark
                  Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE8F6ED),
                    ),
                    child: const Center(
                      child: Icon(Icons.check, color: checkmarkGreen, size: 38),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Success message
                  const Text(
                    'Berhasil Menyimpan\nInformasi Pemilik Akun',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Baloo Tammudu 2',
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: successMintColor,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (mounted) {
      _handleBack();
    }
  }

  void _handleBack() {
    Navigator.pop(context, {
      'nama': _namaController.text.trim(),
      'telepon': _teleponController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule ("Informasi Pemilik Akun" with Back Button)
              PenjualCapsuleHeader(
                title: 'Informasi Pemilik Akun',
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

                      // FIELD 1: Nama Lengkap
                      _buildFieldLabel('Nama Lengkap'),
                      const SizedBox(height: 8),
                      _buildSingleLineInput(
                        controller: _namaController,
                        hintText: '',
                      ),
                      const SizedBox(height: 18),

                      // FIELD 2: Nomor Telepon
                      _buildFieldLabel('Nomor Telepon'),
                      const SizedBox(height: 8),
                      _buildSingleLineInput(
                        controller: _teleponController,
                        hintText: '',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 18),

                      // FIELD 3: Email
                      _buildFieldLabel('Email'),
                      const SizedBox(height: 8),
                      _buildSingleLineInput(
                        controller: _emailController,
                        hintText: '',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 18),

                      // FIELD 4: Password
                      _buildFieldLabel('Password'),
                      const SizedBox(height: 8),
                      _buildPasswordInput(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onToggleVisibility: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      const SizedBox(height: 18),

                      // FIELD 5: Konfirmasi Password
                      _buildFieldLabel('Konfirmasi Password'),
                      const SizedBox(height: 8),
                      _buildPasswordInput(
                        controller: _konfirmasiController,
                        obscureText: _obscureKonfirmasi,
                        onToggleVisibility: () {
                          setState(() {
                            _obscureKonfirmasi = !_obscureKonfirmasi;
                          });
                        },
                      ),
                      if (_konfirmasiController.text.isNotEmpty &&
                          !_isPasswordMatch) ...[
                        const SizedBox(height: 6),
                        const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Text(
                            'Konfirmasi sandi tidak sesuai',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFD32F2F),
                            ),
                          ),
                        ),
                      ],
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
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Password capsule text field with visibility toggle icon
  Widget _buildPasswordInput({
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: '',
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: onToggleVisibility,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
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

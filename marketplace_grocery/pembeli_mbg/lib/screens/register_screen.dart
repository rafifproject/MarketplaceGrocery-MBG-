import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/google_account_sheet.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onGoToLogin;
  final VoidCallback? onLoginSuccess;

  const RegisterScreen({
    super.key,
    required this.onGoToLogin,
    this.onLoginSuccess,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showGoogleAccountPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => GoogleAccountSheet(
        onSelectAmba: () {
          Navigator.pop(bottomSheetContext);
          widget.onLoginSuccess?.call();
        },
      ),
    );
  }

  void _showSuccessDialog() {
    const goldAccent = Color(0xFFCD953B);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 42),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Green checkmark icon
                Image.asset(
                  'assets/images/ic_success_check.png',
                  width: 62,
                  height: 62,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),

                // Success title
                const Text(
                  'Yeay! Akun Anda\nberhasil terdaftar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6DA57E),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 24),

                // "Lanjutkan" button
                SizedBox(
                  width: 170,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext); // Close dialog
                      widget.onGoToLogin(); // Navigate back to Login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldAccent,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text(
                      'Lanjutkan',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
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

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF01A852);
    const titleColor = Color(0xFF9FC89F);
    const goldAccent = Color(0xFFCD953B);
    const googleBorderColor = Color(0xFFE0AA54);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: MbgBackground(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Bottom Grocery Basket Illustration
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Image.asset(
                  'assets/images/grocery_basket.png',
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // Top Header: Logo + "My Big Grocery"
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 12.0, right: 18.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: widget.onGoToLogin,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                height: 36,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'My Big Grocery',
                                style: TextStyle(
                                  color: brandGreen,
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Form Container
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24),

                          // Title "Daftar"
                          const Center(
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                color: titleColor,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 1. Username
                          _buildInputBox(
                            controller: _usernameController,
                            hintText: 'Username',
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 12),

                          // 2. Name
                          _buildInputBox(
                            controller: _nameController,
                            hintText: 'Name',
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 12),

                          // 3. Gmail / Nomor HP
                          _buildInputBox(
                            controller: _emailController,
                            hintText: 'Gmail / Nomor HP',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),

                          // 4. Password
                          _buildInputBox(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                size: 19,
                                color: const Color(0xFF888888),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 12),

                          // 5. Confirm password
                          _buildInputBox(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm password',
                            obscureText: _obscureConfirmPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                size: 19,
                                color: const Color(0xFF888888),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Divider: —— Daftar dengan ——
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: const Color(0xFF333333).withValues(alpha: 0.15),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Daftar dengan',
                                  style: TextStyle(
                                    color: brandGreen,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: const Color(0xFF333333).withValues(alpha: 0.15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Google Button
                          GestureDetector(
                            onTap: _showGoogleAccountPicker,
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: googleBorderColor,
                                  width: 1.2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Google',
                                  style: TextStyle(
                                    color: googleBorderColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Tombol Daftar
                          GestureDetector(
                            onTap: _showSuccessDialog,
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: goldAccent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Sudah punya akun? Masuk
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Sudah punya akun? ',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.onGoToLogin,
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    color: goldAccent,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        scrollPadding: EdgeInsets.zero,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 13.5,
          color: Color(0xFF222222),
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

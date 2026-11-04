import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';
import '../widgets/google_account_sheet.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onBackToOnboarding;
  final VoidCallback? onGoToRegister;
  final VoidCallback? onGoToForgotPassword;
  final VoidCallback? onLoginSuccess;

  const LoginScreen({
    super.key,
    this.onBackToOnboarding,
    this.onGoToRegister,
    this.onGoToForgotPassword,
    this.onLoginSuccess,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleMasuk() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    widget.onLoginSuccess?.call();
  }

  void _showGoogleAccountPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => GoogleAccountSheet(
        onSelectRusdi: () {
          Navigator.pop(bottomSheetContext);
          widget.onLoginSuccess?.call();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF01A852);
    const masukTitleColor = Color(0xFF9FC89F);
    const goldAccent = Color(0xFFCD953B);
    const googleBorderColor = Color(0xFFE0AA54);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: MbgBackground(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Bottom Grocery Basket Illustration (stays pinned at the bottom)
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
                          onTap: widget.onBackToOnboarding,
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

                  // Form Container
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 50),

                          // Title "Masuk"
                          const Center(
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                color: masukTitleColor,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Input: Gmail / Nomor HP
                          Container(
                            height: 48,
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
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              scrollPadding: EdgeInsets.zero,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onTapOutside: (_) => _emailFocusNode.unfocus(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF222222),
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: 'Gmail / Nomor HP',
                                hintStyle: TextStyle(
                                  color: Color(0xFF888888),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Input: Password
                          Container(
                            height: 48,
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
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              scrollPadding: EdgeInsets.zero,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              onTapOutside: (_) => _passwordFocusNode.unfocus(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF222222),
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Color(0xFF888888),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Lupa Password?
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: widget.onGoToForgotPassword,
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  color: goldAccent,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Divider: —— Masuk dengan ——
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: const Color(0xFF333333),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Masuk dengan',
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
                                  color: const Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Google Button (triggers Google Account Picker)
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

                          // Masuk Button
                          GestureDetector(
                            onTap: _handleMasuk,
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
                                  'Masuk',
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

                          // Belum punya akun? Daftar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Belum punya akun? ',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.onGoToRegister,
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: goldAccent,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
    );
  }
}

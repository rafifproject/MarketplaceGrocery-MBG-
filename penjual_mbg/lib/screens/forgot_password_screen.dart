import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

enum ForgotPasswordStep { email, pin, newPassword }

class ForgotPasswordScreen extends StatefulWidget {
  final VoidCallback onBackToLogin;

  const ForgotPasswordScreen({
    super.key,
    required this.onBackToLogin,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordStep _currentStep = ForgotPasswordStep.email;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  String _pin = '';
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _handleBack() {
    switch (_currentStep) {
      case ForgotPasswordStep.email:
        widget.onBackToLogin();
        break;
      case ForgotPasswordStep.pin:
        setState(() {
          _currentStep = ForgotPasswordStep.email;
        });
        break;
      case ForgotPasswordStep.newPassword:
        setState(() {
          _currentStep = ForgotPasswordStep.pin;
        });
        break;
    }
  }

  void _onKeypadTap(String val) {
    if (_pin.length < 6) {
      setState(() {
        _pin += val;
      });
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _showPinSuccessDialog() {
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
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 34),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Green checkmark
                Image.asset(
                  'assets/images/ic_success_check.png',
                  width: 72,
                  height: 72,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 28),

                // "Lanjutkan" button
                SizedBox(
                  width: 170,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext); // Close dialog
                      setState(() {
                        _currentStep = ForgotPasswordStep.newPassword;
                      });
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Ambient Gradient Background
          Positioned.fill(
            child: MbgBackground(
              child: const SizedBox.expand(),
            ),
          ),

          // Main Page Content with custom curved Header
          Column(
            children: [
              _buildTopHeader(),
              Expanded(
                child: _buildCurrentStepContent(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Top Curved Header Bar with Back Button and Title
  Widget _buildTopHeader() {
    const headerTitleColor = Color(0xFF5AB688);

    String title;
    switch (_currentStep) {
      case ForgotPasswordStep.email:
        title = 'Lupa Password';
        break;
      case ForgotPasswordStep.pin:
        title = 'Masukkan PIN';
        break;
      case ForgotPasswordStep.newPassword:
        title = 'Password Baru';
        break;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 14),
          child: Row(
            children: [
              // Back Button (circle with soft background and return arrow)
              GestureDetector(
                onTap: _handleBack,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5ECE8),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.reply_rounded,
                      color: Color(0xFF49C58B),
                      size: 22,
                    ),
                  ),
                ),
              ),

              // Title in Center
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: headerTitleColor,
                    letterSpacing: -0.2,
                  ),
                ),
              ),

              // Empty spacer to balance back button
              const SizedBox(width: 38),
            ],
          ),
        ),
      ),
    );
  }

  // Switch between Step 1, Step 2, and Step 3
  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case ForgotPasswordStep.email:
        return _buildEmailStep();
      case ForgotPasswordStep.pin:
        return _buildPinStep();
      case ForgotPasswordStep.newPassword:
        return _buildNewPasswordStep();
    }
  }

  // STEP 1: Input Gmail / Nomor HP
  Widget _buildEmailStep() {
    const goldAccent = Color(0xFFCD953B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 48,
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
              focusNode: _emailFocus,
              scrollPadding: EdgeInsets.zero,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                setState(() {
                  _currentStep = ForgotPasswordStep.pin;
                });
              },
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF222222),
              ),
              decoration: const InputDecoration(
                hintText: 'Gmail / Nomor HP',
                hintStyle: TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 120),

          // Tombol Masuk (posisi dan tampilan sama persis dengan yang di page new password)
          GestureDetector(
            onTap: () {
              setState(() {
                _currentStep = ForgotPasswordStep.pin;
              });
            },
            child: Container(
              height: 46,
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
        ],
      ),
    );
  }

  // STEP 2: Masukkan PIN (6 Kotak Digit + Tombol Lanjut + Custom Keypad)
  Widget _buildPinStep() {
    const goldAccent = Color(0xFFCD953B);

    return Column(
      children: [
        const SizedBox(height: 38),

        // 6 PIN digit boxes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              final digit = index < _pin.length ? _pin[index] : '';
              return Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  digit,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 38),

        // Tombol "Lanjut"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: GestureDetector(
            onTap: _showPinSuccessDialog,
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
                  'Lanjut',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),

        const Spacer(),

        // Bottom Custom Keypad
        _buildCustomKeypad(),
      ],
    );
  }

  // Custom Numeric Keypad Container
  Widget _buildCustomKeypad() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _buildKeypadKey('1'),
                const SizedBox(width: 14),
                _buildKeypadKey('2'),
                const SizedBox(width: 14),
                _buildKeypadKey('3'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildKeypadKey('4'),
                const SizedBox(width: 14),
                _buildKeypadKey('5'),
                const SizedBox(width: 14),
                _buildKeypadKey('6'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildKeypadKey('7'),
                const SizedBox(width: 14),
                _buildKeypadKey('8'),
                const SizedBox(width: 14),
                _buildKeypadKey('9'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildKeypadKey('ABC', isTextOnly: true),
                const SizedBox(width: 14),
                _buildKeypadKey('0'),
                const SizedBox(width: 14),
                _buildKeypadKey('', isBackspace: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadKey(
    String label, {
    bool isBackspace = false,
    bool isTextOnly = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isBackspace) {
            _onBackspace();
          } else if (!isTextOnly && label.isNotEmpty) {
            _onKeypadTap(label);
          }
        },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: isBackspace
              ? const Icon(
                  Icons.backspace_outlined,
                  size: 22,
                  color: Color(0xFF222222),
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: isTextOnly ? 14 : 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF222222),
                  ),
                ),
        ),
      ),
    );
  }

  // STEP 3: Password Baru & Tombol Masuk
  Widget _buildNewPasswordStep() {
    const goldAccent = Color(0xFFCD953B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Input Box "New password"
          Container(
            height: 48,
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
              controller: _newPasswordController,
              scrollPadding: EdgeInsets.zero,
              obscureText: _obscurePassword,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF222222),
              ),
              decoration: InputDecoration(
                hintText: 'New password',
                hintStyle: const TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 20,
                    color: const Color(0xFF888888),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 120),

          // Tombol "Masuk" -> kembali ke login awal
          GestureDetector(
            onTap: widget.onBackToLogin,
            child: Container(
              height: 46,
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
        ],
      ),
    );
  }
}

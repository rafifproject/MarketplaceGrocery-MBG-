import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../widgets/mbg_background.dart';
import 'alamat_saya_screen.dart';
import 'bahasa_screen.dart';
import 'kebijakan_privasi_screen.dart';
import 'pusat_bantuan_screen.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.onLogout,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User profile state variables
  String _nama = 'Amba';
  String _username = '@ambalohya56';
  String _noTelepon = '0812****7890';
  String _email = 'am******5@gmail.com';
  String _jenisKelamin = 'Atur Sekarang'; // or 'Laki-laki', 'Perempuan'

  // Generic Edit Bottom Sheet (for Nama, Username, No Telepon, Email)
  void _showEditFieldSheet({
    required String fieldTitle,
    required String initialValue,
    required String actionButtonText,
    required ValueChanged<String> onSaved,
  }) {
    final controller = TextEditingController(text: initialValue);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Rounded grey input field
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E8E8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Green Action Button
              GestureDetector(
                onTap: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    onSaved(text);
                  }
                  Navigator.pop(bottomSheetContext);
                },
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00B359),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    actionButtonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Gender Selection Bottom Sheet
  void _showGenderSelectionSheet() {
    String tempSelection = _jenisKelamin == 'Atur Sekarang' ? 'Laki-laki' : _jenisKelamin;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final tr = LanguageService.instance.tr;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Option 1: Laki-laki
                  GestureDetector(
                    onTap: () {
                      setSheetState(() {
                        tempSelection = 'Laki-laki';
                      });
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: tempSelection == 'Laki-laki'
                            ? const Color(0xFFA2DEBF)
                            : const Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        tr('Laki-laki', 'Male'),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Option 2: Perempuan
                  GestureDetector(
                    onTap: () {
                      setSheetState(() {
                        tempSelection = 'Perempuan';
                      });
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: tempSelection == 'Perempuan'
                            ? const Color(0xFFA2DEBF)
                            : const Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        tr('Perempuan', 'Female'),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Green Submit Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _jenisKelamin = tempSelection;
                      });
                      Navigator.pop(sheetContext);
                    },
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B359),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        tr('Ubah Jenis Kelamin', 'Change Gender'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Password Flow (PIN Verification -> Success Check Dialog -> New Password)
  void _openChangePasswordFlow() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileChangePasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.language,
      builder: (context, lang, _) {
        final tr = LanguageService.instance.tr;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Ambient Gradient Background
              Positioned.fill(
                child: MbgBackground(
                  child: const SizedBox.expand(),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    // Header Bar (Tanpa background rektanggel sesuai Figma)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 6),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Circular Back Button (Asset Asli Figma)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              behavior: HitTestBehavior.opaque,
                              child: Image.asset(
                                'assets/images/btn_back_circle.png',
                                width: 36,
                                height: 36,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          // Centered Title
                          Text(
                            tr('Profil Saya', 'My Profile'),
                            style: const TextStyle(
                              fontFamily: 'Baloo Tammudu 2',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5EC494),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable Profile Content
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Column(
                          children: [
                            // Section 1: Mint Card "Pengaturan Akun" with Avatar
                            _buildPengaturanAkunCard(tr),

                            const SizedBox(height: 12),

                            // Section 2: Mint Card "Informasi & Bantuan Tambahan"
                            _buildInformasiTambahanCard(tr),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Section 1 Card
  Widget _buildPengaturanAkunCard(String Function(String, String) tr) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFA5DCBF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Amba Profile Avatar with Edit Badge
          Center(
            child: Stack(
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/avatar_amba.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF00B359), width: 1.3),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 14.5,
                      color: Color(0xFF00B359),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Title: Pengaturan Akun
          Text(
            tr('Pengaturan Akun', 'Account Settings'),
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
          ),

          const SizedBox(height: 8),

          // 1. Nama
          _buildFieldPill(
            label: tr('Nama', 'Name'),
            value: _nama,
            onTap: () {
              _showEditFieldSheet(
                fieldTitle: tr('Nama', 'Name'),
                initialValue: _nama,
                actionButtonText: tr('Ubah Nama', 'Change Name'),
                onSaved: (val) {
                  setState(() => _nama = val);
                },
              );
            },
          ),

          const SizedBox(height: 6.5),

          // 2. Username
          _buildFieldPill(
            label: tr('Username', 'Username'),
            value: _username,
            onTap: () {
              _showEditFieldSheet(
                fieldTitle: tr('Username', 'Username'),
                initialValue: _username,
                actionButtonText: tr('Ubah Username', 'Change Username'),
                onSaved: (val) {
                  setState(() => _username = val);
                },
              );
            },
          ),

          const SizedBox(height: 6.5),

          // 3. No Telepon
          _buildFieldPill(
            label: tr('No Telepon', 'Phone Number'),
            value: _noTelepon,
            onTap: () {
              _showEditFieldSheet(
                fieldTitle: tr('No Telepon', 'Phone Number'),
                initialValue: _noTelepon,
                actionButtonText: tr('Ubah No Telepon', 'Change Phone Number'),
                onSaved: (val) {
                  setState(() => _noTelepon = val);
                },
              );
            },
          ),

          const SizedBox(height: 6.5),

          // 4. Email
          _buildFieldPill(
            label: tr('Email', 'Email'),
            value: _email,
            onTap: () {
              _showEditFieldSheet(
                fieldTitle: tr('Email', 'Email'),
                initialValue: _email,
                actionButtonText: tr('Ubah Email', 'Change Email'),
                onSaved: (val) {
                  setState(() => _email = val);
                },
              );
            },
          ),

          const SizedBox(height: 6.5),

          // 5. Jenis Kelamin
          _buildFieldPill(
            label: tr('Jenis Kelamin', 'Gender'),
            value: _jenisKelamin == 'Atur Sekarang'
                ? tr('Atur Sekarang', 'Set Now')
                : (_jenisKelamin == 'Laki-laki' ? tr('Laki-laki', 'Male') : tr('Perempuan', 'Female')),
            onTap: _showGenderSelectionSheet,
          ),

          const SizedBox(height: 6.5),

          // 6. Password
          _buildFieldPill(
            label: tr('Password', 'Password'),
            value: '${tr('Ubah', 'Change')} >',
            onTap: _openChangePasswordFlow,
          ),
        ],
      ),
    );
  }

  // Section 2 Card
  Widget _buildInformasiTambahanCard(String Function(String, String) tr) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFA5DCBF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title: Informasi & Bantuan Tambahan
          Text(
            tr('Informasi & Bantuan Tambahan', 'Additional Info & Help'),
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
          ),

          const SizedBox(height: 8),

          // 1. Alamat Saya
          _buildFieldPill(
            label: tr('Alamat Saya', 'My Address'),
            value: '',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AlamatSayaScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 6.5),

          // 2. Bahasa / Language
          _buildFieldPill(
            label: 'Bahasa / Language',
            value: LanguageService.instance.isEnglish ? 'Bahasa Inggris' : 'Bahasa Indonesia',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BahasaScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 6.5),

          // 3. Pusat Bantuan / FAQ
          _buildFieldPill(
            label: tr('Pusat Bantuan / FAQ', 'Help Center / FAQ'),
            value: '>',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PusatBantuanScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 6.5),

          // 4. Kebijakan Privasi/ Syarat & Ketentuan
          _buildFieldPill(
            label: tr('Kebijakan Privasi/ Syarat & Ketentuan', 'Privacy Policy / Terms'),
            value: '>',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KebijakanPrivasiScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 6.5),

          // 5. Log Out
          _buildFieldPill(
            label: tr('Log Out', 'Log Out'),
            value: '',
            onTap: () {
              final topOffset = MediaQuery.of(context).padding.top + 273;

              showDialog(
                context: context,
                barrierColor: Colors.black.withValues(alpha: 0.15),
                builder: (dialogCtx) => Material(
                  type: MaterialType.transparency,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: topOffset),
                      child: Container(
                        width: 151,
                        height: 76,
                        padding: const EdgeInsets.only(top: 14, bottom: 11),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('Yakin ingin keluar?', 'Are you sure to logout?'),
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                            SizedBox(
                              width: 151,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(dialogCtx);
                                        Navigator.pop(context); // Pop profile
                                        widget.onLogout();
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Center(
                                        child: Text(
                                          tr('Ya', 'Yes'),
                                          style: const TextStyle(
                                            color: Color(0xFFFF3030),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 22,
                                    color: const Color(0xFFD9D9D9),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => Navigator.pop(dialogCtx),
                                      behavior: HitTestBehavior.opaque,
                                      child: Center(
                                        child: Text(
                                          tr('Tidak', 'No'),
                                          style: const TextStyle(
                                            color: Color(0xFF9E9E9E),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Pill item widget (Proporsi presisi sesuai Figma)
  Widget _buildFieldPill({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              blurRadius: 3.5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF444444),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Password Change Flow (PIN Keypad -> Checklist Dialog -> New Password Form)
class ProfileChangePasswordScreen extends StatefulWidget {
  const ProfileChangePasswordScreen({super.key});

  @override
  State<ProfileChangePasswordScreen> createState() => _ProfileChangePasswordScreenState();
}

class _ProfileChangePasswordScreenState extends State<ProfileChangePasswordScreen> {
  bool _isNewPasswordStep = false;
  String _pin = '';
  final TextEditingController _passwordController = TextEditingController();
  final bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onKeypadTap(String val) {
    if (_pin.length < 6) {
      setState(() {
        _pin += val;
      });
      if (_pin.length == 6) {
        // Auto trigger or allow user to click Lanjut
      }
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final tr = LanguageService.instance.tr;

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
                // Green checkmark asset
                Image.asset(
                  'assets/images/ic_success_check.png',
                  width: 72,
                  height: 72,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 28),

                // "Lanjutkan" button (Gold Accent)
                SizedBox(
                  width: 170,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext); // Close dialog
                      setState(() {
                        _isNewPasswordStep = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCD953B),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: Text(
                      tr('Lanjutkan', 'Continue'),
                      style: const TextStyle(
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

  // Top Curved Header matching Figma
  Widget _buildTopHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
        boxShadow: [
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (_isNewPasswordStep) {
                      setState(() => _isNewPasswordStep = false);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEF),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/kategori_back_arrow.png',
                      width: 20,
                      height: 20,
                      color: const Color(0xFF5EC494),
                    ),
                  ),
                ),
              ),

              const Text(
                'Password',
                style: TextStyle(
                  fontFamily: 'Baloo Tammudu 2',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5EC494),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.language,
      builder: (context, lang, _) {
        final tr = LanguageService.instance.tr;

        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              // Ambient Background
              Positioned.fill(
                child: MbgBackground(
                  child: const SizedBox.expand(),
                ),
              ),

              Column(
                children: [
                  // Top Curved Header
                  _buildTopHeader(),

                  Expanded(
                    child: _isNewPasswordStep
                        ? _buildNewPasswordStep(tr)
                        : _buildPinStep(tr),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // STEP 1: PIN Step with 6 boxes & keypad
  Widget _buildPinStep(String Function(String, String) tr) {
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

        // Button "Lanjut" (Gold Accent)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: GestureDetector(
            onTap: () {
              if (_pin.length == 6) {
                _showPinSuccessDialog();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr('Masukkan 6 digit PIN terlebih dahulu', 'Please enter 6-digit PIN first')),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
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
              child: Center(
                child: Text(
                  tr('Lanjut', 'Continue'),
                  style: const TextStyle(
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

  // Keypad
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
                    fontSize: isTextOnly ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF222222),
                  ),
                ),
        ),
      ),
    );
  }

  // STEP 2: Password Baru Input & Button Lanjut (Persis Mockup Gambar)
  Widget _buildNewPasswordStep(String Function(String, String) tr) {
    const goldAccent = Color(0xFFCD953B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Input Box "New Password"
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E2E2),
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
              obscureText: _obscurePassword,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF222222),
              ),
              decoration: const InputDecoration(
                hintText: 'New Password',
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

          const SizedBox(height: 130),

          // Tombol "Lanjut" (Gold Accent) Sesuai Gambar
          GestureDetector(
            onTap: () {
              if (_passwordController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr('Masukkan sandi terbaru Anda', 'Please enter your new password')),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(tr('Password berhasil diubah!', 'Password changed successfully!')),
                  backgroundColor: const Color(0xFF00B359),
                  duration: const Duration(seconds: 2),
                ),
              );

              Navigator.pop(context); // Kembali ke ProfileScreen
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
              child: Center(
                child: Text(
                  tr('Lanjut', 'Continue'),
                  style: const TextStyle(
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

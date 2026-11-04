import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'informasi_toko_screen.dart';
import 'informasi_pemilik_akun_screen.dart';
import 'keuangan_pembayaran_screen.dart';
import 'bantuan_pengaturan_screen.dart';

class PenjualProfileScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const PenjualProfileScreen({
    super.key,
    required this.onLogout,
  });

  @override
  State<PenjualProfileScreen> createState() => _PenjualProfileScreenState();
}

class _PenjualProfileScreenState extends State<PenjualProfileScreen> {
  // Brand colors
  static const Color textDarkGreen = Color(0xFF1F4827);
  static const Color buttonBgColor = Color(0xFFF1EDED);

  // Store & Owner Information state
  String _namaToko = '';
  String _deskripsiToko = '';
  String _noTeleponToko = '';
  String _alamatToko = '';
  String _statusToko = '';

  String _namaPemilik = '';
  String _noTelepon = '';
  String _email = '';
  String _password = '';

  String _currentLanguage = 'Bahasa Indonesia';

  File? _avatarFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAvatar() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _avatarFile = File(picked.path);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto profil berhasil diperbarui!'),
              backgroundColor: Color(0xFF00AA5B),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih foto: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _showInformasiUtamaToko() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => InformasiTokoScreen(
          initialNama: _namaToko,
          initialDeskripsi: _deskripsiToko,
          initialTelepon: _noTeleponToko,
          initialAlamat: _alamatToko,
          initialStatus: _statusToko,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        if (result['nama'] != null && (result['nama'] as String).isNotEmpty) {
          _namaToko = result['nama'];
        }
        if (result['deskripsi'] != null && (result['deskripsi'] as String).isNotEmpty) {
          _deskripsiToko = result['deskripsi'];
        }
        if (result['telepon'] != null && (result['telepon'] as String).isNotEmpty) {
          _noTeleponToko = result['telepon'];
        }
        if (result['alamat'] != null && (result['alamat'] as String).isNotEmpty) {
          _alamatToko = result['alamat'];
        }
        if (result['status'] != null && (result['status'] as String).isNotEmpty) {
          _statusToko = result['status'];
        }
      });
    }
  }

  Future<void> _showInformasiPemilikAkun() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => InformasiPemilikAkunScreen(
          initialNama: _namaPemilik,
          initialTelepon: _noTelepon,
          initialEmail: _email,
          initialPassword: _password,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        if (result['nama'] != null && (result['nama'] as String).isNotEmpty) {
          _namaPemilik = result['nama'];
        }
        if (result['telepon'] != null && (result['telepon'] as String).isNotEmpty) {
          _noTelepon = result['telepon'];
        }
        if (result['email'] != null && (result['email'] as String).isNotEmpty) {
          _email = result['email'];
        }
        if (result['password'] != null && (result['password'] as String).isNotEmpty) {
          _password = result['password'];
        }
      });
    }
  }

  void _showKeuanganPembayaran() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const KeuanganPembayaranScreen(),
      ),
    );
  }

  void _showBantuanPengaturan() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BantuanPengaturanScreen(),
      ),
    );
  }

  void _showBahasaSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Bahasa / Language',
                  style: TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDarkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text('Bahasa Indonesia'),
                  trailing: _currentLanguage == 'Bahasa Indonesia'
                      ? const Icon(Icons.check_circle, color: Color(0xFF00AA5B))
                      : null,
                  onTap: () {
                    setState(() => _currentLanguage = 'Bahasa Indonesia');
                    Navigator.pop(ctx);
                    _showSuccessToast('Bahasa diubah ke Bahasa Indonesia');
                  },
                ),
                ListTile(
                  title: const Text('English (US)'),
                  trailing: _currentLanguage == 'English (US)'
                      ? const Icon(Icons.check_circle, color: Color(0xFF00AA5B))
                      : null,
                  onTap: () {
                    setState(() => _currentLanguage = 'English (US)');
                    Navigator.pop(ctx);
                    _showSuccessToast('Language changed to English');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Konfirmasi Keluar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Apakah Anda yakin ingin keluar dari akun toko?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
                widget.onLogout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF00AA5B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Top Capsule Header: "Profil"
              PenjualCapsuleHeader(
                title: 'Profil',
                onBack: () => Navigator.pop(context),
              ),

              // 2. Profile Content (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 14),

                      // Circular Avatar with Green Border & Edit Badge
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Circular Avatar
                            GestureDetector(
                              onTap: _pickAvatar,
                              child: Container(
                                width: 116,
                                height: 116,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF00AA5B),
                                    width: 3.0,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.18),
                                      offset: Offset(0, 4),
                                      blurRadius: 8.0,
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: _avatarFile != null
                                    ? Image.file(_avatarFile!, fit: BoxFit.cover)
                                    : Image.asset(
                                        'assets/images/avatar_seller_figma.png',
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                              ),
                            ),

                            // Small Edit Icon Badge (Bottom-Right of Avatar)
                            Positioned(
                              right: 2,
                              bottom: 4,
                              child: GestureDetector(
                                onTap: _pickAvatar,
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                      color: const Color(0xFF00AA5B),
                                      width: 1.5,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.20),
                                        offset: Offset(0, 2),
                                        blurRadius: 4.0,
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    size: 16,
                                    color: Color(0xFF00AA5B),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),

                      // MENU PILL 1: Informasi Utama Toko
                      _buildProfileMenuPill(
                        title: 'Informasi Utama Toko',
                        onTap: _showInformasiUtamaToko,
                      ),
                      const SizedBox(height: 11),

                      // MENU PILL 2: Informasi Pemilik Akun
                      _buildProfileMenuPill(
                        title: 'Informasi Pemilik Akun',
                        onTap: _showInformasiPemilikAkun,
                      ),
                      const SizedBox(height: 11),

                      // MENU PILL 3: Keuangan & Pembayaran
                      _buildProfileMenuPill(
                        title: 'Keuangan & Pembayaran',
                        onTap: _showKeuanganPembayaran,
                      ),
                      const SizedBox(height: 11),

                      // MENU PILL 4: Bantuan & Pengaturan Lainnya
                      _buildProfileMenuPill(
                        title: 'Bantuan & Pengaturan Lainnya',
                        onTap: _showBantuanPengaturan,
                      ),
                      const SizedBox(height: 11),

                      // MENU PILL 5: Bahasa/Language
                      _buildProfileMenuPill(
                        title: 'Bahasa/Language',
                        onTap: _showBahasaSelection,
                      ),
                      const SizedBox(height: 11),

                      // MENU PILL 6: Log Out
                      _buildProfileMenuPill(
                        title: 'Log Out',
                        onTap: _confirmLogout,
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

  /// Single Profile Capsule Menu Pill matching Figma exactly
  Widget _buildProfileMenuPill({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: buttonBgColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            color: textDarkGreen,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

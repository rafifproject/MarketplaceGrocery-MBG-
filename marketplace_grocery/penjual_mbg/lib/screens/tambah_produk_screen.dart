import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';

class TambahProdukScreen extends StatefulWidget {
  const TambahProdukScreen({super.key});

  @override
  State<TambahProdukScreen> createState() => _TambahProdukScreenState();
}

class _TambahProdukScreenState extends State<TambahProdukScreen> {
  // Brand colors matching the app exactly
  static const Color brandGreen = Color(0xFF9FC89F);
  static const Color textDarkGreen = Color(0xFF1F4827);
  static const Color disabledButtonColor = Color(0xFFEBEBEB);
  static const Color disabledTextColor = Color(0xFFA6A6A6);
  static const Color inputBgColor = Color(0xFFF1EDED);
  static const Color labelTextColor = Color(0xFF4A4A4A);

  // Form controllers
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  // Image state: can be a picked File or a selected asset path
  File? _imageFile;
  String? _assetImagePath;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _namaController.addListener(_onFormFieldChanged);
    _hargaController.addListener(_onFormFieldChanged);
    _deskripsiController.addListener(_onFormFieldChanged);
  }

  @override
  void dispose() {
    _namaController.removeListener(_onFormFieldChanged);
    _hargaController.removeListener(_onFormFieldChanged);
    _deskripsiController.removeListener(_onFormFieldChanged);
    _namaController.dispose();
    _hargaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _onFormFieldChanged() {
    setState(() {});
  }

  bool get _isImageUploaded => _imageFile != null || _assetImagePath != null;

  bool get _isFormValid {
    return _isImageUploaded &&
        _namaController.text.trim().isNotEmpty &&
        _hargaController.text.trim().isNotEmpty &&
        _deskripsiController.text.trim().isNotEmpty;
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _imageFile = File(picked.path);
          _assetImagePath = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil gambar: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _showImagePickerSheet() {
    // List of pre-installed product assets for convenience
    final sampleAssets = [
      {'name': 'Wagyu Pack', 'path': 'assets/images/product_wagyu_pack.png'},
      {'name': 'Wagyu A5', 'path': 'assets/images/product_wagyu.png'},
      {'name': 'Beef Angus', 'path': 'assets/images/product_angus_ribeye.png'},
      {'name': 'Sirloin Steak', 'path': 'assets/images/product_sirloin_steak.png'},
      {'name': 'Yoshinoya Slice', 'path': 'assets/images/product_beef_slice.png'},
      {'name': 'Iga Sapi', 'path': 'assets/images/product_iga_sapi_potong.png'},
      {'name': 'Ayam Broiler', 'path': 'assets/images/daging_ayam_boiler.png'},
      {'name': 'Salmon Segar', 'path': 'assets/images/seafood_salmon.png'},
      {'name': 'Kangkung Segar', 'path': 'assets/images/sayur_kangkung.png'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  'Upload Foto Produk',
                  style: TextStyle(
                    fontFamily: 'Baloo Tammudu 2',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDarkGreen,
                  ),
                ),
                const SizedBox(height: 14),
                // Featured Wagyu Pack Option
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EDED),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: brandGreen, width: 1.5),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/product_wagyu_pack.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: const Text(
                      'Foto Wagyu Pack',
                      style: TextStyle(
                        fontFamily: 'Baloo Tammudu 2',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textDarkGreen,
                      ),
                    ),
                    subtitle: const Text(
                      'Pilihan gambar paket Wagyu',
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: brandGreen,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'Pilih',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textDarkGreen,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _assetImagePath = 'assets/images/product_wagyu_pack.png';
                        _imageFile = null;
                      });
                      Navigator.pop(ctx);
                    },
                  ),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: brandGreen.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, color: textDarkGreen),
                  ),
                  title: const Text('Ambil Foto Kamera'),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImageFromSource(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: brandGreen.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.photo_library, color: textDarkGreen),
                  ),
                  title: const Text('Pilih dari Galeri'),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImageFromSource(ImageSource.gallery);
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Atau pilih dari sampel katalog lainnya:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: sampleAssets.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, idx) {
                      final item = sampleAssets[idx];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _assetImagePath = item['path'];
                            _imageFile = null;
                          });
                          Navigator.pop(ctx);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.5,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                item['path']!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.image),
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 65,
                              child: Text(
                                item['name']!,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onTambahKatalogPressed() {
    if (!_isFormValid) return;

    final nama = _namaController.text.trim();
    final hargaText = _hargaController.text.trim();
    final deskripsi = _deskripsiController.text.trim();

    // Clean price string
    final cleanPrice = hargaText.replaceAll(RegExp(r'[^0-9]'), '');
    final priceNumber = int.tryParse(cleanPrice) ?? 0;
    final formattedPrice = 'Rp${cleanPrice.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    )}';

    // Split name into 2 lines if possible
    String titleLine1 = nama;
    String titleLine2 = '-';
    final words = nama.split(' ');
    if (words.length > 2) {
      titleLine1 = words.take(2).join(' ');
      titleLine2 = words.skip(2).join(' ');
    }

    final newProduct = <String, dynamic>{
      'titleLine1': titleLine1,
      'titleLine2': titleLine2,
      'titleLine3': null,
      'image': _assetImagePath ?? (_imageFile?.path ?? 'assets/images/product_wagyu_pack.png'),
      'imageFile': _imageFile,
      'price': formattedPrice,
      'priceNumber': priceNumber,
      'sold': '0 Terjual',
      'stockPcs': 20,
      'rating': '5.0',
      'location': 'Blang Pulo',
      'hasGratisOngkir': true,
      'stock': 20,
      'description': deskripsi,
    };

    Navigator.pop(context, newProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Top Capsule Header: "Masukkan Produk"
              PenjualCapsuleHeader(
                title: 'Masukkan Produk',
                onBack: () => Navigator.pop(context),
              ),

              // 2. Form Content (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),

                      // FIELD 1: Foto Produk *Maksimal Satu
                      _buildFieldLabel('Foto Produk *Maksimal Satu'),
                      const SizedBox(height: 8),
                      _buildPhotoUploadBox(),
                      const SizedBox(height: 18),

                      // FIELD 2: Nama Produk
                      _buildFieldLabel('Nama Produk'),
                      const SizedBox(height: 8),
                      _buildTextInputBox(
                        controller: _namaController,
                        hintText: '',
                      ),
                      const SizedBox(height: 18),

                      // FIELD 3: Harga
                      _buildFieldLabel('Harga'),
                      const SizedBox(height: 8),
                      _buildTextInputBox(
                        controller: _hargaController,
                        hintText: '',
                        keyboardType: TextInputType.number,
                        isPrice: true,
                      ),
                      const SizedBox(height: 18),

                      // FIELD 4: Deskripsi
                      _buildFieldLabel('Deskripsi'),
                      const SizedBox(height: 8),
                      _buildDeskripsiBox(),
                      const SizedBox(height: 28),

                      // BUTTON: Tambah Katalog (Kapsul berubah hijau saat semua terisi)
                      _buildTambahKatalogButton(),
                      const SizedBox(height: 32),
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

  /// Field Label styling matching Figma
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: 'Baloo Tammudu 2',
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: labelTextColor,
        letterSpacing: -0.2,
      ),
    );
  }

  /// Photo Upload Box matching Figma
  Widget _buildPhotoUploadBox() {
    if (_isImageUploaded) {
      // Preview when image is uploaded
      return Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: inputBgColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 3),
              blurRadius: 6.0,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: _imageFile != null
                  ? Image.file(_imageFile!, fit: BoxFit.cover)
                  : Image.asset(_assetImagePath!, fit: BoxFit.cover),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _showImagePickerSheet,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: textDarkGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _imageFile = null;
                        _assetImagePath = null;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Default Empty Capsule matching Figma
    return GestureDetector(
      onTap: _showImagePickerSheet,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 54,
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
        alignment: Alignment.center,
        child: const Icon(
          Icons.camera_alt_outlined,
          size: 28,
          color: Color(0xFF222222),
        ),
      ),
    );
  }

  /// Single line rounded capsule input
  Widget _buildTextInputBox({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isPrice = false,
  }) {
    return Container(
      width: double.infinity,
      height: 54,
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF222222),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: hintText,
          prefixText: isPrice && controller.text.isNotEmpty && !controller.text.startsWith('Rp')
              ? 'Rp '
              : null,
          prefixStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF222222),
          ),
        ),
      ),
    );
  }

  /// Multiline description container matching Figma
  Widget _buildDeskripsiBox() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(0, 3),
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: TextField(
        controller: _deskripsiController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF222222),
          height: 1.35,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }

  /// Tambah Katalog Button matching Figma:
  /// Gray when not ready, Brand Green when all inputs + image are filled!
  Widget _buildTambahKatalogButton() {
    final isValid = _isFormValid;

    return GestureDetector(
      onTap: isValid ? _onTambahKatalogPressed : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeInOut,
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
          'Tambah Katalog',
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

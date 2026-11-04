import 'package:flutter/material.dart';
import '../services/address_service.dart';
import '../services/language_service.dart';
import '../widgets/mbg_background.dart';

class FormAlamatScreen extends StatefulWidget {
  final bool isEdit;
  final String? addressId;
  final String? initialNama;
  final String? initialPhone;
  final String? initialArea;
  final String? initialStreet;
  final String? initialDetail;

  const FormAlamatScreen({
    super.key,
    required this.isEdit,
    this.addressId,
    this.initialNama,
    this.initialPhone,
    this.initialArea,
    this.initialStreet,
    this.initialDetail,
  });

  @override
  State<FormAlamatScreen> createState() => _FormAlamatScreenState();
}

class _FormAlamatScreenState extends State<FormAlamatScreen> {
  late final TextEditingController _namaController;
  late final TextEditingController _phoneController;
  late final TextEditingController _areaController;
  late final TextEditingController _streetController;
  late final TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(
      text: widget.isEdit ? (widget.initialNama ?? 'Amba') : '',
    );
    _phoneController = TextEditingController(
      text: widget.isEdit ? (widget.initialPhone ?? '0812****7890') : '',
    );
    _areaController = TextEditingController(
      text: widget.isEdit
          ? (widget.initialArea ??
              'NANGROE ACEH DARUSSALAM (NAD)\nKAB.ACEH UTARA\nMUARA BATU\n24355')
          : '',
    );
    _streetController = TextEditingController(
      text: widget.isEdit
          ? (widget.initialStreet ??
              'Sakinah Kos, Jl. Pulo Reuleut Tim., Kec. Muara Batu,\nKabupaten Aceh Utara, Aceh')
          : '',
    );
    _detailController = TextEditingController(
      text: widget.isEdit ? (widget.initialDetail ?? 'Dekat melati kost') : '',
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _phoneController.dispose();
    _areaController.dispose();
    _streetController.dispose();
    _detailController.dispose();
    super.dispose();
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
              // Ambient Background
              Positioned.fill(
                child: MbgBackground(
                  child: const SizedBox.expand(),
                ),
              ),

              Column(
                children: [
                  // Top Curved Header Bar with Drop Shadow (Sesuai Figma)
                  Container(
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

                            // Centered Title: "Ubah Alamat" atau "Tambah Alamat"
                            Text(
                              widget.isEdit
                                  ? tr('Ubah Alamat', 'Edit Address')
                                  : tr('Tambah Alamat', 'Add Address'),
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
                    ),
                  ),

                  // Form Container (Sesuaikan space paragraf & ukuran rektanggel sesuai Figma 100%)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBFBFB),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.12),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Nama Lengkap
                            _buildFormField(
                              label: tr('Nama Lengkap', 'Full Name'),
                              controller: _namaController,
                            ),
                            const SizedBox(height: 14),

                            // 2. Nomor Telepon
                            _buildFormField(
                              label: tr('Nomor Telepon', 'Phone Number'),
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 14),

                            // 3. Provinsi, Kota, Kecamatan, Kode Pos (4 baris sesuai Figma)
                            _buildFormField(
                              label: tr('Provinsi, Kota, Kecamatan, Kode Pos', 'Province, City, District, Postal Code'),
                              controller: _areaController,
                              minLines: 4,
                              maxLines: 5,
                            ),
                            const SizedBox(height: 14),

                            // 4. Nama Jalan, Gedung, No.Rumah (2 baris sesuai Figma)
                            _buildFormField(
                              label: tr('Nama Jalan, Gedung, No.Rumah', 'Street Name, Building, House No.'),
                              controller: _streetController,
                              minLines: 2,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 14),

                            // 5. Detail (Lainnya)
                            _buildFormField(
                              label: tr('Detail (Lainnya)', 'Details (Other)'),
                              controller: _detailController,
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Action Buttons (Simpan & Hapus Sesuai Figma)
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
                      child: Row(
                        children: [
                          // Button Simpan (White background, Green outline)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                final nama = _namaController.text.trim().isEmpty
                                    ? 'Amba'
                                    : _namaController.text.trim();
                                final phone = _phoneController.text.trim().isEmpty
                                    ? '0812****7890'
                                    : _phoneController.text.trim();
                                final area = _areaController.text.trim().isEmpty
                                    ? 'MUARA BATU, KOTA LHOKSEUMAWE, NAD, 24355'
                                    : _areaController.text.trim();
                                final street = _streetController.text.trim().isEmpty
                                    ? 'Sakinah Kos, Jl. Pulo Reuleut Tim.'
                                    : _streetController.text.trim();
                                final detail = _detailController.text.trim();

                                if (widget.isEdit && widget.addressId != null) {
                                  AddressService.instance.updateAddress(
                                    id: widget.addressId!,
                                    nama: nama,
                                    phone: phone,
                                    area: area,
                                    street: street,
                                    detail: detail,
                                  );
                                } else {
                                  AddressService.instance.addAddress(
                                    nama: nama,
                                    phone: phone,
                                    area: area,
                                    street: street,
                                    detail: detail,
                                    setAsUtama: false,
                                  );
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      widget.isEdit
                                          ? tr('Alamat berhasil diperbarui!', 'Address updated successfully!')
                                          : tr('Alamat baru berhasil ditambahkan!', 'New address added successfully!'),
                                    ),
                                    backgroundColor: const Color(0xFF00B359),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF00B359), width: 1.5),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      blurRadius: 4,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  tr('Simpan', 'Save'),
                                  style: const TextStyle(
                                    color: Color(0xFF00B359),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          // Button Hapus (Solid Green Sesuai Figma)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.isEdit && widget.addressId != null) {
                                  AddressService.instance.deleteAddress(widget.addressId!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        tr('Alamat berhasil dihapus!', 'Address deleted successfully!'),
                                      ),
                                      backgroundColor: const Color(0xFF00B359),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                                Navigator.pop(context);
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
                                  widget.isEdit ? tr('Hapus', 'Delete') : tr('Hapus', 'Delete'),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int minLines = 1,
    int maxLines = 1,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF757575),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 3),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 13.5,
            color: Color(0xFF1E1E1E),
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 2),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 1,
          color: const Color(0xFFE8E8E8),
        ),
      ],
    );
  }
}

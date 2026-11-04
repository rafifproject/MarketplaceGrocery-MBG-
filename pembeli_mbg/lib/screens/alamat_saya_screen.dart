import 'package:flutter/material.dart';
import '../services/address_service.dart';
import '../services/language_service.dart';
import '../widgets/mbg_background.dart';
import 'form_alamat_screen.dart';

class AlamatSayaScreen extends StatelessWidget {
  const AlamatSayaScreen({super.key});

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

                            // Centered Title
                            Text(
                              tr('Alamat Saya', 'My Address'),
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

                  const SizedBox(height: 16),

                  // Dynamic Address List
                  Expanded(
                    child: ValueListenableBuilder<List<AddressItem>>(
                      valueListenable: AddressService.instance.addresses,
                      builder: (context, addresses, _) {
                        if (addresses.isEmpty) {
                          return Center(
                            child: Text(
                              tr('Belum ada alamat tersimpan', 'No saved addresses yet'),
                              style: const TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 14,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            final item = addresses[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: GestureDetector(
                                onTap: () {
                                  // Tapping card opens edit form
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FormAlamatScreen(
                                        isEdit: true,
                                        addressId: item.id,
                                        initialNama: item.nama,
                                        initialPhone: item.phone,
                                        initialArea: item.area,
                                        initialStreet: item.street,
                                        initialDetail: item.detail,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEBEBEB),
                                    borderRadius: BorderRadius.circular(12),
                                    border: item.isUtama
                                        ? Border.all(color: const Color(0xFF00B359), width: 1.2)
                                        : Border.all(color: Colors.transparent, width: 1.2),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            item.nama,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            width: 1,
                                            height: 14,
                                            color: const Color(0xFF888888),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            item.phone,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                            ),
                                          ),
                                          const Spacer(),
                                          if (item.isUtama) ...[
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => FormAlamatScreen(
                                                      isEdit: true,
                                                      addressId: item.id,
                                                      initialNama: item.nama,
                                                      initialPhone: item.phone,
                                                      initialArea: item.area,
                                                      initialStreet: item.street,
                                                      initialDetail: item.detail,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                tr('Utama', 'Main'),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF00B359),
                                                ),
                                              ),
                                            ),
                                          ] else ...[
                                            // Tombol untuk memilih alamat ini sebagai yang aktif/utama
                                            GestureDetector(
                                              onTap: () {
                                                AddressService.instance.setUtama(item.id);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      tr(
                                                        'Alamat utama berhasil dipilih!',
                                                        'Main address selected!',
                                                      ),
                                                    ),
                                                    backgroundColor: const Color(0xFF00B359),
                                                    duration: const Duration(seconds: 1),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 3,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(6),
                                                  border: Border.all(
                                                    color: const Color(0xFF00B359),
                                                    width: 1.2,
                                                  ),
                                                ),
                                                child: Text(
                                                  tr('Pilih Alamat', 'Select'),
                                                  style: const TextStyle(
                                                    fontSize: 11.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF00B359),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.formattedDisplayAddress,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          height: 1.35,
                                          color: Color(0xFF222222),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // "Tambah Alamat Baru" Button (Pinned at Bottom)
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FormAlamatScreen(isEdit: false),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00B359),
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
                            tr('Tambah Alamat Baru', 'Add New Address'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
}

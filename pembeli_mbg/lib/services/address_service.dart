import 'package:flutter/foundation.dart';

class AddressItem {
  final String id;
  String nama;
  String phone;
  String area;
  String street;
  String detail;
  bool isUtama;

  AddressItem({
    required this.id,
    required this.nama,
    required this.phone,
    required this.area,
    required this.street,
    required this.detail,
    this.isUtama = false,
  });

  String get formattedDisplayAddress {
    final buffer = StringBuffer();
    if (street.isNotEmpty) {
      buffer.write(street);
    }
    if (detail.isNotEmpty) {
      buffer.write(' ($detail)');
    }
    if (area.isNotEmpty) {
      if (buffer.isNotEmpty) buffer.write('\n');
      buffer.write(area.replaceAll('\n', ', '));
    }
    return buffer.toString();
  }
}

class AddressService {
  AddressService._() {
    // Initial default address
    addresses.value = [
      AddressItem(
        id: 'addr_1',
        nama: 'Amba',
        phone: '0812****7890',
        area: 'MUARA BATU, KOTA LHOKSEUMAWE, NANGROE ACEH DARUSSALAM (NAD), ID 24353',
        street: 'Sakinah Kos, Jl. Pulo, Reuleut Tim., Kec. Muara Batu\nKabupaten Aceh Utara, Aceh',
        detail: 'Dekat melati kos',
        isUtama: true,
      ),
    ];
  }

  static final AddressService instance = AddressService._();

  final ValueNotifier<List<AddressItem>> addresses = ValueNotifier<List<AddressItem>>([]);

  void addAddress({
    required String nama,
    required String phone,
    required String area,
    required String street,
    required String detail,
    bool setAsUtama = false,
  }) {
    final newItem = AddressItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nama: nama,
      phone: phone,
      area: area,
      street: street,
      detail: detail,
      isUtama: setAsUtama || addresses.value.isEmpty,
    );

    final current = List<AddressItem>.from(addresses.value);
    if (newItem.isUtama) {
      for (final item in current) {
        item.isUtama = false;
      }
    }
    current.add(newItem);
    addresses.value = current;
  }

  void updateAddress({
    required String id,
    required String nama,
    required String phone,
    required String area,
    required String street,
    required String detail,
  }) {
    final current = List<AddressItem>.from(addresses.value);
    final index = current.indexWhere((a) => a.id == id);
    if (index != -1) {
      final old = current[index];
      current[index] = AddressItem(
        id: old.id,
        nama: nama,
        phone: phone,
        area: area,
        street: street,
        detail: detail,
        isUtama: old.isUtama,
      );
      addresses.value = current;
    }
  }

  void deleteAddress(String id) {
    final current = List<AddressItem>.from(addresses.value);
    final wasUtama = current.firstWhere((a) => a.id == id, orElse: () => current.first).isUtama;
    current.removeWhere((a) => a.id == id);

    if (wasUtama && current.isNotEmpty) {
      current.first.isUtama = true;
    }
    addresses.value = current;
  }

  void setUtama(String id) {
    final current = List<AddressItem>.from(addresses.value);
    for (final item in current) {
      item.isUtama = (item.id == id);
    }
    addresses.value = current;
  }
}

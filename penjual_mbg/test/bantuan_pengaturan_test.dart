import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/bantuan_pengaturan_screen.dart';

void main() {
  testWidgets('Test BantuanPengaturanScreen and navigation to all sub-screens', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: BantuanPengaturanScreen(),
      ),
    );

    // Verify main Bantuan header and 3 menu pills
    expect(find.text('Bantuan dan Pengaturan Lainnya'), findsOneWidget);
    expect(find.text('Layanan dan Bantuan'), findsOneWidget);
    expect(find.text('Syarat dan Ketentuan'), findsOneWidget);
    expect(find.text('Kebijakan Privasi'), findsOneWidget);

    // 1. Test Navigation to Layanan dan Bantuan
    await tester.tap(find.text('Layanan dan Bantuan'));
    await tester.pumpAndSettle();

    expect(find.text('Layanan dan Bantuan'), findsOneWidget);
    expect(find.text('Halo! Ada yang bisa kami bantu?'), findsOneWidget);
    expect(find.text('Topik/Pertanyaan populer'), findsOneWidget);
    expect(find.text('Bagaimana cara memproses atau menerima pesanan baru dari pembeli?'), findsOneWidget);

    // Expand FAQ
    await tester.tap(find.text('Bagaimana cara memproses atau menerima pesanan baru dari pembeli?'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Buka tab Pesanan di aplikasi Penjual'), findsOneWidget);

    // Contact buttons
    expect(find.text('Hubungi Via WhatsApp'), findsOneWidget);
    expect(find.text('Kirim email ke mybiggrocery54@gmail.com'), findsOneWidget);

    // Pop back
    await tester.tap(find.byKey(const Key('btn_back')));
    await tester.pumpAndSettle();
    expect(find.text('Bantuan dan Pengaturan Lainnya'), findsOneWidget);

    // 2. Test Navigation to Syarat dan Ketentuan
    await tester.tap(find.text('Syarat dan Ketentuan'));
    await tester.pumpAndSettle();

    expect(find.text('Syarat dan Ketentuan'), findsOneWidget);
    expect(find.text('Ketentuan Akun Toko'), findsOneWidget);
    expect(find.text('Aturan Produk & Penjualan'), findsOneWidget);
    expect(find.text('Transaksi & Pencairan Dana'), findsOneWidget);
    expect(find.text('Kebijakan Komisi & Penalti'), findsOneWidget);

    // Pop back
    await tester.tap(find.byKey(const Key('btn_back')));
    await tester.pumpAndSettle();
    expect(find.text('Bantuan dan Pengaturan Lainnya'), findsOneWidget);

    // 3. Test Navigation to Kebijakan Privasi
    await tester.tap(find.text('Kebijakan Privasi'));
    await tester.pumpAndSettle();

    expect(find.text('Kebijakan Privasi'), findsOneWidget);
    expect(find.text('Data Pengguna'), findsOneWidget);
    expect(find.text('Penggunaan Informasi'), findsOneWidget);
    expect(find.text('Pembagian Data ke Pihak Ketiga'), findsOneWidget);
    expect(find.text('Keamanan & Hak Pengguna'), findsOneWidget);

    // Tap 1: Data Pengguna -> opens dedicated page
    await tester.tap(find.text('Data Pengguna'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Kami mengumpulkan data pribadi seperti nama'), findsOneWidget);
    await tester.tap(find.byKey(const Key('btn_back')));
    await tester.pumpAndSettle();

    // Tap 2: Penggunaan Informasi -> opens dedicated page
    await tester.tap(find.text('Penggunaan Informasi'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Data penjual hanya digunakan untuk mengelola toko'), findsOneWidget);
    await tester.tap(find.byKey(const Key('btn_back')));
    await tester.pumpAndSettle();

    // Tap 3: Pembagian Data ke Pihak Ketiga -> opens dedicated page "Pembagian Data"
    await tester.tap(find.text('Pembagian Data ke Pihak Ketiga'));
    await tester.pumpAndSettle();
    expect(find.text('Pembagian Data'), findsOneWidget);
    expect(find.textContaining('Kami menjaga kerahasiaan data Anda dan hanya membagikannya'), findsOneWidget);
    await tester.tap(find.byKey(const Key('btn_back')));
    await tester.pumpAndSettle();

    // Tap 4: Keamanan & Hak Pengguna -> opens dedicated page
    await tester.tap(find.text('Keamanan & Hak Pengguna'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Keamanan akun dilindungi dengan sistem enkripsi'), findsOneWidget);
    await tester.tap(find.byKey(const Key('btn_back')));
    await tester.pumpAndSettle();

    // Pop back from Kebijakan Privasi to Bantuan dan Pengaturan Lainnya
    await tester.tap(find.byKey(const Key('btn_back')));
    await tester.pumpAndSettle();
    expect(find.text('Bantuan dan Pengaturan Lainnya'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/tambah_produk_screen.dart';

void main() {
  testWidgets('Test TambahProdukScreen button turns green when all fields and photo are filled', (tester) async {
    Map<String, dynamic>? addedProduct;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    addedProduct = await Navigator.push<Map<String, dynamic>>(
                      context,
                      MaterialPageRoute(builder: (_) => const TambahProdukScreen()),
                    );
                  },
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );

    // Tap to open TambahProdukScreen
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Verify header and fields exist
    expect(find.text('Masukkan Produk'), findsOneWidget);
    expect(find.text('Foto Produk *Maksimal Satu'), findsOneWidget);
    expect(find.text('Nama Produk'), findsOneWidget);
    expect(find.text('Harga'), findsOneWidget);
    expect(find.text('Deskripsi'), findsOneWidget);
    expect(find.text('Tambah Katalog'), findsOneWidget);

    // Initial state: Tambah Katalog should NOT trigger pop
    await tester.ensureVisible(find.text('Tambah Katalog'));
    await tester.tap(find.text('Tambah Katalog'), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(addedProduct, isNull);

    // Fill in Nama Produk
    await tester.enterText(find.byType(TextField).at(0), 'Daging Rendang Spesial');
    await tester.pumpAndSettle();

    // Fill in Harga
    await tester.enterText(find.byType(TextField).at(1), '135000');
    await tester.pumpAndSettle();

    // Fill in Deskripsi
    await tester.enterText(find.byType(TextField).at(2), 'Daging sapi segar tanpa lemak cocok untuk rendang lezat');
    await tester.pumpAndSettle();

    // Still no photo -> should still be disabled
    await tester.ensureVisible(find.text('Tambah Katalog'));
    await tester.tap(find.text('Tambah Katalog'));
    await tester.pumpAndSettle();
    expect(addedProduct, isNull);

    // Tap camera upload container to open picker sheet
    await tester.ensureVisible(find.byIcon(Icons.camera_alt_outlined));
    await tester.tap(find.byIcon(Icons.camera_alt_outlined));
    await tester.pumpAndSettle();

    // Choose the newly added Wagyu Pack
    expect(find.text('Foto Wagyu Pack'), findsOneWidget);
    await tester.tap(find.text('Foto Wagyu Pack'));
    await tester.pumpAndSettle();

    // Now all fields are filled & photo selected!
    // Tap 'Tambah Katalog'
    await tester.ensureVisible(find.text('Tambah Katalog'));
    await tester.tap(find.text('Tambah Katalog'));
    await tester.pumpAndSettle();

    // Verify it popped back with newProduct
    expect(addedProduct, isNotNull);
    expect(addedProduct!['priceNumber'], 135000);
    expect(addedProduct!['price'], 'Rp135.000');
    expect(addedProduct!['description'], 'Daging sapi segar tanpa lemak cocok untuk rendang lezat');
  });
}

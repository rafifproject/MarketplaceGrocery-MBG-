import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/informasi_toko_screen.dart';

void main() {
  testWidgets('Test InformasiTokoScreen form fill, status selection, and save flow', (tester) async {
    Map<String, dynamic>? returnedData;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                returnedData = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InformasiTokoScreen(),
                  ),
                );
              },
              child: const Text('Buka Informasi Toko'),
            );
          },
        ),
      ),
    );

    // Open screen
    await tester.tap(find.text('Buka Informasi Toko'));
    await tester.pumpAndSettle();

    // Verify labels and header exist
    expect(find.text('Informasi Toko'), findsOneWidget);
    expect(find.text('Nama Toko'), findsOneWidget);
    expect(find.text('Deskripsi Toko'), findsOneWidget);
    expect(find.text('Nomor Telepon Toko'), findsOneWidget);
    expect(find.text('Alamat Toko'), findsOneWidget);
    expect(find.text('Status Toko'), findsOneWidget);
    expect(find.text('Buka'), findsOneWidget);
    expect(find.text('Tutup'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);

    // Initial state: Simpan is disabled
    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(4));

    // Fill Nama Toko
    await tester.enterText(textFields.at(0), 'Toko Berkah Segar');
    await tester.pump();

    // Fill Deskripsi Toko
    await tester.enterText(textFields.at(1), 'Menjual daging sapi segar berkualitas setiap hari.');
    await tester.pump();

    // Fill Nomor Telepon
    await tester.enterText(textFields.at(2), '081234567890');
    await tester.pump();

    // Fill Alamat
    await tester.enterText(textFields.at(3), 'Jl. Merdeka No. 12, Lhokseumawe');
    await tester.pump();

    // Status not yet selected -> Simpan still disabled
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pump();
    expect(find.byType(Dialog), findsNothing);

    // Select Status "Buka" -> Status button turns green, Simpan is now enabled!
    await tester.ensureVisible(find.text('Buka'));
    await tester.tap(find.text('Buka'));
    await tester.pumpAndSettle();

    // Tap Simpan -> Shows Dialog
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Dialog is visible with success message or asset
    expect(find.byType(Dialog), findsOneWidget);

    // Dismiss dialog by tapping
    await tester.tap(find.byType(Dialog));
    await tester.pumpAndSettle();

    // Ensure all columns can be edited again!
    expect(find.text('Toko Berkah Segar'), findsOneWidget);
    await tester.enterText(textFields.at(0), 'Toko Berkah Segar Update');
    await tester.pump();
    expect(find.text('Toko Berkah Segar Update'), findsOneWidget);

    // Tap Back Arrow
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify returned data
    expect(returnedData, isNotNull);
    expect(returnedData!['nama'], 'Toko Berkah Segar Update');
    expect(returnedData!['status'], 'Buka');
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/informasi_pemilik_akun_screen.dart';

void main() {
  testWidgets('Test InformasiPemilikAkunScreen form fill and save flow', (tester) async {
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
                    builder: (_) => const InformasiPemilikAkunScreen(),
                  ),
                );
              },
              child: const Text('Buka Informasi Pemilik Akun'),
            );
          },
        ),
      ),
    );

    // Open screen
    await tester.tap(find.text('Buka Informasi Pemilik Akun'));
    await tester.pumpAndSettle();

    // Verify labels and header exist
    expect(find.text('Informasi Pemilik Akun'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Nomor Telepon'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Konfirmasi Password'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(5));

    // Fill fields
    await tester.enterText(textFields.at(0), 'Rusdi Pratama');
    await tester.pump();

    await tester.enterText(textFields.at(1), '081298765432');
    await tester.pump();

    await tester.enterText(textFields.at(2), 'rusdipratama@gmail.com');
    await tester.pump();

    await tester.enterText(textFields.at(3), 'secret123');
    await tester.pump();

    // Still missing Konfirmasi Password -> Simpan is disabled
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pump();
    expect(find.byType(Dialog), findsNothing);

    // Fill Konfirmasi Password
    await tester.enterText(textFields.at(4), 'secret123');
    await tester.pumpAndSettle();

    // Tap Simpan -> Shows Dialog
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Dialog is visible
    expect(find.byType(Dialog), findsOneWidget);

    // Dismiss dialog by tapping
    await tester.tap(find.byType(Dialog));
    await tester.pumpAndSettle();

    // Ensure all columns can be edited again
    expect(find.text('Rusdi Pratama'), findsOneWidget);
    await tester.enterText(textFields.at(0), 'Rusdi Pratama SH');
    await tester.pump();
    expect(find.text('Rusdi Pratama SH'), findsOneWidget);

    // Tap Back Arrow
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify returned data
    expect(returnedData, isNotNull);
    expect(returnedData!['nama'], 'Rusdi Pratama SH');
    expect(returnedData!['email'], 'rusdipratama@gmail.com');
  });
}

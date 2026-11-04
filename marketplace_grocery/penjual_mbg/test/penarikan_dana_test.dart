import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/penarikan_dana_screen.dart';

void main() {
  testWidgets('Test complete Penarikan Dana flow: E-wallet & Bank -> Modal Konfirmasi -> PIN -> Bukti Penarikan',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // 1. Test PenarikanDanaScreen with E-wallet (DANA)
    await tester.pumpWidget(
      const MaterialApp(
        home: PenarikanDanaScreen(
          providerName: 'DANA',
          isBank: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('DANA'), findsOneWidget);
    expect(find.text('Saldo yang Anda miliki'), findsOneWidget);
    expect(find.text('Nomor Telepon :'), findsOneWidget);
    expect(find.text('Nominal :'), findsOneWidget);
    expect(find.text('Minimal nominal pengisian Rp10.000,00'), findsOneWidget);

    // Enter phone and nominal
    await tester.enterText(find.byType(TextField).at(0), '089612345678');
    await tester.enterText(find.byType(TextField).at(1), '200000');
    await tester.pumpAndSettle();

    // Tap Lanjut -> opens Konfirmasi Bottom Sheet
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    expect(find.text('Tujuan'), findsOneWidget);
    expect(find.text(': DANA'), findsOneWidget);
    expect(find.text('Nama Penerima'), findsOneWidget);
    expect(find.text(': DNXD PXTRX PXDNG'), findsOneWidget);
    expect(find.text('Nomor Telepon'), findsOneWidget);
    expect(find.text(': 089612345678'), findsOneWidget);
    expect(find.text(': Rp200.000,00'), findsOneWidget);
    expect(find.text(': Rp2.000,00'), findsOneWidget);
    expect(find.text(': Rp202.000,00'), findsOneWidget);
    expect(find.text('Batal'), findsOneWidget);
    expect(find.text('Konfirmasi'), findsOneWidget);

    // Tap Konfirmasi -> navigates to PinPenarikanScreen
    await tester.tap(find.text('Konfirmasi'));
    await tester.pumpAndSettle();

    expect(find.text('Masukkan PIN Transaksi'), findsOneWidget);

    // Enter 6 digits using custom keypad (1, 2, 3, 4, 5, 6)
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('4'));
    await tester.pump();
    await tester.tap(find.text('5'));
    await tester.pump();
    await tester.tap(find.text('6'));
    await tester.pumpAndSettle();

    // Tap Lanjut on PIN screen -> navigates to BuktiPenarikanScreen
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    expect(find.text('Bukti Penarikan'), findsOneWidget);
    expect(find.text('My Big Grocery'), findsOneWidget);
    expect(find.text('Transaksi ID'), findsOneWidget);
    expect(find.text('Ref No.'), findsOneWidget);
    expect(find.text('Kembali'), findsOneWidget);
    expect(find.text('Unduh Bukti'), findsOneWidget);

    // Tap Unduh Bukti -> shows SnackBar
    await tester.tap(find.text('Unduh Bukti'));
    await tester.pump();
    expect(find.text('Bukti penarikan berhasil diunduh!'), findsOneWidget);
  });

  testWidgets('Test PenarikanDanaScreen with Bank shows Nomor Kartu :',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PenarikanDanaScreen(
          providerName: 'BSI',
          isBank: true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('BSI'), findsOneWidget);
    expect(find.text('Nomor Kartu :'), findsOneWidget);
    expect(find.text('Minimal nominal pengisian Rp10.000,00'), findsOneWidget);
  });
}

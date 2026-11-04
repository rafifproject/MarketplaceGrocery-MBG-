import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/keuangan_pembayaran_screen.dart';

void main() {
  testWidgets('Test KeuanganPembayaranScreen UI, card details, Tambah button, and menu pills', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: KeuanganPembayaranScreen(),
      ),
    );

    // Header exists
    expect(find.text('Keuangan dan Pembayaran'), findsOneWidget);

    // Section 1 exists
    expect(find.text('Rekening / E-wallet Terdaftar'), findsOneWidget);
    expect(find.text('Tambah'), findsOneWidget);

    // Section 2 exists
    expect(find.text('Manajemen Saldo & Keamanan'), findsOneWidget);
    expect(find.text('PIN Transaksi & Keamanan'), findsOneWidget);
    expect(find.text('Riwayat Penarikan Dana'), findsOneWidget);
    expect(find.text('Metode Pembayaran Toko'), findsOneWidget);

    // Tap "Tambah" button -> opens bottom sheet
    await tester.ensureVisible(find.text('Tambah'));
    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();
    expect(find.text('Tambah Rekening / E-Wallet'), findsOneWidget);

    // Close bottom sheet
    Navigator.pop(tester.element(find.text('Tambah Rekening / E-Wallet')));
    await tester.pumpAndSettle();

    // Tap "PIN Transaksi & Keamanan"
    await tester.ensureVisible(find.text('PIN Transaksi & Keamanan'));
    await tester.tap(find.text('PIN Transaksi & Keamanan'));
    await tester.pumpAndSettle();
    expect(find.text('Status PIN Transaksi'), findsOneWidget);

    // Close sheet
    Navigator.pop(tester.element(find.text('Status PIN Transaksi')));
    await tester.pumpAndSettle();

    // Tap "Riwayat Penarikan Dana"
    await tester.ensureVisible(find.text('Riwayat Penarikan Dana'));
    await tester.tap(find.text('Riwayat Penarikan Dana'));
    await tester.pumpAndSettle();
    expect(find.text('Penarikan ke Bank BSI'), findsOneWidget);

    // Close sheet
    Navigator.pop(tester.element(find.text('Penarikan ke Bank BSI')));
    await tester.pumpAndSettle();

    // Tap "Metode Pembayaran Toko"
    await tester.ensureVisible(find.text('Metode Pembayaran Toko'));
    await tester.tap(find.text('Metode Pembayaran Toko'));
    await tester.pumpAndSettle();
    expect(find.text('QRIS Statis & Dinamis'), findsOneWidget);

    // Close sheet
    Navigator.pop(tester.element(find.text('QRIS Statis & Dinamis')));
    await tester.pumpAndSettle();

    // Tap DANA detail button with enlarged hit area -> navigates to DetailRekeningScreen
    await tester.ensureVisible(find.byKey(const Key('dana_detail_button')));
    await tester.tap(find.byKey(const Key('dana_detail_button')));
    await tester.pumpAndSettle();
    expect(find.text('Detail Rekening/E-wallet'), findsOneWidget);
    expect(find.text('DANA'), findsOneWidget);

    // Pop back to Keuangan
    Navigator.pop(tester.element(find.text('Detail Rekening/E-wallet')));
    await tester.pumpAndSettle();
    expect(find.text('Keuangan dan Pembayaran'), findsOneWidget);
  });
}

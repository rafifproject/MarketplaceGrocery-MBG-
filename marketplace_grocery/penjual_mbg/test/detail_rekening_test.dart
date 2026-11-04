import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/detail_rekening_screen.dart';

void main() {
  testWidgets('Test DetailRekeningScreen for DANA and BSI flow', (tester) async {
    // 1. Test DANA Screen
    await tester.pumpWidget(
      const MaterialApp(
        home: DetailRekeningScreen(
          accountType: AccountType.dana,
          initialNamaBank: 'DANA',
          initialJenisLayanan: 'E-wallet',
          initialNomorAkun: '0834xxxxxxxxx',
          initialNamaPemilik: 'Rusdi Wara Wiri',
        ),
      ),
    );

    // Verify elements
    expect(find.text('Detail Rekening/E-wallet'), findsOneWidget);
    expect(find.text('Nama Bank/E-wallet'), findsOneWidget);
    expect(find.text('Jenis Layanan Keuangan'), findsOneWidget);
    expect(find.text('Nomor Akun'), findsOneWidget);
    expect(find.text('Nama Pemilik'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);
    expect(find.text('Hapus'), findsOneWidget);

    // Verify initial values
    expect(find.text('DANA'), findsOneWidget);
    expect(find.text('0834xxxxxxxxx'), findsOneWidget);
    expect(find.text('Rusdi Wara Wiri'), findsOneWidget);

    // Tap "Simpan" -> shows success dialog with "Berhasil Menyimpan"
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pump();
    expect(find.byType(Dialog), findsOneWidget);

    // Auto-dismiss after ~1.8 seconds
    await tester.pump(const Duration(milliseconds: 2000));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsNothing);

    // 2. Test BSI Screen and Delete confirmation
    await tester.pumpWidget(
      const MaterialApp(
        home: DetailRekeningScreen(
          accountType: AccountType.bsi,
          initialNamaBank: 'Bank Syariah Indonesia (BSI)',
          initialJenisLayanan: 'E-wallet',
          initialNomorAkun: '734*********',
          initialNamaPemilik: 'Rusdi Wara Wiri',
        ),
      ),
    );

    expect(find.text('Bank Syariah Indonesia (BSI)'), findsOneWidget);

    // Tap "Hapus" -> shows confirmation dialog
    await tester.ensureVisible(find.text('Hapus'));
    await tester.tap(find.text('Hapus'));
    await tester.pumpAndSettle();

    expect(find.text('Hapus Rekening'), findsOneWidget);
    expect(find.text('Batal'), findsOneWidget);

    // Tap Batal
    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();
    expect(find.text('Hapus Rekening'), findsNothing);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/penjual_profile_screen.dart';

void main() {
  testWidgets('Test PenjualProfileScreen renders all elements and menu pills correctly', (tester) async {
    bool loggedOut = false;

    await tester.pumpWidget(
      MaterialApp(
        home: PenjualProfileScreen(
          onLogout: () {
            loggedOut = true;
          },
        ),
      ),
    );

    // Verify header "Profil"
    expect(find.text('Profil'), findsOneWidget);

    // Verify all 6 menu pill titles
    expect(find.text('Informasi Utama Toko'), findsOneWidget);
    expect(find.text('Informasi Pemilik Akun'), findsOneWidget);
    expect(find.text('Keuangan & Pembayaran'), findsOneWidget);
    expect(find.text('Bantuan & Pengaturan Lainnya'), findsOneWidget);
    expect(find.text('Bahasa/Language'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);

    // Tap "Informasi Utama Toko" -> opens edit sheet
    await tester.tap(find.text('Informasi Utama Toko'));
    await tester.pumpAndSettle();

    // Verify sheet opened and has "Simpan" button
    expect(find.text('Nama Toko'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);

    // Close sheet with back
    Navigator.pop(tester.element(find.text('Simpan')));
    await tester.pumpAndSettle();

    // Scroll to Log Out and tap
    await tester.ensureVisible(find.text('Log Out'));
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();

    expect(find.text('Konfirmasi Keluar'), findsOneWidget);
    expect(find.text('Keluar'), findsOneWidget);

    // Tap "Keluar" button in dialog
    await tester.tap(find.text('Keluar'));
    await tester.pumpAndSettle();

    expect(loggedOut, isTrue);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/main.dart';
import 'package:penjual_mbg/screens/penjual_home_screen.dart';

void main() {
  testWidgets('Test full flow: Splash -> Onboarding -> Login -> Google picker routing', (WidgetTester tester) async {
    await tester.pumpWidget(const PenjualApp());

    // Page 1: Splash screen
    expect(find.text('My Big Grocery'), findsOneWidget);

    // Fast-forward to Page 2: Onboarding
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));

    // Tap Skip>
    await tester.tap(find.text('Skip>'));
    await tester.pumpAndSettle();

    // Page 3: Login screen
    expect(find.text('Google'), findsOneWidget);

    // Tap Google button
    await tester.tap(find.text('Google'));
    await tester.pumpAndSettle();

    // Verify Google modal appears with Rusdi account (Amba removed)
    expect(find.text('Pilih akun'), findsOneWidget);
    expect(find.text('Amba'), findsNothing);
    expect(find.text('ambarita05@gmail.com'), findsNothing);
    expect(find.text('Rusdidaging23'), findsOneWidget);
    expect(find.text('rusdidaging23@gmail.com'), findsOneWidget);

    // Tap Rusdidaging23 -> goes to PenjualHomeScreen (currently empty screen)
    await tester.tap(find.text('Rusdidaging23'));
    await tester.pumpAndSettle();

    expect(find.byType(PenjualHomeScreen), findsOneWidget);
  });

  testWidgets('Test Register flow: Login -> Tap Daftar -> Fill -> Tap Daftar Button -> Success Dialog -> Lanjutkan -> Back to Login', (WidgetTester tester) async {
    await tester.pumpWidget(const PenjualApp());

    // Skip splash
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));

    // Tap Skip> to reach Login
    await tester.tap(find.text('Skip>'));
    await tester.pumpAndSettle();

    // Verify on Login Screen
    expect(find.text('Belum punya akun? '), findsOneWidget);

    // Tap 'Daftar' link
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    // Now on Register Screen
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Confirm password'), findsOneWidget);
    expect(find.text('Sudah punya akun? '), findsOneWidget);

    // Tap 'Daftar' button to register
    await tester.tap(find.widgetWithText(GestureDetector, 'Daftar'));
    await tester.pumpAndSettle();

    // Dialog pops up
    expect(find.text('Yeay! Akun Anda\nberhasil terdaftar'), findsOneWidget);
    expect(find.text('Lanjutkan'), findsOneWidget);

    // Tap 'Lanjutkan' button
    await tester.tap(find.text('Lanjutkan'));
    await tester.pumpAndSettle();

    // Back to Login Screen
    expect(find.text('Belum punya akun? '), findsOneWidget);
  });

  testWidgets('Test Forgot Password flow: Login -> Lupa Password? -> Email -> PIN keypad -> Dialog -> Password Baru -> Masuk -> Back to Login', (WidgetTester tester) async {
    await tester.pumpWidget(const PenjualApp());

    // Skip splash & onboarding
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    await tester.tap(find.text('Skip>'));
    await tester.pumpAndSettle();

    // Tap 'Lupa Password?'
    await tester.tap(find.text('Lupa Password?'));
    await tester.pumpAndSettle();

    // Step 1: Lupa Password (Input email)
    expect(find.text('Lupa Password'), findsOneWidget);
    expect(find.text('Gmail / Nomor HP'), findsOneWidget);

    // Tap Masuk button (same position and name as on new password page)
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    // Step 2: Masukkan PIN
    expect(find.text('Masukkan PIN'), findsOneWidget);
    expect(find.text('ABC'), findsOneWidget);

    // Tap digit '6' on custom keypad
    await tester.tap(find.text('6'));
    await tester.pumpAndSettle();

    // Tap 'Lanjut'
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    // Dialog appears with checkmark and Lanjutkan button
    expect(find.text('Lanjutkan'), findsOneWidget);

    // Tap 'Lanjutkan' on dialog
    await tester.tap(find.text('Lanjutkan'));
    await tester.pumpAndSettle();

    // Step 3: Password Baru
    expect(find.text('Password Baru'), findsOneWidget);
    expect(find.text('New password'), findsOneWidget);

    // Tap 'Masuk' button -> should navigate back to Login
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    // Back to Login Screen
    expect(find.text('Lupa Password?'), findsOneWidget);
  });
}

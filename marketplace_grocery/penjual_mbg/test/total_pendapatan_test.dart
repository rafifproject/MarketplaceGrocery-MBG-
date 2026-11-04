import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/total_pendapatan_screen.dart';

void main() {
  testWidgets('Test TotalPendapatanScreen layout, cards, and modal pickers',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: TotalPendapatanScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify Header & Cards rendered
    expect(find.text('Total Pendapatan'), findsOneWidget);
    expect(find.text('Harian'), findsOneWidget);
    expect(find.text('Bulanan'), findsOneWidget);
    expect(find.text('Tahunan'), findsOneWidget);
    expect(find.text('Dompet Seller'), findsOneWidget);
    expect(find.text('Tarik Dana'), findsOneWidget);

    // Initial badges
    expect(find.text('1 Oktober 2026'), findsOneWidget);
    expect(find.text('Oktober'), findsOneWidget);
    expect(find.text('2026'), findsOneWidget);

    // Initial amounts
    expect(find.textContaining('Rp740.000'), findsOneWidget);
    expect(find.textContaining('Rp7.706.000'), findsOneWidget);
    expect(find.textContaining('Rp15.000.000'), findsOneWidget);

    // 1b. Test Custom Figma Calendar Dialog (Harian)
    await tester.tap(find.text('Harian'));
    await tester.pumpAndSettle();

    // Verify calendar dialog elements from Figma Image 1
    expect(find.text('Oktober 2026'), findsWidgets);
    expect(find.text('Sen'), findsOneWidget);
    expect(find.text('Kam'), findsOneWidget);
    expect(find.text('Lihat'), findsOneWidget);

    // Tap day 9
    await tester.tap(find.text('9'));
    await tester.pumpAndSettle();

    // Tap "Lihat" button to confirm
    await tester.tap(find.text('Lihat'));
    await tester.pumpAndSettle();

    // Verify dialog closed and badge updated to 9 Oktober 2026 with Rp820.000
    expect(find.text('9 Oktober 2026'), findsOneWidget);
    expect(find.textContaining('Rp820.000'), findsOneWidget);

    // 2. Test Month Picker (Bulanan)
    await tester.tap(find.text('Bulanan'));
    await tester.pumpAndSettle();

    // 12 months list should appear
    expect(find.text('Januari'), findsOneWidget);
    expect(find.text('Maret'), findsOneWidget);

    // Select Maret
    await tester.tap(find.text('Maret'));
    await tester.pumpAndSettle();

    // Verify modal is closed and badge is updated to Maret
    expect(find.text('Januari'), findsNothing);
    expect(find.text('Maret'), findsOneWidget);

    // 3. Test Year Picker (Tahunan)
    await tester.tap(find.text('Tahunan'));
    await tester.pumpAndSettle();

    // Years should appear
    expect(find.text('2024'), findsOneWidget);
    expect(find.text('2025'), findsOneWidget);

    // Select 2025
    await tester.tap(find.text('2025'));
    await tester.pumpAndSettle();

    // Verify modal closed and badge is updated to 2025
    expect(find.text('2025'), findsOneWidget);

    // 4. Test Tarik Dana button navigates to Dompet Seller screen
    await tester.drag(find.byType(ListView).first, const Offset(0, -250));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tarik Dana'));
    await tester.pumpAndSettle();

    expect(find.text('Saldo yang Anda miliki'), findsOneWidget);
    expect(find.text('e-wallet'), findsOneWidget);
    expect(find.text('BANK'), findsOneWidget);

    // Tap e-wallet -> shows DANA, OVO, GoPay
    await tester.tap(find.text('e-wallet'));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsWidgets);

    // Tap BANK -> shows BSI, BRI, BSN
    await tester.tap(find.text('BANK'));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsWidgets);
  });
}

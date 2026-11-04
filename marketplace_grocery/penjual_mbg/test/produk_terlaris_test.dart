import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/produk_terlaris_screen.dart';
import 'package:penjual_mbg/screens/penjual_home_screen.dart';

void main() {
  testWidgets('ProdukTerlarisScreen renders header, title, and 3 product rank cards', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProdukTerlarisScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Check header
    expect(find.text('Produk Terlaris'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Check section title
    expect(find.text('Produk Terlaris Hari ini'), findsOneWidget);

    // Check rank 1
    expect(find.text('Iga Sapi Backribs 500 gram'), findsOneWidget);
    expect(find.text('Total Terjual : 35 pcs'), findsOneWidget);

    // Check rank 2
    expect(find.text('Daging Sapi Yoshinoya Beef Slice 500gr'), findsOneWidget);
    expect(find.text('Total Terjual : 30 pcs'), findsOneWidget);

    // Check rank 3
    expect(find.text('Daging Giling Sapi Minced Beef'), findsOneWidget);
    expect(find.text('Total Terjual : 28 pcs'), findsOneWidget);

    // Test back navigation
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
  });

  testWidgets('Tapping Produk Terlaris banner on PenjualHomeScreen opens ProdukTerlarisScreen', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      MaterialApp(
        home: PenjualHomeScreen(onLogout: () {}),
      ),
    );
    await tester.pumpAndSettle();

    // Find "Terlaris" text on the banner card
    final bannerText = find.text('Terlaris');
    expect(bannerText, findsOneWidget);

    // Scroll if needed and tap the banner
    await tester.ensureVisible(bannerText);
    await tester.pumpAndSettle();
    await tester.tap(bannerText);
    await tester.pumpAndSettle();

    // Should now be on ProdukTerlarisScreen
    expect(find.byType(ProdukTerlarisScreen), findsOneWidget);
    expect(find.text('Produk Terlaris Hari ini'), findsOneWidget);
    expect(find.text('Iga Sapi Backribs 500 gram'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pembeli_mbg/screens/keranjang_screen.dart';
import 'package:pembeli_mbg/screens/informasi_order_screen.dart';
import 'package:pembeli_mbg/screens/rincian_pesanan_screen.dart';
import 'package:pembeli_mbg/screens/nilai_pesanan_screen.dart';

void main() {
  testWidgets('Test InformasiOrderScreen layout and elements', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: InformasiOrderScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Informasi Order'), findsOneWidget);
    expect(find.text('Estimasi Tiba : 20–30 min'), findsOneWidget);
    expect(find.text('GrabExpress'), findsOneWidget);
    expect(find.text('Pesanan Telah diserahkan Ke kurir'), findsOneWidget);
    expect(find.text('Pengirim telah mengatur pengiriman. Menunggu pesanan diserahkan ke pihak jasa kirim.'), findsOneWidget);
    expect(find.text('Pesanan dibuat'), findsOneWidget);
  });

  testWidgets('Test RincianPesananScreen layout and elements', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: RincianPesananScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rincian Pesanan'), findsOneWidget);
    expect(find.text('Estimasi Tiba : 20–30 min'), findsOneWidget);
    expect(find.text('Info Pengiriman'), findsOneWidget);
    expect(find.text('GrabExpress'), findsOneWidget);
    expect(find.text('Pesanan telah diserahkan ke kurir'), findsOneWidget);
    expect(find.text('Alamat Pengiriman'), findsOneWidget);
    expect(find.text('Amba (0812••••7890)'), findsOneWidget);
    expect(find.text('Toko Sayur Mbak Putri'), findsOneWidget);
    expect(find.text('Baby Pak Choi 1 Ikat'), findsOneWidget);
    expect(find.text('Rp7.000'), findsNWidgets(2));
    expect(find.text('x2'), findsOneWidget);
    expect(find.text('Subtotal Produk'), findsOneWidget);
    expect(find.text('No. Pesanan'), findsOneWidget);
    expect(find.text('260928000002XXXCBUY'), findsOneWidget);
    expect(find.text('Metode Pembayaran'), findsOneWidget);
    expect(find.text('Bayar Di tempat (COD)'), findsOneWidget);
  });

  testWidgets('Test Order Page navigation via Lihat and Detail buttons',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: KeranjangScreen(initialNavIndex: 3),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Switch to 'Dikirim' tab to test 'Lihat' and 'Detail' buttons
    await tester.tap(find.text('Dikirim'));
    await tester.pumpAndSettle();

    expect(find.text('Lihat'), findsOneWidget);
    await tester.tap(find.text('Lihat'));
    await tester.pumpAndSettle();

    expect(find.byType(InformasiOrderScreen), findsOneWidget);
    expect(find.text('Informasi Order'), findsOneWidget);

    // Pop InformasiOrderScreen
    Navigator.of(tester.element(find.byType(InformasiOrderScreen))).pop();
    await tester.pumpAndSettle();

    // 2. Test 'Detail' button navigation
    expect(find.text('Detail'), findsOneWidget);
    await tester.tap(find.text('Detail'));
    await tester.pumpAndSettle();

    expect(find.byType(RincianPesananScreen), findsOneWidget);
    expect(find.text('Rincian Pesanan'), findsOneWidget);

    // Pop RincianPesananScreen
    Navigator.of(tester.element(find.byType(RincianPesananScreen))).pop();
    await tester.pumpAndSettle();

    // 3. Switch to 'Selesai' tab to test 'Nilai' button
    final filterScrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(find.text('Selesai'), 50, scrollable: filterScrollable);
    await tester.tap(find.text('Selesai'));
    await tester.pumpAndSettle();

    expect(find.text('Nilai'), findsOneWidget);
    await tester.tap(find.text('Nilai'));
    await tester.pumpAndSettle();

    expect(find.byType(NilaiPesananScreen), findsOneWidget);
    expect(find.text('Nilai Pesanan'), findsOneWidget);
  });

  testWidgets(
      'Test Nilai button, star rating, green button transition, bubble ceklis, and Penilaian Saya',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: NilaiPesananScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Header shows 'Nilai Pesanan'
    expect(find.text('Nilai Pesanan'), findsOneWidget);
    expect(find.text('Norwegian Salmon 500gr'), findsOneWidget);
    expect(find.text('Rp152.000'), findsOneWidget);

    // Initially 5 star borders
    expect(find.byIcon(Icons.star_border_rounded), findsNWidgets(5));
    expect(find.byIcon(Icons.star), findsNothing);

    // Initial button 'Kirim Penilaian' is disabled / not active
    final btnFinder = find.widgetWithText(ElevatedButton, 'Kirim Penilaian');
    expect(btnFinder, findsOneWidget);
    ElevatedButton btn = tester.widget<ElevatedButton>(btnFinder);
    expect(btn.onPressed, isNull);

    // 2. Tap 5th star -> all 5 stars become filled full color
    final starIcons = find.byIcon(Icons.star_border_rounded);
    await tester.tap(starIcons.last);
    await tester.pumpAndSettle();

    // Now all 5 stars are filled
    expect(find.byIcon(Icons.star), findsNWidgets(5));
    expect(find.byIcon(Icons.star_border_rounded), findsNothing);

    // Button is now enabled and turns green!
    btn = tester.widget<ElevatedButton>(btnFinder);
    expect(btn.onPressed, isNotNull);

    // Fill review text
    await tester.enterText(
      find.byType(TextField),
      'Kualitas sangat baik dan ikan segar sekali!',
    );
    await tester.pumpAndSettle();

    // 3. Tap 'Kirim Penilaian' button
    await tester.tap(btnFinder);
    await tester.pump(); // trigger bubble overlay

    // Verify bubble ceklis appears: "Penilaian Anda Sudah diunggah"
    expect(find.text('Penilaian Anda Sudah diunggah'), findsOneWidget);
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // Advance timer by 2 seconds so the 1.8s dismiss timer completes
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // 4. Screen transitioned to 'Penilaian Saya'
    expect(find.text('Penilaian Saya'), findsOneWidget);
    expect(find.text('@ambalohya56'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(5));
  });
}

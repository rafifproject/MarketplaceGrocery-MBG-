import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/pesanan_masuk_screen.dart';
import 'package:penjual_mbg/screens/pembatalan_pesanan_screen.dart';
import 'package:penjual_mbg/screens/ulasan_pembeli_screen.dart';

void main() {
  testWidgets('Test PesananMasukScreen for each menu feature (all 5 tabs)',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: PesananMasukScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify Header & Title
    expect(find.text('Pesanan Masuk'), findsOneWidget);
    expect(find.byKey(const Key('btn_pesanan_masuk_back')), findsOneWidget);

    // 2. Tab: Belum diproses (Image 4 - 3 cards)
    await tester.tap(find.byKey(const Key('tab_Belum diproses')));
    await tester.pumpAndSettle();

    expect(find.text('Iga Sapi Backribs 500 gram'), findsOneWidget);
    expect(find.text('Daging Giling Sapi Minced Beef'), findsOneWidget);
    expect(find.text('Beef Sirloin Steak 1953'), findsOneWidget);
    expect(find.text('Kemas Sekarang'), findsNWidgets(3));

    // 3. Tab: Dikemas (Image 3 - 2 cards, includes [Serahkan] button)
    await tester.scrollUntilVisible(
      find.byKey(const Key('tab_Dikemas')),
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('tab_Dikemas')));
    await tester.pumpAndSettle();

    expect(find.text('Daging Sapi Wagyu A5 250gr'), findsOneWidget);
    expect(find.text('Iga Sapi Backribs 500 gram'), findsOneWidget);
    expect(find.text('Serahkan'), findsNWidgets(2)); // Button [Serahkan] on both Wagyu A5 & Iga Sapi
    expect(find.text('Sedang dikemas'), findsNWidgets(2));

    // Test Serahkan button flow
    await tester.tap(find.text('Serahkan').first);
    await tester.pumpAndSettle();
    expect(find.text('Serahkan ke Kurir'), findsOneWidget);
    expect(find.text('Batal'), findsOneWidget);

    // Tap Serahkan Sekarang inside modal
    final modalSerahkanBtn = find.descendant(
      of: find.byType(ElevatedButton),
      matching: find.text('Serahkan Sekarang'),
    );
    await tester.tap(modalSerahkanBtn);
    await tester.pumpAndSettle();

    // Modal dismissed
    expect(find.text('Serahkan ke Kurir'), findsNothing);

    // 4. Tab: Dikirim (Image 1 - 2 cards with motor 20-35 min)
    await tester.scrollUntilVisible(
      find.byKey(const Key('tab_Dikirim')),
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('tab_Dikirim')));
    await tester.pumpAndSettle();

    expect(find.text('Daging Sapi Yoshinoya Beef Slice 500gr'), findsOneWidget);
    expect(find.text('Diserahkan ke kurir'), findsWidgets);
    expect(find.text('Dikirim'), findsWidgets);

    // 5. Tab: Selesai (Image 2 - 1 card with [Lihat Ulasan])
    await tester.scrollUntilVisible(
      find.byKey(const Key('tab_Selesai')),
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('tab_Selesai')));
    await tester.pumpAndSettle();

    expect(find.text('Daging Sapi Wagyu A5 250gr'), findsOneWidget);
    expect(find.text('Lihat Ulasan'), findsOneWidget);
    expect(find.text('Tiba ditujuan'), findsOneWidget);
    expect(find.text('Selesai'), findsWidgets);

    // Tap 'Lihat Ulasan' and check UlasanPembeliScreen
    await tester.tap(find.text('Lihat Ulasan'));
    await tester.pumpAndSettle();
    expect(find.byType(UlasanPembeliScreen), findsOneWidget);
    expect(find.text('Ulasan Pembeli'), findsOneWidget);
    expect(find.text('Panggil Aja Rahul'), findsOneWidget);
    expect(find.text('@rahuluhuy19'), findsOneWidget);
    expect(find.text('Balas'), findsOneWidget);

    // Tap 'Balas' and verify success popup
    await tester.tap(find.text('Balas'));
    await tester.pump();
    expect(find.text('Berhasil Mengirimkan\nBalasan'), findsOneWidget);

    // Advance popup duration
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify reply is rendered and Balas button is removed
    expect(find.text('Respon Penjual'), findsOneWidget);
    expect(
        find.textContaining('Aamiin, makasih atas ulasan baiknya'),
        findsOneWidget);
    expect(find.text('Balas'), findsNothing);

    // Pop UlasanPembeliScreen
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // 6. Tab: Dibatalkan (Image 5 - 1 card with [Lihat Ulasan] and Dibatalkan in red)
    await tester.scrollUntilVisible(
      find.byKey(const Key('tab_Dibatalkan')),
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('tab_Dibatalkan')));
    await tester.pumpAndSettle();

    expect(find.text('Daging Sapi Wagyu A5 250gr'), findsOneWidget);
    expect(find.text('Lihat Ulasan'), findsOneWidget);
    expect(find.text('Dibatalkan'), findsWidgets);
  });

  testWidgets('Test Kemas Sekarang modal flow on Belum diproses tab',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: PesananMasukScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Find first 'Kemas Sekarang' button and tap it
    final kemasButtons = find.text('Kemas Sekarang');
    expect(kemasButtons, findsWidgets);

    await tester.tap(kemasButtons.first);
    await tester.pumpAndSettle();

    // Modal Confirmation appears
    expect(find.text('Konfirmasi Pengemasan'), findsOneWidget);
    expect(find.text('Batal'), findsOneWidget);

    // Tap confirm 'Kemas Sekarang' button inside modal
    final modalKemasBtn = find.descendant(
      of: find.byType(ElevatedButton),
      matching: find.text('Kemas Sekarang'),
    );
    await tester.tap(modalKemasBtn);
    await tester.pumpAndSettle();

    // Modal dismissed
    expect(find.text('Konfirmasi Pengemasan'), findsNothing);
  });

  testWidgets('Test clicking Dibatalkan opens PembatalanPesananScreen',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: PesananMasukScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Scroll to and tap Dibatalkan tab
    await tester.scrollUntilVisible(
      find.byKey(const Key('tab_Dibatalkan')),
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('tab_Dibatalkan')));
    await tester.pumpAndSettle();

    // 2. Tap red text 'Dibatalkan' in the order card
    final dibatalkanCardAction = find.descendant(
      of: find.byType(ListView),
      matching: find.text('Dibatalkan'),
    ).last;
    await tester.tap(dibatalkanCardAction);
    await tester.pumpAndSettle();

    // 3. Verify PembatalanPesananScreen layout
    expect(find.byType(PembatalanPesananScreen), findsOneWidget);
    expect(find.text('Pembatalan Pesanan'), findsOneWidget);
    expect(find.text('Detail Alasan Pembatalan'), findsOneWidget);
    expect(find.text('DiKonfirmasi'), findsOneWidget);
    expect(find.text('KATEGORI ALASAN'), findsOneWidget);
    expect(
        find.text('Waktu Pengiriman Terlalu Lama / Perubahan Rencana'),
        findsOneWidget);
    expect(find.text('Catatan dari Pembeli (Amba Rita):'), findsOneWidget);
    expect(
        find.textContaining('Maaf terpaksa saya batalkan karena butuh daging segera'),
        findsOneWidget);
    expect(find.text('STATUS PENGEMBALIAN DANA'), findsOneWidget);
    expect(find.text('Pengembalian Dana'), findsOneWidget);
    expect(find.text('Selesai via QRIS'), findsOneWidget);

    // 4. Test back button navigation
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(PembatalanPesananScreen), findsNothing);
    expect(find.byType(PesananMasukScreen), findsOneWidget);
  });
}

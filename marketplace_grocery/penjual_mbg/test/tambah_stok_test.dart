import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penjual_mbg/screens/tambah_stok_screen.dart';

void main() {
  testWidgets('Test TambahStokScreen adjusts stock up/down and saves', (tester) async {
    final product = {
      'titleLine1': 'Fresh Beef Ribeye',
      'titleLine2': 'Steak 500gr',
      'image': 'assets/images/product_beef_ribeye.png',
      'price': 'Rp536.000',
      'stockPcs': 12,
    };

    int? savedStock;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    savedStock = await Navigator.push<int>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TambahStokScreen(product: product),
                      ),
                    );
                  },
                  child: const Text('Buka Tambah Stok'),
                ),
              ),
            );
          },
        ),
      ),
    );

    // Open screen
    await tester.tap(find.text('Buka Tambah Stok'));
    await tester.pumpAndSettle();

    // Verify header and initial stock "12 pcs"
    expect(find.text('Tambah Stok'), findsOneWidget);
    expect(find.text('12 pcs'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);

    // Increment stock (+): 12 -> 13 -> 14
    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pumpAndSettle();
    expect(find.text('13 pcs'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pumpAndSettle();
    expect(find.text('14 pcs'), findsOneWidget);

    // Decrement stock (-): 14 -> 13
    await tester.tap(find.byIcon(Icons.remove_circle));
    await tester.pumpAndSettle();
    expect(find.text('13 pcs'), findsOneWidget);

    // Tap Simpan
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Verify popped with 13
    expect(savedStock, 13);
  });
}

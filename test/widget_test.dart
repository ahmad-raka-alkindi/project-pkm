import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('login opens dashboard and report is kept in memory', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LaporKotaApp());

    expect(find.text('LaporKota'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), 'Warga Kota');
    await tester.enterText(find.byType(TextField).at(1), 'password');
    await tester.ensureVisible(find.text('Masuk ke aplikasi'));
    await tester.tap(find.text('Masuk ke aplikasi'));
    await tester.pumpAndSettle();

    expect(find.text('Laporan populer'), findsOneWidget);
    expect(find.text('Jalan berlubang'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.camera_alt_rounded).first);
    await tester.pumpAndSettle();
    expect(find.text('Buat laporan'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Jl. Contoh, Kecamatan Pusat',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Ada kerusakan yang perlu diperbaiki.',
    );
    await tester.drag(find.byType(ListView).last, const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kirim laporan'));
    await tester.pumpAndSettle();

    expect(find.text('Laporan berhasil ditambahkan.'), findsOneWidget);
    await tester.tap(find.text('Laporan').last);
    await tester.pumpAndSettle();
    expect(find.text('Jl. Contoh, Kecamatan Pusat'), findsOneWidget);
  });
}

  import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:customer_dashboard/screens/orders_dashboard.dart';

void main() {
  testWidgets('Filter icon toggles filter widget visibility', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: OrdersDashboard()));

    expect(find.text('Filter by Customer:'), findsNothing);

    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pumpAndSettle();

    expect(find.text('Filter by Customer:'), findsOneWidget);
  });
}

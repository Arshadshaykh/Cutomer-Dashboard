import 'package:customer_dashboard/data/model/order_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/filter_utils.dart';

void main() {
  group('Order Filtering', () {
    final orders = [
      Order(orderId: 'A001', customer: 'John', items: [], createdDate: DateTime(2023, 6, 1), isDelivered: false),
      Order(orderId: 'A002', customer: 'Jane', items: [], createdDate: DateTime(2023, 6, 5), isDelivered: true),
      Order(orderId: 'A003', customer: 'Allen', items: [], createdDate: DateTime(2023, 6, 10), isDelivered: false),
      Order(orderId: 'A004', customer : 'Alice', items: [], createdDate: DateTime(2023, 6, 15), isDelivered: true),
      Order(orderId: 'A005', customer: 'Bob', items: [], createdDate: DateTime(2023, 6, 20), isDelivered: false),
      Order(orderId: 'A006', customer: 'Eve', items: [], createdDate: DateTime(2023, 6, 25), isDelivered: true)
    ];

    test('Filter by customer name', () {
      final result = filterOrders(
        orders,
        selectedCustomers: ['John'],
        startDate: null,
        endDate: null,
        searchQuery: '',
        orderIdQuery: '',
      );
      expect(result.length, 1);
      expect(result.first.customer, 'John');
    });

    test('Filter by date range', () {
      final result = filterOrders(
        orders,
        selectedCustomers: [],
        startDate: DateTime(2023, 6, 2),
        endDate: DateTime(2023, 6, 10),
        searchQuery: '',
        orderIdQuery: '',
      );
      expect(result.length, 1);
      expect(result.first.orderId, 'A002');
    });

    test('Filter by order ID query', () {
      final result = filterOrders(
        orders,
        selectedCustomers: [],
        startDate: null,
        endDate: null,
        searchQuery: '',
        orderIdQuery: 'A001',
      );
      expect(result.length, 1);
      expect(result.first.orderId, 'A001');
    });
  });
}

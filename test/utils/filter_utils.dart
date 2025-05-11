import 'package:customer_dashboard/data/model/order_model.dart';


List<Order> filterOrders(
  List<Order> orders, {
  required List<String> selectedCustomers,
  required DateTime? startDate,
  required DateTime? endDate,
  required String searchQuery,
  required String orderIdQuery,
}) {
  List<Order> filtered = List.from(orders);

  if (selectedCustomers.isNotEmpty) {
    filtered = filtered
        .where((order) => selectedCustomers.contains(order.customer))
        .toList();
  }

  if (startDate != null) {
    filtered = filtered
        .where((order) =>
            DateTime.tryParse(order.createdDate.toString())?.isAfter(startDate) ?? false)
        .toList();
  }

  if (endDate != null) {
    filtered = filtered
        .where((order) =>
            DateTime.tryParse(order.createdDate.toString())?.isBefore(endDate.add(Duration(days: 1))) ?? false)
        .toList();
  }

  if (searchQuery.isNotEmpty) {
    final query = searchQuery.toLowerCase();
    filtered = filtered
        .where((order) =>
            order.customer.toLowerCase().contains(query) ||
            order.items
                .map((item) => item.product?.toLowerCase() ?? '')
                .join(' ')
                .contains(query))
        .toList();
  }

  if (orderIdQuery.isNotEmpty) {
    final query = orderIdQuery.toLowerCase();
    filtered = filtered
        .where((order) => order.orderId.toLowerCase().contains(query))
        .toList();
  }

  return filtered;
}

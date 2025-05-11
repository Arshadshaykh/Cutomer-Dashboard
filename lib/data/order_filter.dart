import 'package:customer_dashboard/data/model/order_model.dart';

class OrderFilter {
  final List<Order> orders;
  bool sortAscending;
  String orderIdQuery;
  String searchQuery;
  List<String> selectedCustomerList;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  OrderFilter({
    required this.orders,
    this.sortAscending = true,
    this.orderIdQuery = '',
    this.searchQuery = '',
    this.selectedCustomerList = const [],
    this.selectedStartDate,
    this.selectedEndDate,
  });

  List<Order> get filteredOrders {
    List<Order> filtered = sortedOrders;
    
    if (orderIdQuery.isNotEmpty) {
      final idQuery = orderIdQuery.toLowerCase();
      filtered = filtered.where((order) => order.orderId.toLowerCase().contains(idQuery)).toList();
    }
    
    if (selectedCustomerList.isNotEmpty) {
      filtered = filtered.where((order) => selectedCustomerList.contains(order.customer)).toList();
    }

    if (selectedStartDate != null) {
      filtered = filtered.where((order) {
        final created = DateTime.tryParse(order.createdDate.toString() ?? '');
        return created != null && created.isAfter(selectedStartDate!);
      }).toList();
    }

    if (selectedEndDate != null) {
      filtered = filtered.where((order) {
        final created = DateTime.tryParse(order.createdDate.toString() ?? '');
        return created != null && created.isBefore(selectedEndDate!.add(Duration(days: 1)));
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((order) {
        final customer = order.customer.toString().toLowerCase() ?? '';
        final items = (order.items).map((item) => item.product.toString().toLowerCase() ?? '').join(' ');
        return customer.contains(query) || items.contains(query);
      }).toList();
    }

    return filtered;
  }

  List<Order> get sortedOrders {
    List<Order> sorted = [...orders];
    sorted.sort((a, b) {
      int totalA = a.items.fold(0, (sum, item) => sum + (item.price).toInt());
      int totalB = b.items.fold(0, (sum, item) => sum + (item.price).toInt());
      return sortAscending ? totalA.compareTo(totalB) : totalB.compareTo(totalA);
    });
    return sorted;
  }

  // You can add more methods here for specific logic if needed.
}

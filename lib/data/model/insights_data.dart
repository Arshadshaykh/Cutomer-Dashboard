import 'package:customer_dashboard/data/model/order_model.dart';

class InsightsData {
  final int totalOrders;
  final int uniqueCustomers;
  final String topProduct;
  final int highValueOrderCount;
  final int totalRevenue;

  InsightsData({
    required this.totalOrders,
    required this.uniqueCustomers,
    required this.topProduct,
    required this.highValueOrderCount,
    required this.totalRevenue,
  });

  factory InsightsData.fromOrders(List<Order> orders) {
    final Map<String, int> customerTotals = {};
    final Map<String, int> productFrequency = {};
    int highValueOrderCount = 0;

    for (var order in orders) {
      int total = 0;

      for (var item in order.items) {
        total += (item.price as num).toInt();
        productFrequency[item.product] =
            (productFrequency[item.product] ?? 0) + 1;
      }

      customerTotals[order.customer] =
          (customerTotals[order.customer] ?? 0) + total;

      if (total > 2000) {
        highValueOrderCount++;
      }
    }
    String topProduct = '';
    if (productFrequency.isNotEmpty) {
      topProduct =
          productFrequency.entries
              .reduce((a, b) => a.value > b.value ? a : b)
              .key;
    }
    int totalRevenue = orders.fold(0, (sum, order) => sum + order.totalPrice);
    return InsightsData(
      totalOrders: orders.length,
      uniqueCustomers: customerTotals.length,
      topProduct: topProduct,
      highValueOrderCount: highValueOrderCount,
      totalRevenue: totalRevenue,
    );
  }
}

import 'dart:math';

import 'package:customer_dashboard/data/model/order_model.dart';

final List<String> customers = [
  "Arshad Shaikh",
  "John Doe",
  "Jane Smith",
  "Alice Brown",
  "Bob Johnson",
  "Eve Davis",
];

final List<Map<String, dynamic>> products = [
  {"product": "Shoes", "price": 1200},
  {"product": "Socks", "price": 200},
  {"product": "Shirt", "price": 1500},
  {"product": "Pants", "price": 1800},
  {"product": "Jacket", "price": 2500},
  {"product": "Hat", "price": 800},
  {"product": "Gloves", "price": 600},
  {"product": "Belt", "price": 500},
  {"product": "Scarf", "price": 700},
  {"product": "Watch", "price": 3000},
  {"product": "Kurta", "price": 1000},
  {"product": "Saree", "price": 3500},
  {"product": "Salwar Suit", "price": 2200},
  {"product": "Jeans", "price": 1700},
  {"product": "T-shirt", "price": 900},
  {"product": "Dupatta", "price": 450},
  {"product": "Chappal", "price": 600},
  {"product": "Sandals", "price": 1100},
  {"product": "Ethnic Wear", "price": 3000},
  {"product": "Backpack", "price": 1800},
];

final List<Order> orders =
    generateRandomOrders().map((map) => Order.fromMap(map)).toList();

List<Map<String, dynamic>> generateRandomOrders() {
  final random = Random();
  List<Map<String, dynamic>> generatedOrders = [];

  for (int i = 100; i < 150; i++) {
    String orderId = 'A$i';
    String customer = customers[random.nextInt(customers.length)];

    List<Map<String, dynamic>> shuffledProducts = List.from(products)
      ..shuffle();
    int itemCount = 2 + random.nextInt(4); // 2 to 5 items

    DateTime createdDate = DateTime.now().subtract(
      Duration(days: random.nextInt(30)),
    );
    bool isDelivered = random.nextBool() ;

    generatedOrders.add({
      "orderId": orderId,
      "customer": customer,
      "items": shuffledProducts.take(itemCount).toList(),
      "isDelivered": isDelivered,
      "createdDate": createdDate.toIso8601String(),
    });
  }

  return generatedOrders;
}

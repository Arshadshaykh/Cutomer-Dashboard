class Item {
  final String product;
  final int price;

  Item({required this.product, required this.price});

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      product: map['product'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'price': price,
    };
  }
}

class Order {
  final String orderId;
  final String customer;
  final bool isDelivered;
  final List<Item> items;
  final DateTime createdDate;


  Order({
    required this.orderId,
    required this.customer,
    required this.isDelivered,
    required this.items,
    required this.createdDate,
  });

  int get totalPrice => items.fold(0, (sum, item) => sum + item.price);

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] ?? '',
      customer: map['customer'] ?? '',
      isDelivered: map['isDelivered'] ?? '',
      items: (map['items'] as List)
          .map((itemMap) => Item.fromMap(itemMap))
          .toList(),
          createdDate: DateTime.parse(map['createdDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'customer': customer,
      'isDelivered': isDelivered,
      'items': items.map((e) => e.toMap()).toList(),
      'createdDate': createdDate.toIso8601String(),
    };
  }
}

import 'package:customer_dashboard/constants/app_colors.dart';
import 'package:customer_dashboard/data/model/order_model.dart';
import 'package:flutter/material.dart';
import '../widgets/order_card.dart';

class CustomerOrdersScreen extends StatelessWidget {
  final String customerName;
  final List<Order> orders;

  const CustomerOrdersScreen({super.key, 
    required this.customerName,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    final customerOrders =
        orders.where((order) => order.customer == customerName).toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        surfaceTintColor: AppColors.transparent,
        title: Text("$customerName's Orders"),
      ),
      body:
          customerOrders.isEmpty
              ? Center(child: Text('No orders for this customer.'))
              : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: customerOrders.length,
                itemBuilder:
                    (context, index) => OrderCard(order: customerOrders[index]),
              ),
    );
  }
}

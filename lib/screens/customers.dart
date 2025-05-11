import 'package:customer_dashboard/data/orders_sample.dart';
import 'package:flutter/material.dart';
import 'package:customer_dashboard/constants/app_sizes.dart';
import 'package:customer_dashboard/constants/app_colors.dart';

import 'package:customer_dashboard/screens/customer_orders.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<String> allCustomers = [];
  List<String> filteredCustomers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allCustomers = customers;
    filteredCustomers = List.from(allCustomers);
  }

  void _searchCustomer(String query) {
    final q = query.toLowerCase();
    setState(() {
      filteredCustomers =
          allCustomers.where((name) => name.toLowerCase().contains(q)).toList();
    });
  }

  void openCustomerOrders(String customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => CustomerOrdersScreen(customerName: customer, orders: orders),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search customers...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.cornerRadius),
                ),
              ),
              onChanged: _searchCustomer,
            ),
            SizedBox(height: AppSizes.spacing),
            Expanded(
              child: ListView.separated(
                itemCount: filteredCustomers.length,
                separatorBuilder: (_, __) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final customer = filteredCustomers[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.darkBlue,
                      child: Text(
                        customer.substring(0, 1).toUpperCase(),
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    title: Text(customer, style: TextStyle(fontSize: 16)),
                    trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () => openCustomerOrders(customer),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

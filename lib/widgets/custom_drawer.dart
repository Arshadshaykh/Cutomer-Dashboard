import 'package:customer_dashboard/constants/app_colors.dart';
import 'package:customer_dashboard/screens/customers.dart';
import 'package:customer_dashboard/screens/orders_dashboard.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.darkBlue),
            child: Text(
              'Dashboard',
              style: TextStyle(color: AppColors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Orders'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OrdersDashboard();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Customers'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CustomerListScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


import 'package:customer_dashboard/screens/orders_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer Orders Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OrdersDashboard(),
    );
  }
}

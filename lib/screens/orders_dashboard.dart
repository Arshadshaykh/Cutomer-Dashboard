import 'package:customer_dashboard/constants/app_colors.dart';
import 'package:customer_dashboard/constants/app_sizes.dart';
import 'package:customer_dashboard/data/order_filter.dart';
import 'package:customer_dashboard/data/orders_sample.dart';
import 'package:customer_dashboard/screens/customer_orders.dart';
import 'package:customer_dashboard/widgets/customer_filter.dart';
import 'package:customer_dashboard/widgets/custom_drawer.dart';
import 'package:customer_dashboard/widgets/empty.dart';
import 'package:customer_dashboard/widgets/insights_panel.dart';
import 'package:customer_dashboard/widgets/order_card.dart';
import 'package:flutter/material.dart';

class OrdersDashboard extends StatefulWidget {
  const OrdersDashboard({super.key});

  @override
  _OrdersDashboardState createState() => _OrdersDashboardState();
}

class _OrdersDashboardState extends State<OrdersDashboard> {
  bool showFilter = false;
  TextEditingController searchController = TextEditingController();
  OrderFilter? orderFilter;

  @override
  void initState() {
    super.initState();
    orderFilter = OrderFilter(orders: orders); // Initialize with the orders
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
      backgroundColor: AppColors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        surfaceTintColor: AppColors.transparent,
        title: Text(
          'Customer Orders',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_rounded),
            tooltip: 'Filter',
            onPressed: () {
              setState(() {
                showFilter = !showFilter;
              });
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCrossFade(
              duration: Duration(milliseconds: 300),
              crossFadeState:
                  showFilter
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              firstChild: Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.spacing),

                    CustomerFilterWidget(
                      allCustomers: customers,
                      selectedCustomers:
                          orderFilter?.selectedCustomerList ?? [],
                      onSelectionChanged: (newList) {
                        setState(() {
                          orderFilter?.selectedCustomerList = newList;
                        });
                      },
                      startDate: orderFilter?.selectedStartDate,
                      endDate: orderFilter?.selectedEndDate,
                      onDateChanged: (start, end) {
                        setState(() {
                          orderFilter?.selectedStartDate = start;
                          orderFilter?.selectedEndDate = end;
                        });
                      },
                      orderIdQuery: orderFilter?.orderIdQuery ?? '',
                      onOrderIdChanged: (query) {
                        setState(() {
                          orderFilter?.orderIdQuery = query;
                        });
                      },
                    ),

                    SizedBox(height: AppSizes.spacing),
                  ],
                ),
              ),
              secondChild: SizedBox(height: 0, width: double.infinity),
            ),

            InsightsPanel(orders: orderFilter?.filteredOrders ?? []),
            Expanded(
              child: ListView.builder(
                itemCount: orderFilter?.filteredOrders.length ?? 0,
                itemBuilder: (context, index) {
                  final order = orderFilter?.filteredOrders[index];
                  return TweenAnimationBuilder(
                    tween: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    builder: (context, offset, child) {
                      return Transform.translate(
                        offset: Offset(offset.dx * 30, 0),
                        child: Opacity(
                          opacity: 1 - offset.dx.abs(),
                          child: child,
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () => openCustomerOrders(order?.customer ?? ''),
                      child:
                          order != null
                              ? OrderCard(order: order)
                              : const PlaceholderCard(),
                    ),
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

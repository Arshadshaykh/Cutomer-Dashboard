import 'package:customer_dashboard/data/model/insights_data.dart';
import 'package:customer_dashboard/data/model/order_model.dart';
import 'package:customer_dashboard/screens/customers.dart';
import 'package:flutter/material.dart';
import 'package:customer_dashboard/constants/app_colors.dart';
import 'package:customer_dashboard/constants/app_sizes.dart';
import 'package:intl/intl.dart';

class InsightsPanel extends StatelessWidget {
  final List<Order> orders;

  const InsightsPanel({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final insights = InsightsData.fromOrders(orders);
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          int columns = maxWidth > 600 ? 4 : 2;

          return Wrap(
            spacing: AppSizes.spacing,
            runSpacing: AppSizes.spacing,
            children: [
              insightCard(
                title: 'Total Orders',
                data: '${insights.totalOrders}',
                width: maxWidth / columns - AppSizes.spacing,
                icon: Icons.analytics_rounded,
              ),
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerListScreen(),
                      ),
                    ),
                child: insightCard(
                  title: 'Customers',
                  data: '${insights.uniqueCustomers}',
                  width: maxWidth / columns - AppSizes.spacing,
                  icon: Icons.groups_rounded,
                  isClickable: true,
                ),
              ),
              insightCard(
                title: 'Top Revenue',
                data:
                    insights.totalRevenue > 0
                        ? '₹ ${NumberFormat('#,##0').format(insights.totalRevenue)}'
                        : 'No data available',
                width: maxWidth / columns - AppSizes.spacing,
                icon: Icons.currency_rupee_rounded,
              ),
              insightCard(
                title: 'High Value Orders',
                data: '${insights.highValueOrderCount}',
                width: maxWidth / columns - AppSizes.spacing,
                icon: Icons.bolt_rounded,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget insightCard({
    required String title,
    required String data,
    required double width,
    required IconData icon,
    bool isClickable = false,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.darkBlue, AppColors.darkBlue.withAlpha(150)],
        ),
        borderRadius: BorderRadius.circular(AppSizes.cornerRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkThemeSecondary.withAlpha(30),
            blurRadius: AppSizes.padding,
            spreadRadius: AppSizes.cardMargin,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isClickable)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.white,
                  size: 16,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: AppColors.white),
            ],
          ),
        ],
      ),
    );
  }
}

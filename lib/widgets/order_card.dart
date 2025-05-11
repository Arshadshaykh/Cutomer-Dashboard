import 'package:customer_dashboard/constants/app_colors.dart';
import 'package:customer_dashboard/constants/app_sizes.dart';
import 'package:customer_dashboard/data/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  int getTotal() {
    return order.items.fold(0, (sum, item) => sum + (item.price).toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.cardMargin),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                // margin: EdgeInsets.symmetric(vertical: AppSizes.cardMargin),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.cornerRadius),
                  // color: AppColors.darkThemeMain,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.grey,
                      AppColors.grey.withAlpha(200),
                      AppColors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey,
                      blurRadius: 10,
                      offset: Offset(5, 6),
                    ),
                  ],
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  childrenPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.cornerRadius),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${order.orderId} - ${order.customer}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Total: ₹${getTotal()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${order.items.length} ',
                                  style: TextStyle(
                                    color: AppColors.darkBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Items',
                                  style: TextStyle(
                                    color: AppColors.darkThemeSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Order Date: ',
                                  style: TextStyle(
                                    color: AppColors.darkThemeMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${order.createdDate.day}/${order.createdDate.month}/${order.createdDate.year}',
                                  style: TextStyle(
                                    color: AppColors.darkThemeSecondary,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.darkBlue,
                    child: Text(
                      order.customer[0],
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                  children:
                      order.items
                          .map<Widget>(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.product,
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('₹${item.price}'),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppSizes.cornerRadius),
                      bottomLeft: Radius.circular(AppSizes.cornerRadius),
                    ),
                    color: order.isDelivered ? AppColors.green : AppColors.red,
                    boxShadow: [
                      BoxShadow(
                        color:
                            order.isDelivered
                                ? AppColors.green.withAlpha(120)
                                : AppColors.red.withAlpha(120),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Text(
                    order.isDelivered ? 'Delivered' : 'Pending',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

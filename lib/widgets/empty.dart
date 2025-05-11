import 'package:customer_dashboard/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PlaceholderCard extends StatelessWidget {
  const PlaceholderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: const Text(
          'No Order Data Available',
          style: TextStyle(
            color: AppColors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

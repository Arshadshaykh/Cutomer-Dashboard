import 'package:customer_dashboard/constants/app_colors.dart';
import 'package:customer_dashboard/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerFilterWidget extends StatefulWidget {
  final List<String> allCustomers;
  final List<String> selectedCustomers;
  final Function(List<String>) onSelectionChanged;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime? start, DateTime? end) onDateChanged;
  final String orderIdQuery;
  final Function(String) onOrderIdChanged;

  const CustomerFilterWidget({super.key, 
    required this.allCustomers,
    required this.selectedCustomers,
    required this.onSelectionChanged,
    required this.startDate,
    required this.endDate,
    required this.onDateChanged,
    required this.orderIdQuery,
    required this.onOrderIdChanged,
  });

  @override
  State<CustomerFilterWidget> createState() => _CustomerFilterWidgetState();
}

class _CustomerFilterWidgetState extends State<CustomerFilterWidget> {
  late List<String> _selected;
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedCustomers);
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  void _toggleSelection(String customer) {
    setState(() {
      if (_selected.contains(customer)) {
        _selected.remove(customer);
      } else {
        _selected.add(customer);
      }
    });
    widget.onSelectionChanged(_selected);
  }

  Future<void> _selectDate(bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStart
              ? (_startDate ?? DateTime.now())
              : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.darkBlue,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
              
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.darkBlue),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
        widget.onDateChanged(_startDate, _endDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.spacing,
      children: [
        // Filter by Order ID
        TextField(
          decoration: InputDecoration(
            hintText: 'Search by Order ID',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cornerRadius),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          onChanged: widget.onOrderIdChanged,
        ),

        // Filter by Customer
        ...[
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.cornerRadius),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            dropdownColor: AppColors.white,
            hint: Text(
              "Select Customer",
              style: TextStyle(color: AppColors.darkThemeMain, fontSize: 16),
            ),
            value: null,
            items:
                widget.allCustomers
                    // .where((c) => !_selected.contains(c))
                    .map(
                      (customer) => DropdownMenuItem<String>(
                        value: customer,
                        child: Text(
                          customer,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                    .where((c) => !_selected.contains(c))
                    .toList(),
            onChanged: (value) {
              if (value != null) _toggleSelection(value);
            },
          ),
          if (_selected.isNotEmpty)
            Wrap(
              spacing: AppSizes.spacing,
              runSpacing: AppSizes.spacing,
              children:
                  _selected
                      .map(
                        (customer) => Chip(
                          backgroundColor: AppColors.white,
                          label: Text(customer),
                          onDeleted: () => _toggleSelection(customer),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.cornerRadius,
                            ),
                          ),
                          side: BorderSide(
                            color: AppColors.darkBlue,
                            width: 1.4,
                          ),
                        ),
                      )
                      .toList(),
            ),
        ],

        // Filter by Date
        ...[
          Text(
            'Filter by Date:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            spacing: AppSizes.spacing,
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    side: BorderSide(color: AppColors.darkBlue, width: 1.4),
                  ),
                  icon: Icon(Icons.date_range, color: AppColors.darkThemeMain),
                  label: Text(
                    _startDate != null
                        ? dateFormatter.format(_startDate!)
                        : 'Start Date',
                    style: TextStyle(color: AppColors.darkThemeMain),
                  ),
                  onPressed: () => _selectDate(true),
                ),
              ),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    side: BorderSide(color: AppColors.darkBlue, width: 1.4),
                  ),
                  icon: Icon(Icons.date_range, color: AppColors.darkThemeMain),
                  label: Text(
                    _endDate != null
                        ? dateFormatter.format(_endDate!)
                        : 'End Date',
                    style: TextStyle(color: AppColors.darkThemeMain),
                  ),
                  onPressed: () => _selectDate(false),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

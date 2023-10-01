import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final String selectedFilter;
  final String selectedCategory;
  final ValueChanged<String?> onFilterChanged;
  final ValueChanged<String?> onCategoryChanged;

  FilterDialog({
    required this.selectedFilter,
    required this.selectedCategory,
    required this.onFilterChanged,
    required this.onCategoryChanged,
  });

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("Filter By: "),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              // Expiry date
              DropdownButton<String>(
                value: widget.selectedFilter,
                onChanged: widget.onFilterChanged,
                items: <String>[
                  'Today',
                  'Next 3 days',
                  'Next 7 days',
                  'Next 14 days',
                  'Next 30 days',
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              // Category
              DropdownButton<String>(
                value: widget.selectedCategory,
                onChanged: widget.onCategoryChanged,
                items: <String>[
                  'All',
                  'Grains',
                  'Milk Product',
                  'Fruits',
                  'Nuts',
                  'Vegetables',
                  'Snacks',
                  'Beverages',
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

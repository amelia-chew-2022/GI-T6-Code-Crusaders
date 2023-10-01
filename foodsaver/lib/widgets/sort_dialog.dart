import 'package:flutter/material.dart';

class SortDialog extends StatefulWidget {
  final String selectedSort;
  final ValueChanged<String?> onChanged;

  SortDialog({required this.selectedSort, required this.onChanged});

  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("Sort By: "),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              DropdownButton<String?>(
                value: widget.selectedSort,
                onChanged: (String? newValue) {
                  // Change the parameter type to String?
                  widget.onChanged(
                      newValue ?? ''); // Provide a default value if null
                },
                items: <String>[
                  'Expiry Date (nearest to furthest)',
                  'Expiry Date (furthest to nearest)',
                  'Quantity (highest to lowest)',
                  'Quantity (lowest to highest)',
                  'Name (A-Z)',
                  'Name (Z-A)',
                  'Category',
                  'Units',
                ].map<DropdownMenuItem<String?>>(
                  (String value) {
                    return DropdownMenuItem<String?>(
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

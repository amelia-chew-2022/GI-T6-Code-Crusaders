import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './inventory.dart';

class AddFoodItem extends StatefulWidget {
  @override
  State<AddFoodItem> createState() => _AddFoodItemState();

  const AddFoodItem({super.key, required this.email});
  final String email;
}

class _AddFoodItemState extends State<AddFoodItem> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();
  TextEditingController quantityeController = TextEditingController();

  String unit = 'grams';
  var units = ['grams', 'milliliters', 'litres', 'loaf', 'kilograms'];

  String cat = 'Grains';
  var cats = [
    'Grains',
    'Milk Product',
    'Fruits',
    'Nuts',
    'Vegetables',
    'Snacks',
    'Beverages'
  ];

  @override
  void initState() {
    super.initState();
    expireDateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          key: _formkey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: IconButton(
                            icon: Icon(Icons.chevron_left_rounded, size: 28),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                          const Text("Add Items",
                              style: TextStyle(
                                color: Color(0xFF003B2B),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      )),
                  const Divider(
                    color: Color(0xFF007F5C),
                    thickness: 0.5,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF007F5C),
                          )),
                          labelText: "Food Item",
                          suffixIcon: Icon(Icons.food_bank),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Food Item';
                          }
                          return null;
                        },
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: TextFormField(
                        controller: expireDateController,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today),
                            labelText: "Expiry Date",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xFF007F5C),
                            ))),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Expiry Date';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              expireDateController.text = formattedDate;
                            });
                          }
                        },
                      ))),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: quantityeController,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.numbers),
                          labelText: "Quantity",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF007F5C),
                          ))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Quantity';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  Container(
                      height: 78,
                      padding: const EdgeInsets.all(10),
                      child: InputDecorator(
                          decoration: InputDecoration(
                              hintText: "Please select units",
                              labelText: "Unit",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF007F5C),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: unit,
                                  items: units.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      unit = newValue!;
                                    });
                                  })))),
                  Container(
                      height: 78,
                      padding: const EdgeInsets.all(10),
                      child: InputDecorator(
                          decoration: InputDecoration(
                              hintText: "Please select category",
                              labelText: "Category",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF007F5C),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: cat,
                                  items: cats.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      cat = newValue!;
                                    });
                                  })))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Inventory(email: widget.email)));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill input')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Color(0xFF003B2B)),
                          child: const Text("Save"),
                        ),
                      )),
                ],
              )))),
    );
  }
}

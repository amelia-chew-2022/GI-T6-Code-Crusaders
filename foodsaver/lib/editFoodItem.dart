import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './inventory.dart';

class EditFoodItem extends StatefulWidget {
  const EditFoodItem(
      {super.key,
      required this.email,
      required this.food,
      required this.quantity,
      required this.units,
      required this.expiryDate,
      required this.category});

  final String email;
  final String food;
  final int quantity;
  final String units;
  final String expiryDate;
  final String category;

  @override
  State<EditFoodItem> createState() => _EditFoodItemState();
}

class _EditFoodItemState extends State<EditFoodItem> {


  final _formkey = GlobalKey<FormState>();
  
  TextEditingController expireDateController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    expireDateController.text = widget.expiryDate;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: widget.food);
    TextEditingController quantityController =TextEditingController(text: widget.quantity.toString());
    String unit = widget.units;
    var units = ['grams', 'milliliters', 'litres', 'loaf', 'kilograms'];

    String cat = widget.category;
    var cats = [
      'Grains',
      'Milk Product',
      'Fruits',
      'Nuts',
      'Vegetables',
      'Snacks',
      'Beverages'
    ];
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
                          const Text("Edit Items",
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
                      controller: quantityController,
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
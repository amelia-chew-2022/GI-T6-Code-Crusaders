import 'package:flutter/material.dart';
import 'package:foodsaver/foodDetails.dart';
import 'addFoodItem.dart';
import 'foodDetails.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import "dart:convert";
import 'package:intl/intl.dart';

class Food {
  final int foodId;
  final String foodItem;
  final String expiryDate;
  final int quantity;
  final String units;
  final String category;

  const Food(
      {required this.foodId,
      required this.foodItem,
      required this.expiryDate,
      required this.quantity,
      required this.units,
      required this.category});
}

class Inventory extends StatefulWidget {
  @override
  State<Inventory> createState() => _InventoryState();

  const Inventory({super.key, required this.email});
  final String email;
}

class _InventoryState extends State<Inventory> {
  Future<List<Food>> getRequest() async {
    String url = "http://127.0.0.1:5000/allFoodItem";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Food> inventoryList = [];
    for (var indvFood in responseData["data"]) {
      Food food = Food(
          foodId: indvFood["id"],
          foodItem: indvFood["foodItem"],
          expiryDate: indvFood["expiryDate"],
          quantity: indvFood["quantity"],
          units: indvFood["units"],
          category: indvFood["category"]);

      //Adding food to the list.
      inventoryList.add(food);
    }
    return inventoryList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Welcome \n" + widget.email,
                              style: const TextStyle(
                                color: Color(0xFF003B2B),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              )),
                          Container(
                              child: IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                          ))
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Inventory",
                              style: TextStyle(
                                color: Color(0xFF003B2B),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          Row(children: [
                            // Sort Function
                            Container(
                                child: IconButton(
                              icon: Icon(Icons.sort),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          scrollable: true,
                                          title: const Text("Filter By: "),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Form(
                                                child: Column(
                                              children: [
                                                TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                          icon:
                                                              Icon(Icons.sort)),
                                                )
                                              ],
                                            )),
                                          ));
                                    });
                              },
                            )),
                            // Add Food Items
                            Container(
                                child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddFoodItem(email: widget.email)));
                              },
                            ))
                          ]),
                        ],
                      )),
                  Divider(
                    color: Color(0xFF007F5C),
                    thickness: 0.5,
                  ),
                  // List of Food
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: FutureBuilder(
                      future: getRequest(),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: DateTime.parse(snapshot
                                                      .data[index].expiryDate)
                                                  .difference(DateTime.parse(
                                                      DateFormat("yyyy-MM-dd")
                                                          .format(
                                                              DateTime.now())))
                                                  .inDays <=
                                              1
                                          ? Color(0xFFD63434)
                                          : DateTime.parse(snapshot.data[index].expiryDate)
                                                      .difference(DateTime.parse(
                                                          DateFormat("yyyy-MM-dd")
                                                              .format(
                                                                  DateTime.now())))
                                                      .inDays <=
                                                  3
                                              ? Color(0xFFFF9800)
                                              : Color(0xFF007F5C),
                                    ),
                                    trailing: Wrap(
                                      spacing: 5, // space between the icons
                                      children: <Widget>[
                                        // View Food Details
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FoodDetails(
                                                            food: snapshot.data[index].foodItem,
                                                            quantity: snapshot.data[index].quantity,
                                                            units: snapshot.data[index].units,
                                                            expiryDate: snapshot.data[index].expiryDate
                                                            )));
                                              
                                            },
                                            icon: const Icon(
                                              Icons.remove_red_eye,
                                              size: 20,
                                            )),
                                        // Edit Food Details
                                        IconButton(
                                            onPressed: () {
                                              snapshot.data[index].foodItem;
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 20,
                                            )),
                                        // Delete Food
                                        IconButton(
                                            onPressed: () {
                                              snapshot.data[index].foodItem;
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 20,
                                            )),
                                      ],
                                    ),
                                    title: Text(
                                      snapshot.data[index].foodItem,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Text(
                                      "Expiring on: " +
                                          snapshot.data[index].expiryDate,
                                      style: TextStyle(
                                          color: DateTime.parse(snapshot
                                                          .data[index]
                                                          .expiryDate)
                                                      .difference(DateTime.parse(
                                                          DateFormat("yyyy-MM-dd").format(
                                                              DateTime.now())))
                                                      .inDays <=
                                                  1
                                              ? Color(0xFFD63434)
                                              : DateTime.parse(snapshot
                                                              .data[index]
                                                              .expiryDate)
                                                          .difference(DateTime.parse(
                                                              DateFormat("yyyy-MM-dd")
                                                                  .format(DateTime.now())))
                                                          .inDays <=
                                                      3
                                                  ? Color(0xFFFF9800)
                                                  : Color(0xFF007F5C)),
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xFF007F5C),
                                    thickness: 0.5,
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ))),
    );
  }
}

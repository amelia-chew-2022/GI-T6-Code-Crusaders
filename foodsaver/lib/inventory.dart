import 'package:flutter/material.dart';
import 'addFoodItem.dart';
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

      //Adding user to the list.
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
                            Container(
                                child: IconButton(
                              icon: Icon(Icons.sort),
                              onPressed: () {
                                // Navigator.pop(context);
                              },
                            )),
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
                                    title: Text(snapshot.data[index].foodItem),
                                    subtitle: Text(
                                      "Expiring on: " +
                                          snapshot.data[index].expiryDate,
                                      style: TextStyle(
                                          color: DateTime.parse(snapshot
                                                          .data[index]
                                                          .expiryDate)
                                                      .difference(DateTime
                                                          .parse(DateFormat(
                                                                  "yyyy-MM-dd")
                                                              .format(DateTime
                                                                  .now())))
                                                      .inDays <=
                                                  1
                                              ? Color(0xFFD63434)
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

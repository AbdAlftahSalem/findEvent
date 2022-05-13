import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfinder/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../model/payment_model.dart';

class DetailRestaurantScreen extends StatefulWidget {
  RestaurantModel restaurantModel;

  DetailRestaurantScreen({
    @required this.restaurantModel,
  });

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  List<PaymentModel> paymentList = [];

  getPay() async {
    FirebaseFirestore.instance
        .collection("Events")
        .doc(widget.restaurantModel.id)
        .collection("Payments")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          paymentList.add(PaymentModel.fromMap(element.data()));
        });
      });
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPay();
    nameController = TextEditingController(text: widget.restaurantModel.name);
    desController = TextEditingController(text: widget.restaurantModel.desc);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.restaurantModel.name,
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Get.defaultDialog(
                title: "Delete",
                middleText: "Are you sure you want to delete this event?",
                actions: [
                  InkWell(
                    onTap: () async {
                      await deleteEvent();
                    },
                    child: Container(
                      width: size.width * 0.15,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: size.width * 0.15,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.restaurantModel.image,
              width: size.width,
              height: size.height * .48,
              fit: BoxFit.cover,
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                    ),
                    controller: nameController,
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10,
                    controller: desController,
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
            Center(
              child: Container(
                width: size.width * .4,
                height: size.height * .06,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                    child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                )),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                "Payment user",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: paymentList.map((e) {
                  return Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  e.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  e.phone,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  e.email,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: size.height * 0.01),
                                // Text(e.address),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              EasyLoading.show(status: "Wait a moment...");
                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(e.userId)
                                  .collection("Tickets")
                                  .doc(e.id)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection("Events")
                                  .doc(widget.restaurantModel.id)
                                  .collection("Payments")
                                  .doc(e.id)
                                  .delete();
                              EasyLoading.dismiss();
                              setState(() async => await getPay());
                            },
                            icon: Icon(Icons.delete_forever),
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  Future<void> deleteEvent() async {
    EasyLoading.show(status: "Wait a moment...");
    await FirebaseFirestore.instance
        .collection("Events")
        .doc(widget.restaurantModel.id)
        .delete();
    EasyLoading.dismiss();
    EasyLoading.showSuccess(
      "Event deleted",
      duration: Duration(seconds: 2),
    );
    Get.back();
  }
}

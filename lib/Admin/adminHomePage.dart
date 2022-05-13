import 'package:eventfinder/Admin/AddEvent.dart';
import 'package:eventfinder/Admin/detail_restaurant_screen.dart';
import 'package:eventfinder/controllers/home_admin_controller.dart';
import 'package:eventfinder/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/local_db.dart';
import '../model/ciema_model.dart';
import '../model/restaurant_model.dart';
import 'detail_screen.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAdminController>(
      init: HomeAdminController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddEvent()));
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Event Finder"),
            leading: IconButton(
              onPressed: () {
                LocalDB.remove("user");
                Future.delayed(Duration.zero, () {
                  Get.offAll(() => LoginScreen());
                });
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Column(
                    children: controller.event.map((e) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => DetailCiema(ciemaModel: e));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: eventWidget(context, e),
                        ),
                      );
                    }).toList(),
                  ),
                  Column(
                    children: controller.cinema.map((e) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => DetailCiema(ciemaModel: e));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: eventWidget(context, e),
                        ),
                      );
                    }).toList(),
                  ),
                  Column(
                    children: controller.restaurant.map((e) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => DetailRestaurantScreen(restaurantModel: e));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: restaurantWidget(context, e),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container eventWidget(BuildContext context, CiemaModel ciema) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              ciema.image,
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          ciema.name,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Date : ${ciema.from[0]} - ${ciema.from[1]} - ${ciema.from[2]}",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Time : ${ciema.time[0]} -  ${ciema.time[1]}",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "Info",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container restaurantWidget(BuildContext context, RestaurantModel restaurant) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              restaurant.image,
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          restaurant.name,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 8),
                      //   child: Text(
                      //     "Date : ${ciema.from[0]} - ${ciema.from[1]} - ${ciema.from[2]}",
                      //     style: TextStyle(fontSize: 14, color: Colors.grey),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 8),
                      //   child: Text(
                      //     "Time : ${ciema.time[0]} -  ${ciema.time[1]}",
                      //     style: TextStyle(fontSize: 14, color: Colors.grey),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "Info",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

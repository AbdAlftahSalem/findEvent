import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventfinder/controllers/home_controller.dart';
import 'package:eventfinder/model/ciema_model.dart';
import 'package:eventfinder/profile_screen.dart';
import 'package:eventfinder/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'detail_resturant.dart';
import 'details_post.dart';
import 'model/restaurant_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Position> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF190F4B),
      appBar: AppBar(
        title: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xFF190F4B),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            Positioned(
              top: 4.2,
              child: Container(
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .04,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF37C19),
                      Color(0xFFE34F3A),
                      Color(0xFFE70B57),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              child: Container(
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.height * .03,
                child: Text("Home",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color(0xFF190F4B),
                ),
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(SearchScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(Icons.search, color: Colors.white, size: 40),
              ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              Get.to(() => ProfileScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(Icons.person, color: Colors.white, size: 40),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: Color(0xFFF190F4B),
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            if (controller.event.length == 0) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * .2,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                        ),
                        items: controller.ads.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    i.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Events",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.event.map((e) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => DetailsPost(
                                      ciemaModel: e,
                                    ),
                                  );
                                },
                                child: eventWidget(context, e),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Restaurants",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.restaurant.map(
                            (e) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    () => DetailResturant(restaurantModel: e),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  child: restaurantWidget(
                                    context,
                                    e,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),

                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      Text(
                        "Cinema",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.cinema.map((e) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => DetailsPost(
                                      ciemaModel: e,
                                    ),
                                  );
                                },
                                child: eventWidget(context, e),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Container eventWidget(BuildContext context, CiemaModel ciema) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
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
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
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
    );
  }

  Container restaurantWidget(BuildContext context, RestaurantModel restaurant) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
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
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
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
    );
  }
}

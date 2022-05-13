import 'package:eventfinder/controllers/search_controller.dart';
import 'package:eventfinder/details_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail_resturant.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      controller.searchText = value;
                      controller.searchByName();
                    },
                  ),
                  controller.searchText.isNotEmpty &&
                          (controller.cinemaResults.isEmpty &&
                              controller.eventResults.isEmpty &&
                              controller.restaurantResults.isEmpty)
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .2),
                          child: Text(
                            "No data found",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              Column(
                                children: controller.cinemaResults.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(DetailsPost(
                                        ciemaModel: e,
                                      ));
                                    },
                                    child: InkWell(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            e.image,
                                          ),
                                        ),
                                        title: Text(e.name),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Column(
                                children: controller.eventResults.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(DetailsPost(
                                        ciemaModel: e,
                                      ));
                                    },
                                    child: InkWell(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            e.image,
                                          ),
                                        ),
                                        title: Text(e.name),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Column(
                                children: controller.restaurantResults.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          DetailResturant(restaurantModel: e));
                                    },
                                    child: InkWell(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            e.image,
                                          ),
                                        ),
                                        title: Text(e.name),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

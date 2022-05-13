import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfinder/controllers/home_controller.dart';
import 'package:eventfinder/model/ciema_model.dart';
import 'package:eventfinder/model/restaurant_model.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  HomeController homeController = Get.find();
  String searchText = '';
  List<CiemaModel> cinemaResults = [];
  List<CiemaModel> eventResults = [];
  List<RestaurantModel> restaurantResults = [];

  searchByName() {
    if (searchText.isEmpty) {
      cinemaResults = [];
      eventResults = [];
      restaurantResults = [];
      update();
    } else {
      cinemaResults = homeController.cinema
          .where((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();

      eventResults = homeController.event
          .where((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();

      restaurantResults = homeController.restaurant
          .where((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      update();
    }
  }
}

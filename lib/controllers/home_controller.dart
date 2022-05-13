import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfinder/model/ads_model.dart';
import 'package:eventfinder/model/ciema_model.dart';
import 'package:get/get.dart';

import '../model/restaurant_model.dart';

class HomeController extends GetxController {
  List<CiemaModel> cinema = [];
  List<RestaurantModel> restaurant = [];
  List<CiemaModel> event = [];
  List<ADSModel> ads = [];

  getCinema() async {
    FirebaseFirestore.instance.collection('Events').snapshots().listen((data) {
      cinema.clear();
      data.docs.forEach((doc) {
        if (doc.data()['type'] == 'cinema') {
          cinema.add(CiemaModel.fromJson(doc.data()));
          update();
        }
      });
    });
    update();
  }

  getRestaurant() async {
    FirebaseFirestore.instance.collection('Events').snapshots().listen((data) {
      restaurant.clear();
      data.docs.forEach((doc) {
        if (doc.data()['type'] == 'restaurant') {
          restaurant.add(RestaurantModel.fromMap(doc.data()));
          update();
        }
      });
    });
    update();
  }

  getEvent() async {
    FirebaseFirestore.instance.collection('Events').snapshots().listen((data) {
      event.clear();
      data.docs.forEach((doc) {
        if (doc.data()['type'] == 'event') {
          event.add(CiemaModel.fromJson(doc.data()));
          update();
        }
      });
    });
    update();
  }

  getAds() async {
    FirebaseFirestore.instance.collection('ADS').snapshots().listen((data) {
      ads.clear();
      data.docs.forEach((doc) {
        ads.add(ADSModel.fromMap(doc.data()));
        update();
      });
    });
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getAds();
    await getCinema();
    await getRestaurant();
    await getEvent();
  }
}

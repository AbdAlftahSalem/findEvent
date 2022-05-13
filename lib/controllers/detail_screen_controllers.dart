import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DetailScreenController extends GetxController {
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  addTicket({
    @required String date,
    @required String name,
    @required String price,
    @required String time,
    @required String id,
  }) async {

    Map<String, String> data = {
      "name": name,
      "price": price,
      "date": date,
      "id": id,
      "time": time,
    };

    print(data);

    EasyLoading.show(status: "Wait a moment...");
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("Tickets")
        .doc(id)
        .set(data);
    EasyLoading.dismiss();
    EasyLoading.show(status: "Ticket added successfully");
    Future.delayed(Duration(microseconds: 700), () {
      EasyLoading.dismiss();
    });
  }
}

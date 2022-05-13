import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  List<TicketsModel> tickets = [];

  getTickets() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("Tickets")
        .snapshots()
        .listen((data) {
      data.docs.forEach((element) {
        tickets.add(TicketsModel.fromMap(element.data()));
        update();
      });
    });
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getTickets();
  }
}

class TicketsModel {
  String date, id, name, price, time;

  TicketsModel({
    @required this.date,
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'time': this.time,
    };
  }

  factory TicketsModel.fromMap(Map<String, dynamic> map) {
    return TicketsModel(
      date: map['date'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      time: map['time'] as String,
    );
  }
}

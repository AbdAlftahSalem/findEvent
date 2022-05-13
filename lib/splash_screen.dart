import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfinder/Homepage.dart';
import 'package:eventfinder/controllers/local_db.dart';
import 'package:eventfinder/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Admin/adminHomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  nextScreen() {
    var user = LocalDB.get("user");
    print("*************************");
    print(user);
    try {
      if (user != null) {
        if (user["type"] == "admin") {
          Future.delayed(Duration.zero).then((_) {
            Get.offAll(() => AdminHomePage());
          });
        } else {
          Future.delayed(Duration.zero, () {
            Get.offAll(() => HomePage());
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          Get.offAll(() => LoginScreen());
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          InkWell(
            onTap: nextScreen,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.6,
                    left: MediaQuery.of(context).size.width * 0.2),
                child: Center(
                  child: Text(
                    "Let's go!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

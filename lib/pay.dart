import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfinder/controllers/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'controllers/detail_screen_controllers.dart';

class Pay extends StatefulWidget {
  // final String name, type, image, price, id, docId;
  // final bool state;
  // final List from, time;

  // Pay(
  //     {@required this.name,
  //     @required this.type,
  //     @required this.image,
  //     @required this.price,
  //     @required this.id,
  //     @required this.docId,
  //     @required this.from,
  //     @required this.time,
  //     @required this.state});

  DateTime dateTime;
  String hour, min, idEvent, nameEvent;

  Pay({
    @required this.dateTime,
    @required this.hour,
    @required this.min,
    @required this.idEvent,
    @required this.nameEvent,
  });

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  String myName = "", myEmail = "", myPhone = "", myId = "", myType = "user";

  @override
  void initState() {
    var user = LocalDB.get("user");
    if (user != null) {
      myName = user["name"];
      myEmail = user["email"];
      myPhone = user["phone"];
      myId = user["id"];
      myType = user["type"];
    }
    super.initState();
  }

  TextEditingController cardNumber = TextEditingController();
  TextEditingController expireDate = TextEditingController();
  TextEditingController cvv = TextEditingController();
  DetailScreenController controller = Get.put(DetailScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pay"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            component(context, Icons.payment, "Card Number", false, false,
                cardNumber),
            SizedBox(
              height: 20,
            ),
            component(context, Icons.payments, "Expire Date", false, false,
                expireDate),
            SizedBox(
              height: 20,
            ),
            component(context, Icons.card_membership, "CVV", false, false, cvv),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                saveUserData();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  "Pay",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget component(context, IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
        ),
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }

  saveUserData() async {
    if (cardNumber.text.isEmpty ||
        expireDate.text.isEmpty ||
        cvv.text.isEmpty) {
      EasyLoading.dismiss();
      Future.delayed(Duration(seconds: 2)).then((value) {
        EasyLoading.showError("Please fill all the fields");
      });
    } else {
      EasyLoading.show(status: "Wait a moment...");
      String id = generateRandomString(10);
      await FirebaseFirestore.instance
          .collection("Events")
          .doc(widget.idEvent)
          .collection("Payments")
          .doc(id)
          .set({
        "cardNumber": cardNumber.text,
        "expireDate": expireDate.text,
        "cvv": cvv.text,
        "userId": myId,
        "name": myName,
        "email": myEmail,
        "phone": myPhone,
        "date": DateTime.now().toString(),
        "id": id,
      });

      await controller.addTicket(
        date: widget.dateTime.toString(),
        name: widget.nameEvent,
        price: "150",
        time: "${widget.hour}:${widget.min}",
        id: id,
      );
      setState(() {
        cardNumber.clear();
        expireDate.clear();
        cvv.clear();
      });

      EasyLoading.dismiss();
      Future.delayed(Duration(seconds: 2)).then((value) {
        EasyLoading.showSuccess("Success");
        Get.back();
      });
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfinder/pay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  final String name, type, image, price, id, docId;
  final bool state;
  final List from, time;

  Details(this.name, this.type, this.image, this.price, this.id, this.docId,
      this.from, this.time, this.state);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                  boxShadow: [
                    //BoxShadow(spreadRadius: 1,color: Colors.black12)
                  ],
                  //color: Colors.white,
                  image: DecorationImage(
                    image: FirebaseImage(
                        "gs://event-finder-a1dbf.appspot.com/${widget.image}"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100)),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "${widget.name}",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                child: Text(
              "Date ${widget.from[0]}-${widget.from[1]}-${widget.from[2]} Time ${widget.time[0]}:${widget.time[1]}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            )),
            SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: widget.state
                    ? Text(
                        "${widget.price} SAR (Many Seats Avalible)",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[800]),
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        "${widget.price} SAR (Few Seats Avalible)",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.red[800]),
                        overflow: TextOverflow.ellipsis,
                      )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
            ),
            widget.id != FirebaseAuth.instance.currentUser.uid
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Pay(
                                    // widget.name,
                                    // widget.type,
                                    // widget.image,
                                    // widget.price,
                                    // widget.id,
                                    // widget.docId,
                                    // widget.from,
                                    // widget.time,
                                    // widget.state,
                                    // type: '',
                                    // image: widget.image,
                                    // name: widget.name,
                                    // time: widget.time,
                                    // price: '100',
                                    // state: false,
                                    // from: widget.from,
                                    // docId: 'Doc id',
                                    // id: widget.id,
                                    // type: widget.type,
                                  )));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        "Pay",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                : Container(),
            widget.id == FirebaseAuth.instance.currentUser.uid
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Available",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple[700])),
                      button("Many Seats", widget.state, () {
                        FirebaseFirestore.instance
                            .collection("Events")
                            .doc(widget.docId)
                            .update({"state": true}).then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                      widget.name,
                                      widget.type,
                                      widget.image,
                                      widget.price,
                                      widget.id,
                                      widget.docId,
                                      widget.from,
                                      widget.time,
                                      true)));
                        });
                      }),
                      button("Few Seats", !widget.state, () {
                        FirebaseFirestore.instance
                            .collection("Events")
                            .doc(widget.docId)
                            .update({"state": false}).then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                      widget.name,
                                      widget.type,
                                      widget.image,
                                      widget.price,
                                      widget.id,
                                      widget.docId,
                                      widget.from,
                                      widget.time,
                                      false)));
                        });
                      })
                    ],
                  )
                : Container(),
            SizedBox(
              height: 50,
            ),
            widget.id == FirebaseAuth.instance.currentUser.uid
                ? InkWell(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection("Events")
                          .doc(widget.docId)
                          .delete()
                          .then((value) {
                        Navigator.pop(context);
                        EasyLoading.showSuccess("Deleted Success...",
                            duration: Duration(milliseconds: 1200));
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.circular(8)),
                      child: Text("Delete",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  )
                : Container()
          ]))),
    );
  }

  Widget button(String title, bool active, Function func) {
    return InkWell(
      onTap: func,
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 37,
        decoration: BoxDecoration(
            color: active ? Colors.deepPurple[600] : Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Text("$title",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : Colors.deepPurple[600])),
      ),
    );
  }
}

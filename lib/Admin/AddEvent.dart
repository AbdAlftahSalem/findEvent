
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  File image;
  List<String> from = [];
  List<String> time = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _longController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title: Text(
          "Add Event",
          style: TextStyle(
              fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        ImagePicker _picker = ImagePicker();
                        _picker.getImage(source: ImageSource.gallery).then((value) {
                          if(value != null){
                            setState(() {
                              image = File(value.path);
                            });
                          }
                        });
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              size: 22,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Upload Photo",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  fontFamily: 'Cairo'),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            image != null ? Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              width: 120,
              height: 120,
              child: ClipRRect(borderRadius: BorderRadius.circular(100),child: Image.file(image , fit: BoxFit.cover,)),
            ):Container(),
            Container(
              margin: EdgeInsets.only(top:20),
              padding: EdgeInsets.symmetric(horizontal:15),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 2),
                    child: Text(
                      "Name",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black87, fontSize: 13,fontFamily: 'Cairo'),
                    maxLength: 40,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      hintText: "Name of the Event",
                      hintStyle:
                          TextStyle(color: Colors.black45, fontSize: 12,fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
            ),
             Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 2),
                    child: Text(
                      "type",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  TextField(
                    controller: _typeController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black87, fontSize: 13,fontFamily: 'Cairo'),
                    maxLength: 20,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      hintText: "type ",
                      hintStyle:
                          TextStyle(color: Colors.black45, fontSize: 12,fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 2),
                    child: Text(
                      "Price (SAR)",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black87, fontSize: 13,fontFamily: 'Cairo'),
                    maxLines: 1,
                    maxLength: 10,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      hintText: "Price...",
                      hintStyle:
                          TextStyle(color: Colors.black45, fontSize: 12,fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 2),
                    child: Text(
                      "Location",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  TextField(
                    controller: _latController,
                    style: TextStyle(color: Colors.black87, fontSize: 13,fontFamily: 'Cairo'),
                    maxLines: 1,
                    maxLength: 10,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      hintText: "lat...",
                      hintStyle:
                          TextStyle(color: Colors.black45, fontSize: 12,fontFamily: 'Cairo'),
                    ),
                  ),

                   TextField(
                    controller: _longController,
                    style: TextStyle(color: Colors.black87, fontSize: 13,fontFamily: 'Cairo'),
                    maxLines: 1,
                    maxLength: 10,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      hintText: "long...",
                      hintStyle:
                          TextStyle(color: Colors.black45, fontSize: 12,fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              alignment: Alignment.topLeft,
              child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 2),
                      child: Text(
                        "Avilible Time",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Cairo'),
                      ),
                    ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                      "Date",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'Cairo'),
                ),
                SizedBox(width: 10,),
                Container(
                        width: 100,
                        padding: EdgeInsets.only(right: 15, left: 15),
                        height: 30,
                        color: Color(0xfff9f9f9),
                        child: ButtonTheme(
                                minWidth: 60,
                                height: 25,
                                child: RaisedButton(
                                  onPressed: () {
                                    showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2022),lastDate: DateTime(2025)).then((date) {
                                      from = [];
                                      setState(() {
                                      from.add(date.day.toString());
                                      from.add(date.month.toString());
                                      from.add(date.year.toString());
                                      });
                                      showTimePicker(context: context, initialTime: TimeOfDay(hour: 12, minute: 50)).then((value){
                                        time = [];
                                        time.add(value.hour.toString());
                                        time.add(value.minute.toString());
                                        setState(() {
                                          
                                        });
                                      });
                                    });
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text(
                                    "Pick",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              
                           
                      ),
               
                
                
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                      "Date",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'Cairo'),
                ),
                SizedBox(width: 10,),
               from.length > 1 ? Text(
                      "${from[0]}-${from[1]}-${from[2]}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'Cairo'),):Container(),
                SizedBox(width: 10,),

                Text(
                      "Time",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'Cairo'),
                ),
                SizedBox(width: 10,),
               time.length > 1 ? Text(
                      "${time[0]}:${time[1]}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'Cairo'),):Container(),
                SizedBox(width: 10,),

                
                
                
              ],
            ),
            
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 15, bottom: 40),
              alignment: Alignment.center,
              child: ButtonTheme(
                minWidth: 100,
                height: 50,
                child: RaisedButton(
                  padding:
                      EdgeInsets.only(top: 2, bottom: 2, right: 40, left: 40),
                  onPressed: ()async{
                    if( image != null &&
                        from.length != 0 &&
                        time.length != 0 &&
                        _nameController.text.trim().toString() != "" &&
                        _typeController.text.trim().toString() != "" &&
                        _latController.text.trim().toString() != "" &&
                        _longController.text.trim().toString() != "" &&
                        _priceController.text.trim().toString() != "" 
                    ){
                      EasyLoading.show(status: "wait a moment...");
                      await FirebaseStorage.instance.ref("images").child("images").child(Random().nextInt(1000000000).toString()).putFile(image).then((task) async{
                        await FirebaseFirestore.instance.collection("Events").add({
                          'image': task.ref.fullPath,
                          'from' : from,
                          'time' : time,
                          'name' : _nameController.text.trim().toString(),
                          'type' : _typeController.text.trim().toString(),
                          'price' : _priceController.text.trim().toString(),
                          "location" :[_latController.text.trim().toString(),_longController.text.trim().toString()],
                          "state" : true,
                          'id' : FirebaseAuth.instance.currentUser.uid
                        });
                      }).then((value){
                         EasyLoading.showSuccess("Success",duration: Duration(milliseconds: 1200 ));
                         Navigator.pop(context);
                      });
                    }else{
                      EasyLoading.showError("Make Sure all Data is filled",duration: Duration(milliseconds: 1200 ));
                    }
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Confirm",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 14 , fontFamily: 'Cairo'),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

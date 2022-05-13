import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class Requests extends StatelessWidget{
  final String docid;
  Requests(this.docid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tickets",style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: (){
            Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Events").doc(docid).collection("Requests").snapshots(),
      builder:(context,snapshots){
        if (snapshots.hasError)
          return Center(child: Text("Error"));
        switch (snapshots.connectionState) {
          case ConnectionState.waiting: return Center(
            child: Center(child: CircularProgressIndicator())
          );
          default:
      return ListView(shrinkWrap: true, children: snapshots.data.docs.map((doc)=> post(context,doc["name"] ,doc["phone"],doc["email"], doc["state"],doc.id)).toList());
      }})
      ),
    );
  }
  Widget post (context ,name ,phone,email , state , docId){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 1
          )
        ]
      ),
      height: 95,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/man.png"),fit: BoxFit.cover,)
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                    width: MediaQuery.of(context).size.width*0.85 - 90 -40 -40,
                    child: Text("$name" ,style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600) , overflow: TextOverflow.ellipsis,)),
                    // Container(
                    // width: MediaQuery.of(context).size.width*0.85 - 90 -40 -40,
                    // child: Text("$price" ,style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600) , overflow: TextOverflow.ellipsis,)),
                    SizedBox(height: 10,),
                    
                     Container(
                    width: MediaQuery.of(context).size.width*0.85 - 90 -40,
                    child: Text("payed Successfully the ticket" ,style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w600 , color: Colors.green) , overflow: TextOverflow.ellipsis,)),
                  ],
                )
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width*.15,
              child: Column(
                children: [
                  InkWell(
                              onTap: ()async{
                                await launch("mailto:$email?subject=Hello $name&body=");
                              },
                              child: Container(
                                child: Icon(Icons.email ,color: Theme.of(context).primaryColor) ,
                              ),
                            ),
                            SizedBox(height: 15,),
                            InkWell(
                              onTap: ()async{
                                await launch("tel://$phone");
                              },
                              child: Container(
                                child: Icon(Icons.phone ,color: Theme.of(context).primaryColor) ,
                              ),
                            ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
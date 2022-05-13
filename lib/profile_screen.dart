import 'package:eventfinder/controllers/local_db.dart';
import 'package:eventfinder/controllers/profile_controller.dart';
import 'package:eventfinder/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticketview/ticketview.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user;

  @override
  void initState() {
    super.initState();
    user = LocalDB.get("user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF190F4B),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset("images/photo_2022-04-30_11-16-14.jpg"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .2),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png"),
                      radius: 50,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .1),
                    Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * .1),
                        Text(
                          "User Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * .1),
                        Text(
                          user["name"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * .1),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * .1),
                        Text(
                          user["email"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .1),
                      child: Row(
                        children: [
                          Text(
                            "My credit card",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * .05,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "See all",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * .04),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .1),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/credit-card.png",
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .02),
                          Image.asset(
                            "images/credit-card.png",
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .02),
                          Image.asset(
                            "images/credit-card.png",
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .1),
                      child: Row(
                        children: [
                          Text(
                            "My tickets",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * .05,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "See all",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * .04),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .05),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.tickets.map((e) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * .02),
                              child: ticketWidget(context, e),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    FlatButton(
                      onPressed: () {
                        LocalDB.remove("user");
                        Get.offAll(() => LoginScreen());
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * .04),
                      ),
                      color: Colors.deepPurple[800],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Center ticketWidget(BuildContext context, TicketsModel ticketsModel) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.8,
        child: TicketView(
          backgroundPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          backgroundColor: Color(0xFF8F1299),
          contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
          triangleAxis: Axis.vertical,
          borderRadius: 6,
          drawDivider: true,
          trianglePos: .5,
          drawTriangle: true,
          dividerColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ticketsModel.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  "Date : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(ticketsModel.date))}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  "Time : ${ticketsModel.time}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  " Total ${ticketsModel.price}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

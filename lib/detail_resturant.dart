import 'package:eventfinder/controllers/detail_screen_controllers.dart';
import 'package:eventfinder/model/restaurant_model.dart';
import 'package:eventfinder/pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ticketview/ticketview.dart';

class DetailResturant extends StatefulWidget {
  RestaurantModel restaurantModel;

  DetailResturant({@required this.restaurantModel});

  @override
  State<DetailResturant> createState() => _DetailResturantState();
}

class _DetailResturantState extends State<DetailResturant> {
  DateTime selectedDay = DateTime.now();
  String min = "0", hours = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF190F4B),
      body: GetBuilder<DetailScreenController>(
          init: DetailScreenController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        widget.restaurantModel.name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.restaurantModel.detail,
                          width: MediaQuery.of(context).size.width * 8,
                          height: MediaQuery.of(context).size.height * .4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Text(
                        widget.restaurantModel.desc,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Text(
                        'Choose a date',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        currentDay: selectedDay,
                        headerStyle: HeaderStyle(
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.black),
                          formatButtonShowsNext: false,
                          titleTextStyle: TextStyle(color: Colors.white),
                        ),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          withinRangeTextStyle: TextStyle(color: Colors.white),
                          defaultTextStyle: TextStyle(color: Colors.white),
                          weekendTextStyle: TextStyle(color: Colors.white),
                        ),
                        onDaySelected: (date, events) {
                          setState(() {
                            selectedDay = date;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              final TimeOfDay result = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (BuildContext context, Widget child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: false),
                                    child: child,
                                  );
                                },
                              );
                              setState(() {
                                hours = result.hour.toString();
                                min = result.minute.toString();
                              });
                              print(result.hour);
                              print(result.minute);
                            },
                            child: Container(
                              child: Text(
                                "Choose time",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$hours : $min",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Center(
                        child: FlatButton(
                          onPressed: () => Get.to(
                            (() => Pay(
                                  min: min,
                                  hour: hours,
                                  dateTime: selectedDay,
                                  idEvent: widget.restaurantModel.id,
                                  nameEvent: widget.restaurantModel.name,
                                )),
                          ),
                          child: Text(
                            'Pay',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Center ticketWidget(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: TicketView(
          backgroundPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          backgroundColor: Color(0xFF8F1299),
          contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
          // drawArc: true,
          triangleAxis: Axis.vertical,
          borderRadius: 6,
          drawDivider: true,
          trianglePos: .5,
          drawTriangle: true,
          dividerColor: CupertinoColors.white,
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
                      Text(
                        widget.restaurantModel.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Price: 155 \$",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Description : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Date ${DateFormat('yyyy-MM-dd').format(selectedDay)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Time $hours:$min",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
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

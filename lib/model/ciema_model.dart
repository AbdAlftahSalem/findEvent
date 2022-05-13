import 'package:flutter/cupertino.dart';

class CiemaModel {
  String image;
  String price;
  String name;

  // List<String> location;
  List<dynamic> from;
  List<dynamic> time;
  String id;
  String desc;
  String type;

  CiemaModel(
      {@required this.image,
      @required this.price,
      @required this.name,
      // @required this.location,
      @required this.from,
      @required this.time,
      @required this.id,
      @required this.desc,
      @required this.type});

  CiemaModel.fromJson(Map<String, dynamic> json) {
    image = json['image'].toString();
    price = json['price'].toString();
    name = json['name'].toString();
    // location = json['location'].cast<String>();
    from = json['from'].cast<String>();
    time = json['time'].cast<String>();
    id = json['id'].toString();
    desc = json['desc'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['price'] = this.price;
    data['name'] = this.name;
    // data['location'] = this.location;
    data['from'] = this.from;
    data['time'] = this.time;
    data['id'] = this.id;
    data['desc'] = this.desc;
    data['type'] = this.type;
    return data;
  }
}

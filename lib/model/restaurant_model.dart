import 'package:flutter/cupertino.dart';

class RestaurantModel {
  String address, desc, id, name, type, workHours, image, detail;

  RestaurantModel({
    @required this.address,
    @required this.desc,
    @required this.detail,
    @required this.id,
    @required this.name,
    @required this.type,
    @required this.workHours,
    @required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': this.address,
      'desc': this.desc,
      'detail': this.detail,
      'id': this.id,
      'name': this.name,
      'type': this.type,
      'workHours': this.workHours,
      'image': this.image,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      address: map['address'] as String,
      desc: map['desc'] as String,
      detail: map['detail'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      workHours: map['workHours'] as String,
      image: map['image'] as String,
    );
  }
}

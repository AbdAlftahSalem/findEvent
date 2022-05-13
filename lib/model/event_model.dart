import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

class EventModel {
  String image, name, desc, id, type;
  List<dynamic> from;
  List<dynamic> time;

  EventModel(
      {@required this.image,
      @required this.name,
      @required this.desc,
      @required this.id,
      @required this.type,
      @required this.from,
      @required this.time});

  Map<String, dynamic> toMap() {
    return {
      'image': this.image,
      'name': this.name,
      'desc': this.desc,
      'id': this.id,
      'type': this.type,
      'from': this.from,
      'time': this.time,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      image: map['image'] as String,
      name: map['name'] as String,
      desc: map['desc'] as String,
      id: map['id'] as String,
      type: map['type'] as String,
      from: map['from'] as List<dynamic>,
      time: map['time'] as List<dynamic>,
    );
  }
}

import 'package:flutter/material.dart';

class ADSModel {
  String id, image;

  ADSModel({
    @required this.id,
    @required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'image': this.image,
    };
  }

  factory ADSModel.fromMap(Map<String, dynamic> map) {
    return ADSModel(
      id: map['id'] as String,
      image: map['image'] as String,
    );
  }
}

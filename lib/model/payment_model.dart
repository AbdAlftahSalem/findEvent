import 'package:flutter/cupertino.dart';

class PaymentModel {
  String cardNumber, expireDate, cvv, userId, phone, date, email, name , id;

  PaymentModel({
    @required this.cardNumber,
    @required this.expireDate,
    @required this.cvv,
    @required this.userId,
    @required this.phone,
    @required this.date,
    @required this.email,
    @required this.name,
    @required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': this.cardNumber,
      'expireDate': this.expireDate,
      'cvv': this.cvv,
      'userId': this.userId,
      'phone': this.phone,
      'date': this.date,
      'email': this.email,
      'name': this.name,
      'id': this.id,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      cardNumber: map['cardNumber'] as String,
      expireDate: map['expireDate'] as String,
      cvv: map['cvv'] as String,
      userId: map['userId'] as String,
      phone: map['phone'] as String,
      date: map['date'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }
}

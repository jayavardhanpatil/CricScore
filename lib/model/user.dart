
import 'package:flutter/cupertino.dart';

class User{

  final String uid;
  final String name;
  final String city;
  final int phoneNumber;
  final String dob;
  final String email;

  User({this.uid, this.name = null, this.city = null, this.phoneNumber = null, this.dob = null, this.email});


  Map<String,dynamic> get map {
    return {
      "name": name,
      "city":city,
      "phoneNumber": phoneNumber,
      "dateOfBirth": dob,
      "email": email
    };
  }

  String getEmailId(){
    return this.email;
  }

  String getName(){
    return this.name;
  }

  int getPhoneNumber(){
    return this.phoneNumber;
  }

  String getDateOfBirth(){
    return this.dob;
  }

  String getCity(){
    return this.city;
  }


}
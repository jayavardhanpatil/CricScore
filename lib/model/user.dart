
import 'package:flutter/cupertino.dart';

class User{

  final String uid;
  final String Name;
  final String location;
  final int phoneNumber;
  final DateTime dob;
  final String email;

  User({this.uid, this.Name = null, this.location = null, this.phoneNumber = null, this.dob = null, this.email});


  Map<String,dynamic> get map {
    return {
      "Name": Name,
      "Location":location,
      "PhoneNumber": phoneNumber,
      "DateOfBirth": dob,
      "email": email
    };
  }

  String getEmailId(){
    return this.email;
  }

  String getName(){
    return this.Name;
  }

  int getPhoneNumber(){
    return this.phoneNumber;
  }



}
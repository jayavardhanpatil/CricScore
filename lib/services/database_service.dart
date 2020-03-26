
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/auth_service.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  static List<dynamic> cities = new List();

  final DatabaseReference _fireBaseRTreference = FirebaseDatabase.instance.reference();
  
  //Write a data : key value
  User addUser(User user) {
    _fireBaseRTreference.child("/users/" + user.uid).set(user.map)
        .then((value) {
      return user;
    }).catchError((e) {
      print("Error in writing to DB : "+e.toString());
    });
  }

  void addCities() {
    addCityList();
    _fireBaseRTreference.child("/countries/all/").set({
      "cities" : cities
    }).then((value) {
      print("Cities Added");
    }).catchError((e) {
      print("Error in writing to DB : "+e.toString());
    });
  }


  List<dynamic> getCity(String pattern){
    if(cities.length == 0) {
      print("Entered City : "+cities.toString());
      _fireBaseRTreference.child("countries/all").once().
      then((value) =>
      {
        print(value.value['cities'].toString()),
        cities = value.value['cities'].toList(),
        print(cities.where((element) => element.startsWith(pattern)).toList()),

      }).
      catchError((e) {
        print("Error in fetching city" + e.toString());
      });
    }
    return cities.where((element) => element.startsWith(pattern)).toList();
  }

  void addCityList(){
    cities.add("Pomona");
    cities.add("New York");
    cities.add("Chicago");
    cities.add("Los Angeles");
    cities.add("Santa Clara");
    cities.add("San Francisco");
    cities.add("Fresno");
    cities.add("San Diego");
    cities.add("Bangalore");
    cities.add("Delhi");
    cities.add("Pune");
    cities.add("Mumbai");
    cities.add("Belgaum");
    cities.add("Bhoj");
    cities.add("Chennai");
    cities.add("Hyderabad");

  }

  List getusers(){
    _fireBaseRTreference.child("/users").once().then((value) {
      print(value);
    }).catchError((e){
      print("Error in fetching the user record : " + e.toString());
    });
    return null;
  }

  Future<User> reLoadUserRecord(uid) async{
      getUserRecord(uid);
  }

  Future<User> getUserRecord(uid) async{
    await _fireBaseRTreference.child("/users/" + uid).once().then((value) {
      print("Getting Data from DB");
      User user = new User(uid: uid,
          name: value.value['name'],
          city: value.value['city'],
          phoneNumber: value.value['phoneNumber'],
          email: value.value['email'],
          dob: value.value['dateOfBirth']
      );
      if (AuthService.user.uid == uid){
        AuthService.user = user;
      }
      return user;
    }).catchError((e) {
      print("Error in fetching the user record : " + e.toString());
    });
  }
}
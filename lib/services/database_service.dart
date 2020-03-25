
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/model/user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});


  //final CollectionReference userCollection = Firestore.instance.collection('users');
  final DatabaseReference _reference = FirebaseDatabase.instance.reference();


  //Write a data : key value
  void addUser(User user) {
    _reference.child("/users/" + uid).set(user.map)
        .then((value) {
      print("User Record Added");
    }).catchError((e) {
      print("Error in writing to DB : "+e.toString());
    });
  }

  List getuser(){
    _reference.child("/users").once().then((value) {
      print(value);
    }).catchError((e){
      print("Error in fetching the user record : " + e.toString());
    });
    return null;
  }
}
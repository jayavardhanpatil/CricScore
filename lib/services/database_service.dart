
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/model/user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});


  //final CollectionReference userCollection = Firestore.instance.collection('users');
  final DatabaseReference reference = FirebaseDatabase.instance.reference();


  //Write a data : key value
  void updateUser(User user) {
    reference.child("/users/" + uid).set(user.map)
        .then((value) {
      print("User Record Added");
    }).catchError((e) {
      print("Error in writing to DB : "+e.toString());
    });
  }
}
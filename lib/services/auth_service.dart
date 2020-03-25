import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/provider_widget.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static User user = null;

  Stream<User> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(_userFromFireBaseUser);

  Future<String> getCurrentUID() async{
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<String> getCurrentUserEmailId() async{
    return (await _firebaseAuth.currentUser()).email;
  }

  User _userFromFireBaseUser(FirebaseUser u) {
    user = u != null ? User(uid: u.uid, email: u.email) : null;
    return user;

  }

  // Email & Password Sign Up
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {

    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    print("Created User");
    // Update the username
    var userUpdateInfo = UserUpdateInfo();
    await currentUser.user.updateProfile(userUpdateInfo);
    await currentUser.user.reload();
    //FirebaseUser user = currentUser.user;
    try {
      DatabaseService(uid: currentUser.user.uid).addUser(
          _userFromFireBaseUser(currentUser.user));
    }catch(e){
      print("Error DatabaseService in db "+e.toString());
    }
    return _userFromFireBaseUser(currentUser.user);
  }

  // Email & Password Sign In
  Future signInWithEmailAndPassword(
      String email, String password) async {

    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
    return _userFromFireBaseUser(authResult.user);

  }

  // Sign Out
  void signOut() async{
    try {
      await _firebaseAuth.signOut();
    }catch (e){
      print(e.message);
      return null;
    }
  }

}

class Validator{
  static String validate(String value){
    if(value.isEmpty){
      return "Email Can't be empty";
    }
    return null;
  }
}
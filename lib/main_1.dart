/*
import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/view/firstView.dart';
import 'package:flutter_app/view/signUp.dart';

import 'home_widget.dart';

void main() => runApp(
  MyApp(),
);

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CricScore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp':(BuildContext context) => SignUpView(authFormType: AuthFormType.signUp,),
          '/signIn':(BuildContext context) => SignUpView(authFormType: AuthFormType.signIn,),
          '/home' : (BuildContext context) => HomeController(),
        }
      ),
    );

  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChange,
      builder: (context, AsyncSnapshot<String> snapShot){
        if(snapShot.connectionState == ConnectionState.active){
          final bool signedIn = snapShot.hasData;
          return signedIn ? Home() : FirstView();
        }
        return CircularProgressIndicator();
      }
    );
  }
}

class Provider extends InheritedWidget{
  final AuthService auth;
  Provider({Key key, Widget child, this.auth,}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) => (context.getElementForInheritedWidgetOfExactType() as Provider);


}



*/

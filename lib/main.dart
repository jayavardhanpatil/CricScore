import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/views/home_view.dart';
import 'package:flutter_app/views/profile.dart';
import 'package:flutter_app/views/signUpView.dart';
import 'package:flutter_app/widgets/loader.dart';
import 'model/user.dart';
import 'widgets/provider_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Travel Budget App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/home': (BuildContext context) => HomeController(),
          '/profile': (BuildContext context) => EditProfile(),
        },
      ),
    );
  }
}


class HomeController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
//          if(signedIn){
//           if(snapshot.data.name == null){
//              print(snapshot.data.toString());
//              return EditProfile();
//            }else {
//             return HomeView();
//           }
//          }else{
//            return SignUpView(authFormType: AuthFormType.signUp);
//          }
          return signedIn ? HomeView() : SignUpView(authFormType: AuthFormType.signUp);
        }
        return Loading();
      },
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/views/profile.dart';
import 'package:flutter_app/views/signUpView.dart';
import 'package:flutter_app/widgets/provider_widget.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeView createState() => _HomeView();

}

class _HomeView extends State<HomeView>{

  int _currentIndex = 0;
  bool loading = false;
  final tabs = [
    Center(child: Text("sign out")),
    Center(child: Text('Profile')),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("${HomeController()}"),
              accountEmail: new Text("Test@gmail.com"),
              currentAccountPicture : new CircleAvatar(
                backgroundImage: new ExactAssetImage('lib/assets/images/default_profile_avatar.png'),
              )

            ),
            new ListTile(
              title: new Text("Sign Out"),
              onTap: () async{
                try {
                  AuthService auth = Provider.of(context).auth;
                  await auth.signOut();
                  print("Signed Out!");
                  Navigator.of(context).pop();
                  SignUpView(authFormType: AuthFormType.signIn);
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),

      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('search'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        }
      ),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/views/profile.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeView createState() => _HomeView();

}

class _HomeView extends State<HomeView>{

  int _currentIndex = 0;

  final tabs = [
    Center(child: Text('Home')),
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
              accountName: null,
              accountEmail: null,
              currentAccountPicture : new CircleAvatar(
                backgroundImage: new ExactAssetImage('/Users/jayavardhanpatil/Studies/CS4990/MobileApp/CricScore/lib/assets/images/default_profile_avatar.png'),
              )

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

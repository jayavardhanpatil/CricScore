import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeView createState() => _HomeView();

}

class _HomeView extends State<HomeView>{

  int _currentIndex = 0;

  final tabs = [
    Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Profile'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('home'),
            backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('search'),
              backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              backgroundColor: Colors.green
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

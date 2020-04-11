import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/appStaticBarTitles.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/view/firstView.dart';
import 'package:flutter_app/views/MatchSummaryView.dart';
import 'package:flutter_app/views/profile.dart';
import 'package:flutter_app/views/signUpView.dart';
import 'package:flutter_app/views/selectTeam.dart';
import 'package:flutter_app/widgets/gradient.dart';
import 'package:flutter_app/widgets/loader.dart';
import 'package:flutter_app/widgets/provider_widget.dart';



class HomeView extends StatefulWidget {

  @override
  _HomeView createState() => _HomeView();

}

final grayColor = const Color(0xFF939393);

class _HomeView extends State<HomeView> with TickerProviderStateMixin{

  final List<MyTabs> _tabs = [new MyTabs(title: "Home",color: Colors.teal[200]),
    new MyTabs(title: "Search",color: Colors.orange[200]),
    new MyTabs(title: AppBarsTitles.EDIT_PROFILE_APP_BAR_TITLE,color: Colors.red[200])
  ];

  MyTabs _myHandler ;
  TabController _controller ;
  final _textEditingController = new TextEditingController();
  bool loading = true;

  void initState() {
    super.initState();
    reloadInitialData();
    _textEditingController.text = "${AuthService.user.getName()}";
    _controller = new TabController(length: 2, vsync: this);
    _myHandler = _tabs[0];
    _controller.addListener(_handleSelected);
  }
  void _handleSelected() {
    setState(() {
      _myHandler= _tabs[_currentIndex];
    });
  }

  int _currentIndex = 0;

  reloadInitialData() async{
    await DatabaseService().reLoadUserRecord(AuthService.user.uid).then((value) => setState((){
      loading = false;
    }));

    return await DatabaseService().reloadCitiesList();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      MatchSummaryList(),
//      Center(child: FlatButton(
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context) => MatchSummaryList()));
//        },
//        child: Text("Press"),
//      )),
      Center(child: AutoSizeText(
        "Profile",
        maxLines: 4,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Lemonada"
        ),
      ),),
      //EditProfile()
    ];

    return (loading) ? Loading() : Scaffold(
      appBar: new AppBar(
        title: AutoSizeText(
          _myHandler.title,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 18.0,
              fontFamily: "Lemonada"
          ),
        ),
        flexibleSpace: getAppBarGradient(),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[

            Container(
              color: Color(0xFF6190E8),
              child: new UserAccountsDrawerHeader(
                accountName:AutoSizeText(
                  (AuthService.user.getName() == null) ? null : "${AuthService.user.getName()}",
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: "Lemonada"
                  ),
                ),

                accountEmail: AutoSizeText(
                  AuthService.user.getEmailId(),
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: "Lemonada"
                  ),
                ),
                currentAccountPicture : new CircleAvatar(
                  backgroundImage: new ExactAssetImage('lib/assets/images/default_profile_avatar.png'),
                  backgroundColor: Colors.white,
                ),
              ),
            ),

            new ListTile(
              title: AutoSizeText(
                "Profile",
                maxLines: 4,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Lemonada"
                ),
              ),
              onTap: () async{
                try {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile(profileBodyType: ProfileBodyEnum.view)));
                } catch (e) {
                  print(e);
                }
              },
            ),

            new ListTile(
              title: AutoSizeText(
                "Start Match",
                maxLines: 4,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Lemonada"
                ),
              ),
              onTap: () async{
                try {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SelectTeam()));
                } catch (e) {
                  print(e);
                }
              },
            ),

            new ListTile(
              title: AutoSizeText(
                "Sign Out",
                maxLines: 4,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Lemonada"
                ),
              ),

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
      body : tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,

          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: AutoSizeText(
                "Home",
                maxLines: 4,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Lemonada"
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: AutoSizeText(
                "Profile",
                maxLines: 4,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Lemonada"
                ),
              ),
            ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.person),
//              title: Text('Profile'),
//          ),
          ],
          onTap: (index){
            setState(() {
              _currentIndex = index; _myHandler= _tabs[_currentIndex];
            });
          }
      ),

    );
  }
}

class MyTabs {
  final String title;
  final Color color;
  MyTabs({this.title,this.color});
}

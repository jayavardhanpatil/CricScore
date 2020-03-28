
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/startMatch.dart';

class PlayersList extends StatefulWidget {

  @override
  _PlayersList createState() =>
      _PlayersList();
  }

  class _PlayersList extends State<PlayersList> {
    int _count = 0;
    var _listofUsers = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${StartMatch.currentTeamName} selected(" + "${_count}" + ")"),
      ),
      body: Center(
        child: Container(
          child: userListView(context),
        ),
      )
    );
  }


  Widget userListView(BuildContext context){
    return FutureBuilder(
      future: DatabaseService().getUsersList(),
      builder: (context,  snapshot){
        if(snapshot.hasData) {
          _listofUsers = snapshot.data;
        }
        User user;
        if(_listofUsers.length > 0){
          return ListView.builder(
              itemCount: _listofUsers.length,
              itemBuilder: (context, index){
                user = _listofUsers[index];
                return ListTile(
                  title: Text(user.getEmailId()),

                );
              });
        }else{
          return Text("No data");
        }
      });
  }

}
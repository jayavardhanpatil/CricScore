
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/startMatch.dart';

class PlayersList extends StatefulWidget {

  Match match;

  PlayersList({Key key, @required this.match}) : super(key: key);

  @override
  _PlayersList createState() =>
      _PlayersList(match: this.match);
  }

  class _PlayersList extends State<PlayersList> {
    static List<User> _listofUsers;

    Match match;
    bool loadedData = false;

    _PlayersList({this.match});


    //List<User> _listofUsers = new List();
    List<User> selectedList;
    List<bool> _selected;
    Future users;

    @override
  void initState() {
      super.initState();
      selectedList = List();
        if(_listofUsers == null) {
          _listofUsers = new List();
          print("Load Data : block");
          users = loadUsers();
        }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${StartMatch.currentTeamName} selected(" + "${selectedList.length}" + ")"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context, selectedList);
              },
              child: Icon(Icons.check),
            ),
          )
        ],
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
      future: users,
      // ignore: missing_return
      builder: (context,  snapshot){

        if(_listofUsers.length == 0){
          _listofUsers = snapshot.data;
        }else {
          if (_listofUsers == null) {
            return Text("Loading....");
          }else if(_listofUsers.length > 0) {
            //Get other Team players
            //_listofUsers = snapshot.data;
            List<User> otherTeamPlayers = new List();
            if (match.teams.length > 1) {
              match.teams.forEach((key, value) {
                if (key != StartMatch.currentTeamName) {
                  otherTeamPlayers = value.getTeamPlayers();
                  print("Other Team name : " + key);
                  print("Other Team Players : " +
                      value.getTeamPlayers().toString());
                }
              });
            }

            //_listofUsers = snapshot.data;

            if (otherTeamPlayers != null) {
              for (int i = 0; i < otherTeamPlayers.length; i++) {
                if (_listofUsers.contains(otherTeamPlayers[i])) {
                  print("User Matched : " + otherTeamPlayers[i].getName());
                }
                _listofUsers.remove(otherTeamPlayers[i]);
                print("Removed " + otherTeamPlayers[i].getName());
              }
            }
          }

          if (!loadedData) {
            _selected = List.generate(_listofUsers.length, (index) => false);
          }

          if (_listofUsers.length > 0) {
            return ListView.builder(
                itemCount: _listofUsers.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),

                    color: _selected[index] ? Colors.black12 : null,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: CircleAvatar(
                        backgroundImage: ExactAssetImage(
                            "lib/assets/images/default_profile_avatar.png"),
                        backgroundColor: Colors.blue,
                      ),
                      title: Text(
                        _listofUsers[index].name,
                      ),
                      subtitle: Text(
                        _listofUsers[index].phoneNumber.toString(),
                      ),
                      onTap: () {
                        setState(() {
                          loadedData = true;
                          if (!_selected[index]) {
                            selectedList.add(_listofUsers[index]);
                          } else {
                            selectedList.remove(_listofUsers[index]);
                          }
                          _selected[index] = !_selected[index];
                          print(selectedList.toString());
                        });
                      },
                    ),
                  );
                }
            );
          } else {
            return Text("No data");
          }
        }
      });
  }

  Future loadUsers() async{
      return await DatabaseService().getUsersList().then((value) =>
          _listofUsers = value);
  }

}
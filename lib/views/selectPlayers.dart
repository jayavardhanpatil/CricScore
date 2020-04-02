
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/model/team.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/gradient.dart';

class PlayersList extends StatefulWidget {

  MatchGame match;
  Team team;

  PlayersList({Key key, @required this.match, this.team}) : super(key: key);

  @override
  _PlayersList createState() =>
      _PlayersList(match: this.match, team: this.team);
  }

  class _PlayersList extends State<PlayersList> {

    MatchGame match;
    Team team;
    bool loadedData = false;

    _PlayersList({this.match, this.team});


    Map<String, User> _listofUsers = new Map();
    Map<String, Player> selectedList = new Map();
    Future users;
    List<User> _listOfPlayers = new List();

    @override
  void initState() {
      super.initState();
      if(match.teams != null && match.teams[team.getTeamName()].players != null) {
        match.teams[team.getTeamName()].players.forEach((key, value) {
          selectedList.update(key, (value) => new Player(
              playerUID: key, playerName: value.playerName),
              ifAbsent: () =>
              new Player(playerUID: key,
                  playerName: value.playerName));
        });
//
//        match.teams[team.getTeamName()].players.forEach((element) {
//          selectedList.update(element.playerUID, (value) =>
//          new Player(
//              playerUID: element.playerUID, playerName: element.playerName),
//              ifAbsent: () =>
//              new Player(playerUID: element.playerUID,
//                  playerName: element.playerName));
//        });
      }
      print("Load Data : block");
      users = loadUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${team.getTeamName()} selected(" + "${selectedList.length}" + ")"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                match.teams[team.getTeamName()].players.addAll(selectedList);

                Navigator.pop(context, selectedList);
              },
              child: Icon(Icons.check),
            ),
          )
        ],
        flexibleSpace: getAppBarGradient(),
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
      builder: (context,  snapshot){
        if(snapshot.data == null){
          return Text("Loading....");
        } else if (snapshot.hasData) {

          //Get other Team players
          //_listofUsers = snapshot.data;
          List<Player> otherTeamPlayers = new List();
          if(match.teams.length > 0){
//            match.teams.forEach((key, value) {
//              print(key);
//              print(value);
//            });
            match.teams.forEach((key, value) {
              if(key != team.getTeamName()){
                print("Other Team name : "+key);
                print("Other Team Players : "+value.getTeamPlayers().toString());
                otherTeamPlayers.addAll(value.getTeamPlayers().values);
              }
            });
          }

          _listofUsers = snapshot.data;

            if(otherTeamPlayers != null){
              for(int i=0;i<otherTeamPlayers.length;i++){
                if(_listofUsers.containsKey(otherTeamPlayers[i].playerUID)){
                  print("User Matched : "+otherTeamPlayers[i].playerUID);
                  _listofUsers.remove(otherTeamPlayers[i].playerUID);
                  print("Removed " + otherTeamPlayers[i].playerUID);
                }
              }
            }
          }

//        if(!loadedData) {
//          _selected = List.generate(_listofUsers.length, (index) => false);
          _listOfPlayers = _listofUsers.values.toList();
//        }

        if(_listofUsers.length > 0){
          return ListView.builder(
            itemCount: _listofUsers.values.toList().length,
            itemBuilder: (context, index){
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: selectedList.containsKey(_listOfPlayers[index].uid) ? Color(0xFF6190E8) : null,
                child: ListTile(
                    contentPadding: EdgeInsets.only(left: 20),
                    leading: CircleAvatar(
                      backgroundImage: ExactAssetImage(
                          "lib/assets/images/default_profile_avatar.png"),
                      backgroundColor: Colors.black,
                    ),
                    title: Text(
                      _listOfPlayers[index].getName(), style: selectedList.containsKey(_listOfPlayers[index].uid) ? TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold
                    ) : null,
                    ),
                    subtitle: Text(
                      _listOfPlayers[index].getPhoneNumber().toString().substring(0, 2) + "****" + _listOfPlayers[index].getPhoneNumber().toString().substring(_listOfPlayers[index].getPhoneNumber().toString().length - 3), style: selectedList.containsKey(_listOfPlayers[index].uid) ? TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold
                ) : null,
                    ),
                      onTap: (){
                        setState(() {
                          if(!selectedList.containsKey(_listOfPlayers[index].uid)){
                            selectedList.update(_listOfPlayers[index].uid, (value) => new Player(playerUID: _listOfPlayers[index].uid, playerName: _listOfPlayers[index].getName()), ifAbsent: () => new Player(playerUID: _listOfPlayers[index].uid, playerName: _listOfPlayers[index].getName()));
                          }else{
                            selectedList.remove(_listOfPlayers[index].uid);
                          }
                          //_selected[index] = !_selected[index];
                          print(selectedList.toString());
                        });
                    },
                ),
              );
            }
          );
        }else{
          return Text("No data");
        }
      });
  }

  Future loadUsers() async{
      return await DatabaseService().getUsersList();
  }

}
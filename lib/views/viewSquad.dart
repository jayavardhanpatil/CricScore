import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/team.dart';

class ViewSqual extends StatefulWidget{

  Team team;

  ViewSqual({Key key, @required this.team}) : super (key : key);

  _ViewSqual createState() => _ViewSqual(team: team);

}

class _ViewSqual extends State<ViewSqual> {
  Team team;

  _ViewSqual({this.team});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(team.getTeamName()),
      ),
      body: ListView.builder(
          itemCount: team.players.length,
          itemBuilder: (context, index){

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 20),
                leading: CircleAvatar(
                  backgroundImage: ExactAssetImage(
                      "lib/assets/images/default_profile_avatar.png"),
                  backgroundColor: Colors.blue,
                ),
                title: Text(
                  team.players[index].name,
                ),
                subtitle: Text(
                  team.players[index].phoneNumber.toString(),
                ),
              ),
            );
          }
      ),
    );

    throw UnimplementedError();
  }
}
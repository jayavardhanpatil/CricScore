import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/team.dart';
import 'package:flutter_app/widgets/gradient.dart';

class ViewSquad extends StatefulWidget{

  Team team;

  ViewSquad({Key key, @required this.team}) : super (key : key);

  _ViewSquad createState() => _ViewSquad(team: team);

}

class _ViewSquad extends State<ViewSquad> {
  Team team;

  _ViewSquad({this.team});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(team.getTeamName() + " Squad (" + team.players.length.toString() + ")"),
        flexibleSpace: getAppBarGradient(),
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
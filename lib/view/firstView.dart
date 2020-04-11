import 'package:flutter/material.dart';
import 'package:CricScore/views/selectPlayers.dart';


class FirstView extends StatelessWidget{

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          child: Container(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Demo"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlayersList()));
                  }
                )
              ],
            ),
          ),
          ),
      );
    }
}

import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/currentPlayer.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/scoreUpdateView.dart';
import 'package:flutter_app/widgets/ToastWidget.dart';
import 'package:flutter_app/widgets/gradient.dart';
import 'package:flutter_app/widgets/loader.dart';

class StartInnings extends StatefulWidget{

  MatchGame match;

  StartInnings({Key key, @required this.match}) : super (key : key);

  _StartInnings createState() => _StartInnings(match: match);

}


class _StartInnings extends State<StartInnings> {
  MatchGame match;

  _StartInnings({this.match});

  List<Player> battingPlayers = List();
  List<Player> bowlingPlayers = List();
  Map<String, Player> batmans = new Map();
  Map<String, Player> bowlers = new Map();


  @override
  void initState() {
    buildDropdownMenuItemsForBatting();
    buildDropdownMenuItemsForBowling();
    if(battingPlayers.length > 1){

      batmans.putIfAbsent("striker", () => battingPlayers[0]);
      batmans.putIfAbsent("nonstriker", () => battingPlayers[1]);
    }
    if(bowlingPlayers.length > 0){
      bowlers.putIfAbsent("open_bowler", () => bowlingPlayers[0]);
    }

    super.initState();
  }

  List<DropdownMenuItem<Player>> buildDropdownMenuItemsForBatting(){
    List<DropdownMenuItem<Player>> items = List();
    if(!match.getisFirstInningsOver()){
      match.firstInning.battingteam.players.forEach((key, value) {
        battingPlayers.add(value);
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }else{
      match.secondInning.battingteam.players.forEach((key, value) {
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }
    return items;
  }

  List<DropdownMenuItem<Player>> buildDropdownMenuItemsForBowling(){
    List<DropdownMenuItem<Player>> items = List();

    if(!match.getisFirstInningsOver()){
      match.firstInning.bowlingteam.players.forEach((key, value) {
        bowlingPlayers.add(value);
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }else{
      match.secondInning.bowlingteam.players.forEach((key, value) {
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }
    return items;
  }

  DirectSelectItem<Player> getDropDownMenuItem(Player value) {
    return DirectSelectItem<Player>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value.playerName);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Openers"),
        flexibleSpace: getAppBarGradient(),
      ),
      body: DirectSelectContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: _height * 0.06),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(left: 4),
                      child: Text("Select Opener, Striker Batsman!", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    child: DirectSelectList<Player>(
                                        values: battingPlayers,
                                        itemBuilder: (Player value) => getDropDownMenuItem(value),
                                        focusedItemDecoration: _getDslDecoration(),
                                        onItemSelectedListener: (item, index, context) {
                                          batmans.update("striker", (value) => item, ifAbsent: () => item);
                                          //Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.playerName)));
                                        }),
                                    padding: EdgeInsets.only(left: 12))),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.unfold_more,
                                color: Color(0xFF6190E8),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: _height * 0.06),

                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(left: 4),
                      child: Text("Select Non-Striker Batsman!", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    child: DirectSelectList<Player>(
                                        values: battingPlayers,
                                        itemBuilder: (Player value) => getDropDownMenuItem(value),
                                        focusedItemDecoration: _getDslDecoration(),
                                        defaultItemIndex: 0,
                                        onItemSelectedListener: (item, index, context) {
                                          batmans.update("nonstriker", (value) => item, ifAbsent: () => item);
                                          //Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.playerName)));
                                        },
                                        ),
                                    padding: EdgeInsets.only(left: 12))),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.unfold_more,
                                color: Color(0xFF6190E8),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                    SizedBox(height: _height * 0.06),

                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(left: 4),
                      child: Text("Select Opener Bowler!", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15) ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    child: DirectSelectList<Player>(
                                        values: bowlingPlayers,
                                        itemBuilder: (Player value) => getDropDownMenuItem(value),
                                        focusedItemDecoration: _getDslDecoration(),
                                        onItemSelectedListener: (item, index, context) {
                                          bowlers.update("open_bowler", (value) => item, ifAbsent: () => item);
                                          //Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.playerName)));
                                        }),
                                    padding: EdgeInsets.only(left: 12))),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.unfold_more,
                                color: Color(0xFF6190E8),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: _height * 0.1),

                    FlatButton(
                      onPressed: () {

                        if(batmans.length != 2){
                          showFailedColoredToast("Please select two Batsmans!");
                        }
                        else if(bowlers.length != 1){
                          showFailedColoredToast("Please select One Bowler!");
                        }else {
                          Map<String, Player> batsmans = new Map();
                          batmans.forEach((key, value) {
                            value.run = 0;
                            value.ballsFaced = 0;
                            value.centuries = 0;
                            value.fifties = 0;
                            value.numberOfFours = 0;
                            value.numberOfsixes = 0;
                            if(key == "striker") {
                              value.playedPosition = 1;
                              value.isOnStrike = true;
                            }else{
                              value.playedPosition = 2;
                              value.isOnStrike = false;
                            }
                            batsmans.putIfAbsent(
                                value.playerUID, () => value);
                          });

                          Map<String, Player> bowler = new Map();
                          bowlers.forEach((key, value) {
                            value.overs = 0;
                            value.extra = 0;
                            value.runsGiven = 0;
                            value.wicket = 0;
                            bowler.putIfAbsent(value.playerUID, () => value);
                          });


                          CurrentPlayIng currentInning = new CurrentPlayIng(
                              battingTeamPlayer : batsmans, bowlingTeamPlayer: bowler);
                          currentInning.run = 0;
                          currentInning.wickets = 0;
                          currentInning.extra = 0;
                          currentInning.overs = 0;
                          (match.isFirstInningsOver) ? currentInning.teamName = match.secondInning.battingteam.getTeamName() : currentInning.teamName = match.firstInning.battingteam.getTeamName();
                          match.currentPlayers = currentInning;


                          print(match.currentPlayers.toJson());

                          addCurrentPlayer(context);

                          //addMatchDetails(context);

//                              DatabaseService().addMatch(match);
//
//                          String playingType = (match.getisFirstInningsOver()) ? "second_inning" : "first_inning";
//                          DatabaseService().addInningsPlayers(match, batsmans, playingType, "batting");
//
//                          DatabaseService().addInningsPlayers(match, bowler, playingType, "bowling");


//                          FutureBuilder(
//                            future: addPlayersToTheInnings(match.firstInning.battingteam.players, match.firstInning.bowlingteam.players, "first_inning"),
//                            builder: (context, snapshot){
//                              if(snapshot.data == null){
//                                Loading();
//                              }else if(snapshot.connectionState == ConnectionState.done){
//                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Match Details Added to the server")));
//                              }
//                            },
//                          );
//
//                          FutureBuilder(
//                            future: addPlayersToTheInnings(match.secondInning.battingteam.players, match.secondInning.bowlingteam.players, "second_inning"),
//                            builder: (context, snapshot){
//                              if(snapshot.data == null){
//                                Loading();
//                              }else if(snapshot.connectionState == ConnectionState.done){
//                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Match Details Added to the server")));
//                              }
//                            },
//                          );

                          Navigator.push(context, MaterialPageRoute(builder: (context) => ScoreUpdateView(match: match,)));
                        }
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: _width * 0.8,
                        decoration: getButtonGradientColor(BoxShape.rectangle),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Start Match',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  addPlayersToTheInnings(Map<String, Player> battingplayer, Map<String, Player> bowlingPlayer, String inningType,) async{
    await DatabaseService().addInningsPlayers(match, battingplayer, inningType, "batting");
    return await DatabaseService().addInningsPlayers(match, bowlingPlayer, inningType, "bowling");
  }

  Widget addCurrentPlayer(BuildContext context){
    return FutureBuilder(
        future: DatabaseService().updateCurrentPlayer(match),
        // ignore: missing_return
        builder: (context,  snapshot){
          if(snapshot.data == null){
            Loading();
          }else if(snapshot.connectionState == ConnectionState.done){
            // ignore: missing_return
           showSuccessColoredToast("Current player Added to server");
          }
        }
    );
  }
}
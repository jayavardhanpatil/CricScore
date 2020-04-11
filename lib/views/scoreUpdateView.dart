//ScoreUpdateView

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CricScore/model/match.dart';
import 'package:CricScore/model/player.dart';
import 'package:CricScore/services/database_service.dart';
import 'package:CricScore/widgets/SelectPlayerCustom_dialog.dart';
import 'package:CricScore/widgets/ToastWidget.dart';
import 'package:CricScore/widgets/custom_dialog.dart';
import 'package:CricScore/widgets/gradient.dart';

class ScoreUpdateView extends StatefulWidget{

  MatchGame match;
  final Function(dynamic) radioButtonValue;

  ScoreUpdateView({Key key, @required this.match, this.radioButtonValue}) : super (key : key);

  _ScoreUpdateView createState() => _ScoreUpdateView(match: match);

}

class _ScoreUpdateView extends State<ScoreUpdateView> {
  MatchGame match;

  _ScoreUpdateView({this.match});

  bool isInningsOver = false;

  List<Player> _currentBatttingPlayer = new List();
  List<Player> _currentBowlingPlayer = new List();
  List<Widget> balls = new List();
  int ballCouts;
  bool isplayerReplaced = true;

  @override
  Widget build(BuildContext context) {

    AppBar appBar = AppBar();

    var _width = MediaQuery
        .of(context)
        .size
        .width;
    var _height = MediaQuery
        .of(context)
        .size
        .height - appBar.preferredSize.height;


    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          match.currentPlayers.teamName + " Batting",
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "Lemonada",
            color: Colors.white,

          ),
        ),

        //Text(match.currentPlayers.teamName + " Batting"),
        flexibleSpace: getAppBarGradient(),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: _height * 0.35,
              width: _width,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(match.currentPlayers.run.toString() + "/" +match.currentPlayers.wickets.toString(), style: TextStyle(
                    fontSize: 70 , fontFamily: "Oswaldd",
                  ),),
                  Text("overs : "+match.currentPlayers.overs.toStringAsFixed(1) ,style: TextStyle(
                    fontSize: 25, fontFamily: "Oswaldd",
                  ),),
                  SizedBox(height: _height * 0.02,),

                  AutoSizeText(
                    match.tossWonTeam + " won the toss and elected to "+match.selectedInning.toLowerCase() + " first",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                        fontFamily: "Lemonada"
                    ),
                  ),
                ],
              ),
            ),

            Container(
                height: _height * 0.12,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  backgroundImage: ExactAssetImage(
                                      "lib/assets/images/batting.png"),
                                  backgroundColor: (_currentBatttingPlayer[0].isOnStrike) ? Colors.orangeAccent : Colors.transparent,
                                  minRadius: 15,
                                  maxRadius: 15,
                                ),
                                margin: EdgeInsets.all(5),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),

                                child : AutoSizeText(
                                  _currentBatttingPlayer[0].playerName,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Lemonada",
                                    fontWeight: (_currentBatttingPlayer[0].isOnStrike) ? FontWeight.bold : null,
                                  ),
                                ),
                              ),

//                                child : Text(_currentBatttingPlayer[0].playerName, textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                    fontWeight: (_currentBatttingPlayer[0].isOnStrike) ? FontWeight.bold : null , fontStyle: FontStyle.italic, fontSize: 15,
//                                  ),),),

                            ],
                          ),

                          Container(

                            child : AutoSizeText(
                              _currentBatttingPlayer[0].run.toString() + " ("+_currentBatttingPlayer[0].ballsFaced.toString()+")",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Oswaldd",
                                fontWeight: (_currentBatttingPlayer[0].isOnStrike) ? FontWeight.bold : null,
                              ),
                            ),

//                            child: Text(_currentBatttingPlayer[0].run.toString() + " ("+_currentBatttingPlayer[0].ballsFaced.toString()+")",
//                                style: TextStyle(
//                                    fontSize: 15
//                                )),

                          ),

                        ],

                      ),
                    ),
                    VerticalDivider(thickness: 1, color: Colors.black,),
                    Expanded(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  backgroundImage: ExactAssetImage(
                                      "lib/assets/images/batting.png"),
                                  backgroundColor: (_currentBatttingPlayer[1].isOnStrike) ? Colors.orangeAccent : Colors.transparent,
                                  minRadius: 15,
                                  maxRadius: 15,
                                ),
                                margin: EdgeInsets.all(5),

                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),

                                child : AutoSizeText(
                                  _currentBatttingPlayer[1].playerName,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                    fontFamily: "Lemonada",
                                    fontWeight: (_currentBatttingPlayer[1].isOnStrike) ? FontWeight.bold : null,
                                  ),
                                ),
                              ),

//                                child : Text(_currentBatttingPlayer[1].playerName, textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                    fontWeight: (_currentBatttingPlayer[1].isOnStrike) ? FontWeight.bold : null , fontStyle: FontStyle.italic, fontSize: 15,
//                                  ),),),

                            ],
                          ),


                          Container(
                            child : AutoSizeText(
                              _currentBatttingPlayer[1].run.toString() + " ("+_currentBatttingPlayer[1].ballsFaced.toString()+")",
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Oswaldd",
                                fontWeight: (_currentBatttingPlayer[1].isOnStrike) ? FontWeight.bold : null,
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                  ],
                )
            ),

            Container(
                height: _height * 0.15,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Colors.black),
                        left: BorderSide(width: 1.0, color: Colors.black)
                    )
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[

                        Container(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            backgroundImage: ExactAssetImage(
                                "lib/assets/images/cricket_ball.png"),
                            backgroundColor: Colors.orangeAccent,
                            minRadius: 10,
                            maxRadius: 10,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),

                          child : AutoSizeText(
                            _currentBowlingPlayer[0].playerName,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Lemonada",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
//                          child : Text(_currentBowlingPlayer[0].playerName,
//                            style: TextStyle(
//                              fontWeight: FontWeight.bold , fontStyle: FontStyle.italic, fontSize: 15,
//                            ),),),

                        Container(
                          width: _width * 0.6,
                          alignment: Alignment.topRight,
                          child : AutoSizeText(
                            _currentBowlingPlayer[0].overs.toStringAsFixed(1) + " - " + _currentBowlingPlayer[0].wicket.toString() + " - " + _currentBowlingPlayer[0].runsGiven.toString() + " - " + _currentBowlingPlayer[0].extra.toString(),
                            maxLines: 4,
                            //textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: "Oswaldd",
                              fontWeight: FontWeight.bold,
                            ),
                          ),

//                          child: Text(_currentBowlingPlayer[0].overs.toStringAsFixed(1) + "-" + _currentBowlingPlayer[0].wicket.toString() + "-" + _currentBowlingPlayer[0].runsGiven.toString() + "-" + _currentBowlingPlayer[0].extra.toString(),
//                            textAlign: TextAlign.end,  style: TextStyle(
//                              fontWeight: FontWeight.bold , fontStyle: FontStyle.italic, fontSize: 15,
//                            ), // has impact
//                          ),
                        )

                      ],
                    ),
                    SizedBox(height: _height * 0.008,),
                    Row(
                      children: balls,
                    )
                  ],
                )
            ),

            Container(
                width: _width,
                //height:  _height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: _height * 0.09,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1.0, color: Colors.black)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          flatButtonFromScoring(context, 0.toString()),
                          VerticalDivider(thickness: 1, color: Colors.black,),

                          flatButtonFromScoring(context, 1.toString()),
                          VerticalDivider(thickness: 1, color: Colors.black,),
                          flatButtonFromScoring(context, 2.toString()),
                        ],
                      ),
                    ),

                    Container(
                      height: _height * 0.09,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border(
                            left: BorderSide(width: 1.0, color: Colors.black),
                            right: BorderSide(width: 1.0, color: Colors.black),
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          flatButtonFromScoring(context, 3.toString()),
                          VerticalDivider(thickness: 1, color: Colors.black,),

                          flatButtonFromScoring(context, 4.toString()),
                          VerticalDivider(thickness: 1, color: Colors.black,),
                          flatButtonFromScoring(context, 6.toString()),
                        ],
                      ),
                    ),

                    Container(
                      height: _height * 0.09,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1.0, color: Colors.black)
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          flatButtonFromScoring(context, "OUT"),
                          VerticalDivider(thickness: 1, color: Colors.black,),

                          flatButtonFromScoring(context, "WD"),
                          VerticalDivider(thickness: 1, color: Colors.black,),
                          flatButtonFromScoring(context, "NB"),
                        ],
                      ),
                    ),
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }

  @override
  initState(){

    _currentBatttingPlayer.addAll(match.currentPlayers.battingTeamPlayer.values);
    _currentBowlingPlayer.addAll(match.currentPlayers.bowlingTeamPlayer.values);

    ballCouts = 0;
    super.initState();
  }

  List<Widget> buildBall(BuildContext context, String value){

    if(!isInningsOver) {
      if (balls.length > 6) {
        setState(() {
          balls.removeAt(0);
        });
      }

      Color color;
      switch (value.toUpperCase()) {
        case "0" :
          {
            color = Colors.transparent;
            setState(() {
              ballCouts++;
              match.currentPlayers.overs += 0.1;
              _currentBowlingPlayer[0].overs += 0.1;
              updateScoreForStriker(0);
            });
          }
          break;
        case "1" :
          {
            color = Colors.black12;
            setState(() {
              ballCouts++;
              match.currentPlayers.overs += 0.1;
              _currentBowlingPlayer[0].overs += 0.1;
              match.currentPlayers.run += 1;
              updateScoreForStriker(1);
              swapStrikers();
              _currentBowlingPlayer[0].runsGiven += 1;
            });
          }
          break;
        case "2" :
          {
            color = Colors.grey;
            ballCouts++;
            setState(() {
              match.currentPlayers.run += 2;
              match.currentPlayers.overs += 0.1;
              _currentBowlingPlayer[0].overs += 0.1;
              updateScoreForStriker(2);
              _currentBowlingPlayer[0].runsGiven += 2;
            });
          }
          break;
        case "3" :
          {
            color = Colors.blueGrey;
            setState(() {
              ballCouts++;
              match.currentPlayers.overs += 0.1;
              match.currentPlayers.run += 3;
              _currentBowlingPlayer[0].overs += 0.1;
              updateScoreForStriker(3);
              swapStrikers();
              _currentBowlingPlayer[0].runsGiven += 3;
            });
          }
          break;
        case "4" :
          {
            color = Colors.orangeAccent;
            setState(() {
              ballCouts++;
              updateScoreForStriker(4);
              match.currentPlayers.overs += 0.1;
              _currentBowlingPlayer[0].overs += 0.1;
              match.currentPlayers.run += 4;
              _currentBowlingPlayer[0].runsGiven += 4;
            });
          }
          break;
        case "6" :
          {
            color = Colors.lightGreen;
            setState(() {
              ballCouts++;
              updateScoreForStriker(6);
              match.currentPlayers.overs += 0.1;
              _currentBowlingPlayer[0].overs += 0.1;
              match.currentPlayers.run += 6;
              _currentBowlingPlayer[0].runsGiven += 6;
            });
          }
          break;
        case "OUT" :
          {
            color = Colors.red;
            setState(() {
              _currentBowlingPlayer[0].wicket ++;
              match.currentPlayers.overs += 0.1;
              _currentBowlingPlayer[0].overs += 0.1;
              //_currentBatttingPlayer.add(new Player(playerName: "fwsfwe", run: 0, ballsFaced:  0));
              ballCouts++;
              match.currentPlayers.wickets++;
              if(match.currentPlayers.wickets < ((match.isFirstInningsOver) ? match.secondInning.battingteam.players.length-1 : match.firstInning.battingteam.players.length-1) &&
              !isMatchOver() && !isInningsOver)
              Future.delayed(const Duration(milliseconds: 100), () {nextBatsman(context);});
            });
          }
          break;
        case "NB" :
          {
            color = Colors.grey;
            _currentBowlingPlayer[0].runsGiven ++;
            match.currentPlayers.extra ++;
            _currentBowlingPlayer[0].extra ++;
          }
          break;
        case "WD" :
          {
            color = Colors.grey;
            _currentBowlingPlayer[0].runsGiven ++;
            match.currentPlayers.extra ++;
            _currentBowlingPlayer[0].extra ++;
          }
          break;
        default :
          {
            color = Colors.transparent;
//        _currentBowlingPlayer[0].runsGiven ++;
//        _currentBowlingPlayer[0].extra ++;
          }
          break;
      }

      balls.add(
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1.0, color: Colors.black),
            color: color,
          ),
          margin: EdgeInsets.only(left: 10),
          child: Text(value.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
//                  fontStyle: FontStyle.italic,
                  fontFamily: "Oswaldd",
                  fontSize: 12
              )),
          padding: EdgeInsets.all(10.0),
        ),
      );

      if (ballCouts >= 6) {
        setState(() {
          ballCouts = 0;
          match.currentPlayers.overs += 0.4;
          swapStrikers();
          _currentBowlingPlayer[0].overs += 0.4;

          if (match.isFirstInningsOver) {
            match.secondInning.bowlingteam.players.update(
                _currentBowlingPlayer[0].playerUID, (
                value) => _currentBowlingPlayer[0]);
          } else {
            match.firstInning.bowlingteam.players.update(
                _currentBowlingPlayer[0].playerUID, (
                value) => _currentBowlingPlayer[0]);
          }

          if(match.currentPlayers.overs < match.totalOvers && !isMatchOver()) {
            Future.delayed(const Duration(milliseconds: 100), () {
              nextBowler(context);
            });
          }
        });
      }
    }else{
      if(match.result.isNotEmpty || !match.isLive) {
        matchSummaryData(context).then((value) => (){
          print("Match is finished");
        });
      }else{
        startNewInnings(context);
      }
    }
    return balls;
  }

  Widget flatButtonFromScoring(BuildContext context, String value){
    return Expanded(
      child: FlatButton(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Text(value, textAlign: TextAlign.center, style: TextStyle(
            fontWeight: FontWeight.bold , fontStyle: FontStyle.italic, fontSize: 20,
          )),
        ),
        color: Colors.transparent,
        onPressed: (){
          setState(() {
            //ballCouts++;
            balls = buildBall(context, value);
          });

          if(match.isLive) {
            if (isInnignsOver()) {
              setState(() {
                isInningsOver = true;
              });
              syncCurrentScoreWithInnings();

              if (!match.isFirstInningsOver) {
                match.isFirstInningsOver = true;
                //Update the score of first Innings
                startNewInnings(context);
                SyncCurrentPlayersWithInnings("firstInnings");
              } else {
                if (isMatchOver()) {
                  matchSummaryData(context);
                  SyncCurrentPlayersWithInnings("secondInnings");
                }
              }
                match.currentPlayers.run = 0;
                match.currentPlayers.wickets = 0;
                match.currentPlayers.overs = 0;
                match.currentPlayers.extra = 0;

            } else {
              if (isMatchOver()) {
                syncCurrentScoreWithInnings();
                matchSummaryData(context);
                SyncCurrentPlayersWithInnings("secondInnings");
              }
            }
            //isMatchOver();
            updateCurrentScore().then((value) => showSuccessColoredToast("Data Synced with server"));
          }else{
            matchSummaryData(context);
          }
        },
      ),
    );
  }

  Future SyncCurrentPlayersWithInnings(String inning){
    DatabaseService().updatePlayer(
        match, _currentBowlingPlayer[0], "bowling_team", inning);
    DatabaseService().updatePlayer(
        match, _currentBatttingPlayer[0], "batting_team", inning);
    DatabaseService().updatePlayer(
        match, _currentBatttingPlayer[1], "batting_team", inning);
  }

  syncCurrentScoreWithInnings(){
    if(match.isLive && !match.isFirstInningsOver) {
      match.firstInning.run = match.currentPlayers.run;
      match.firstInning.overs = match.currentPlayers.overs;
      match.firstInning.wickets = match.currentPlayers.wickets;
      match.firstInning.extra = match.currentPlayers.extra;
      match.target = match.currentPlayers.run + 1;

    }else {
      match.secondInning.run = match.currentPlayers.run;
      match.secondInning.overs = match.currentPlayers.overs;
      match.secondInning.wickets = match.currentPlayers.wickets;
      match.secondInning.extra = match.currentPlayers.extra;
    }
    DatabaseService().syncScoreSummaryWithInnings(match);
  }

  Future matchSummaryData(BuildContext context) async{
    return await showDialog(context: context,
        builder: (context) =>
            CustomDialog(matchGame: match, title: "Congratulations "+ match.winningTeam, description1: "", description2: match.result, buttonText: "Finish Game",));

  }

  startNewInnings(BuildContext context) {
    //Future.delayed(const Duration(seconds: 1), () {
    showDialog(context: context,
        builder: (context) =>
            CustomDialog(matchGame: match,
              title: "Start Second Innings",
              description1: "target : " + match.target.toString(),
              description2: match.secondInning.battingteam.getTeamName() +
                  " :  Need " + match.target.toString() +
                  " runs to win from " + match.totalOvers.toString() +
                  " overs.",
              buttonText: "Start Second Innings",));
    //});
  }

  bool isMatchOver(){
    if(match.isFirstInningsOver){

      if(match.currentPlayers.overs >= match.totalOvers){
        if(match.currentPlayers.run < match.firstInning.run){
          match.winningTeam = match.firstInning.battingteam.getTeamName();
          print(match.winningTeam + " won by "+(match.firstInning.run - match.currentPlayers.run).toString() + " runs");
          match.result = match.winningTeam + " won by "+(match.firstInning.run - match.currentPlayers.run).toString() + " runs";
          match.isLive = false;
          return true;
        }
      }
      else if(match.currentPlayers.run > match.firstInning.run){
        match.winningTeam = match.secondInning.battingteam.getTeamName();
        print(match.winningTeam + " won by "+(match.secondInning.battingteam.players.length - match.currentPlayers.wickets).toString() + " wickets");
        match.result = match.winningTeam + " won by "+(match.secondInning.battingteam.players.length - match.currentPlayers.wickets).toString() + " wickets";
        match.isLive = false;
        return true;
      }else if( match.currentPlayers.wickets == match.secondInning.battingteam.players.length-1){
        match.winningTeam = match.firstInning.battingteam.getTeamName();
        print(match.winningTeam + " team won by "+(match.firstInning.run - match.currentPlayers.run).toString() + " runs");
        match.result = match.winningTeam + " team won by "+(match.firstInning.run - match.currentPlayers.run).toString() + " runs";
        match.isLive = false;
        return true;
      }
    }
    return false;
  }

  isInnignsOver() {
    bool result = false;;
    if (match.isFirstInningsOver) {
      if (match.currentPlayers.overs.floor() >= match.totalOvers ||
          match.currentPlayers.wickets ==
              match.secondInning.battingteam.players.length - 1) {
        print("Innings over");
        result = true;
      }
    } else {
      if (match.currentPlayers.overs.floor() >= match.totalOvers ||
          match.currentPlayers.wickets ==
              match.firstInning.battingteam.players.length - 1) {
        print("Innings over");
        result = true;
      }
    }
    return result;
  }

  List<Player> yetToBatPlayers(List<Player> players){
    List<Player> yetoBat = new List();
    players.forEach((element) {
      if(!element.isOut){
        yetoBat.add(element);
      }
    });
    return yetoBat;
  }

  void nextBowler(BuildContext context){
      if (match.currentPlayers.overs < match.totalOvers) {
        List<Player> bowlers = new List();
        if (match.isFirstInningsOver) {
          bowlers.addAll(match.secondInning.bowlingteam.players.values);
        } else {
          bowlers.addAll(match.firstInning.bowlingteam.players.values);
        }

        bowlers.remove(_currentBowlingPlayer[0]);

        getSelectedPlayer(context, bowlers, "bowler").then((value) =>
        {
          if(value != null){
            replaceBowler(value),
          }
        });
      }

  }

  Future replaceBowler(Player player) {

    if(match.isFirstInningsOver) {
      DatabaseService().updatePlayer(
          match, _currentBowlingPlayer[0], "bowling_team",
          "secondInnings");
    }else{
      DatabaseService().updatePlayer(
          match, _currentBowlingPlayer[0], "bowling_team",
          "firstInnings");
    }
    setState(() {

      balls.clear();

      match.currentPlayers.bowlingTeamPlayer.remove(_currentBowlingPlayer[0].playerUID);
      _currentBowlingPlayer[0] = player;
      match.currentPlayers.bowlingTeamPlayer.putIfAbsent(player.playerUID, () => _currentBowlingPlayer[0]);
    });

    updateCurrentScore().then((value) => showSuccessColoredToast("Data Synced with server"));
  }

  nextBatsman(BuildContext context){
    if(match.currentPlayers.overs < match.totalOvers){

      //pop up to select next bowler
      List<Player> batsmans = new List();
      if(match.isFirstInningsOver){
        match.secondInning.battingteam.players.values.forEach((element) {
          if(!element.isOut) {
            batsmans.add(element);
          }
        });
      }else{
        match.firstInning.battingteam.players.values.forEach((element) {
          if(!element.isOut) {
            batsmans.add(element);
          }
        });
      }

      batsmans.remove(_currentBatttingPlayer[0]);
      batsmans.remove(_currentBatttingPlayer[1]);

      // PlayernextSelectedPlayer(context, bowlers, "Bowler");
      getSelectedPlayer(context, batsmans, "batsman").then((value) =>
      {
        if(value != null){
          replaceStrikerWithNewBatsma(value),
        }
      });


//      if(selectedPlayer != null){
//        setState(() {
//          _currentBowlingPlayer[0] = selectedPlayer;
//        });
//        DatabaseService().updatePlayer(match, selectedPlayer, "bowling_team", "firstInnings").then((value) =>
//            showSuccessColoredToast("User data updated"),
//        );
//      }
    }
  }

  Future<Player> getSelectedPlayer(BuildContext context, List<Player> plyersList, String playerType) async{
    if(plyersList.length > 0) {
      //Future.delayed(const Duration(seconds: 1), () async {
      Player selectedPlayer = await showDialog(context: context,
          builder: (context) =>
              selectPlayerDialog(
                  playerList: plyersList, playerType: playerType));
      return selectedPlayer;
      //});
    }
  }

  void replaceStrikerWithNewBatsma(Player newBatsman){
    int onStrikeIndex = (_currentBatttingPlayer[0].isOnStrike) ? 0 : 1;

    _currentBatttingPlayer[onStrikeIndex].isOut = true;

    if(match.isFirstInningsOver) {
      DatabaseService().updatePlayer(
          match, _currentBatttingPlayer[onStrikeIndex], "batting_team",
          "secondInnings");
    }else{
      DatabaseService().updatePlayer(
          match, _currentBatttingPlayer[onStrikeIndex], "batting_team",
          "firstInnings");
    }

    //Now replace the batsman
    setState(() {
      match.currentPlayers.battingTeamPlayer.remove(_currentBatttingPlayer[onStrikeIndex].playerUID);
      newBatsman.isOnStrike = true;
      _currentBatttingPlayer[onStrikeIndex] = newBatsman;
      match.currentPlayers.battingTeamPlayer.putIfAbsent(newBatsman.playerUID, () => _currentBatttingPlayer[onStrikeIndex]);

    });

    updateCurrentScore().then((value) => showSuccessColoredToast("Data Synced with server"));
  }

  Future updateCurrentScore() async{
    return await DatabaseService().updateCurrentPlayer(match);
  }

  // ignore: missing_return
  void PlayernextSelectedPlayer(BuildContext context, List<Player> players, String playerType) async{
    showDialog(context: context,
        builder: (context) => selectPlayerDialog(playerList: players, playerType: playerType)).then((value) =>
        (){
      if(playerType == "bowler") {
        DatabaseService().updatePlayer(match, _currentBowlingPlayer[0], "bowling_team", "firstInnings").then((value) =>
            showSuccessColoredToast("User data updated"));

        setState(() {
          _currentBowlingPlayer[0] = value;
        });
      }});
  }

  void swapStrikers(){
    if(_currentBatttingPlayer[0].isOnStrike){
      _currentBatttingPlayer[0].isOnStrike = false;
      _currentBatttingPlayer[1].isOnStrike = true;
    }else{
      _currentBatttingPlayer[0].isOnStrike = true;
      _currentBatttingPlayer[1].isOnStrike = false;
    }
  }

  void updateScoreForStriker(int run){
    if(_currentBatttingPlayer[0].isOnStrike) {
      _currentBatttingPlayer[0].run += run;
      _currentBatttingPlayer[0].ballsFaced++;
    }else{
      _currentBatttingPlayer[1].run += run;
      _currentBatttingPlayer[1].ballsFaced++;
    }
  }

}
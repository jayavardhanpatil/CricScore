//ScoreUpdateView

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/ToastWidget.dart';
import 'package:flutter_app/widgets/gradient.dart';

class ScoreUpdateView extends StatefulWidget{

  MatchGame match;
  final Function(dynamic) radioButtonValue;

  ScoreUpdateView({Key key, @required this.match, this.radioButtonValue}) : super (key : key);

  _ScoreUpdateView createState() => _ScoreUpdateView(match: match);

}

class _ScoreUpdateView extends State<ScoreUpdateView> {
  MatchGame match;

  _ScoreUpdateView({this.match});


  List<Player> _currentBatttingPlayer = new List();
  List<Player> _currentBowlingPlayer = new List();
  List<Widget> balls = new List();
  int ballCouts;

  @override
  initState(){

    _currentBatttingPlayer.addAll(match.currentPlayers.battingTeamPlayer.values);
    _currentBowlingPlayer.addAll(match.currentPlayers.bowlingTeamPlayer.values);

    ballCouts = 0;
    super.initState();
  }

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
        title: Text(match.currentPlayers.battingteam.getTeamName() + " Batting Inning"),
        flexibleSpace: getAppBarGradient(),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            Container(
              height: _height * 0.35,
              width: _width,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(match.currentPlayers.run.toString() + "/" +match.currentPlayers.wickets.toString(), style: TextStyle(
                    fontSize: 60,
                  ),),
                  Text("overs : "+match.currentPlayers.overs.toStringAsFixed(1) ,style: TextStyle(
                    fontSize: 20,
                  ),),
                  SizedBox(height: _height * 0.06,),
                  Text(match.tossWonTeam + " won the toss and elected to "+match.selectedInning.toLowerCase() + " first",  textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 15,
                  ),),
                ],
              ),
            ),

            Container(
                height: _height * 0.13,
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
                                margin: EdgeInsets.all(10),

                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),
                                child : Text(_currentBatttingPlayer[0].playerName, textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: (_currentBatttingPlayer[0].isOnStrike) ? FontWeight.bold : null , fontStyle: FontStyle.italic, fontSize: 20,
                                  ),),),

                            ],
                          ),
                          //SizedBox(height: _height * 0.01),

                          Container(
                            child: Text(_currentBatttingPlayer[0].run.toString() + " ("+_currentBatttingPlayer[0].ballsFaced.toString()+")",
                                style: TextStyle(
                                  fontSize: 18,
                                )),

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
                                margin: EdgeInsets.all(10),

                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),
                                child : Text(_currentBatttingPlayer[1].playerName, textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: (_currentBatttingPlayer[1].isOnStrike) ? FontWeight.bold : null , fontStyle: FontStyle.italic, fontSize: 20,
                                  ),),),

                            ],
                          ),


                          Container(
                            child: Text(_currentBatttingPlayer[1].run.toString() + " ("+_currentBatttingPlayer[1].ballsFaced.toString()+")",
                                style: TextStyle(
                                  fontSize: 18,
                                )),

                          ),
                        ],

                      ),
                    ),
                  ],
                )
            ),

            Container(
                height: _height * 0.18,
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
                          child: CircleAvatar(
                            backgroundImage: ExactAssetImage(
                                "lib/assets/images/cricket_ball.png"),
                            backgroundColor: Colors.orangeAccent,
                            minRadius: 20,
                            maxRadius: 20,
                          ),
                          margin: EdgeInsets.all(15),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child : Text(_currentBowlingPlayer[0].playerName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold , fontStyle: FontStyle.italic, fontSize: 18,
                            ),),),

                        Container(
                          width: _width * 0.6,
                          child: Text(_currentBowlingPlayer[0].overs.toStringAsFixed(1) + "-" + _currentBowlingPlayer[0].wicket.toString() + "-" + _currentBowlingPlayer[0].runsGiven.toString() + "-" + _currentBowlingPlayer[0].extra.toString(),
                            textAlign: TextAlign.end,  style: TextStyle(
                              fontWeight: FontWeight.bold , fontStyle: FontStyle.italic, fontSize: 18,
                            ), // has impact
                          ),
                        )

                      ],
                    ),

                    Row(
                      children: balls,
                    )

                  ],
                )
            ),


            Container(
                width: _width,
                height:  _height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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

  List<Widget> buildBall(BuildContext context, String value){

    if(balls.length > 6){
      setState(() {
        balls.removeAt(0);
      });
    }

    Color color;
    switch(value.toUpperCase()){
      case "0" : {
        color = Colors.transparent;
        setState(() {
          ballCouts++;
          match.currentPlayers.overs += 0.1;
          _currentBowlingPlayer[0].overs += 0.1;
          updateScoreForStriker(0);
        });
      }
      break;
      case "1" : {
        color = Colors.grey;
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
      case "2" : {
        color = Colors.blueGrey;
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
      case "3" : {
        color = Colors.black12;
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
      case "4" : {
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
      case "6" :{
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
      case "OUT" :{
        color = Colors.redAccent;
        setState(() {
          _currentBowlingPlayer[0].wicket ++;
          match.currentPlayers.overs += 0.1;
          _currentBowlingPlayer[0].overs += 0.1;
          //_currentBatttingPlayer.add(new Player(playerName: "fwsfwe", run: 0, ballsFaced:  0));
          ballCouts++;
          match.currentPlayers.wickets++;
        });

      }
      break;
      case "NB" :{
        color = Colors.grey;
        _currentBowlingPlayer[0].runsGiven ++;
        _currentBowlingPlayer[0].extra ++;
      }
      break;
      case "WD" :{
        color = Colors.black12;
        _currentBowlingPlayer[0].runsGiven ++;
        _currentBowlingPlayer[0].extra ++;
      }
      break;
      default :{
        color = Colors.transparent;
//        _currentBowlingPlayer[0].runsGiven ++;
//        _currentBowlingPlayer[0].extra ++;
      }
      break;
    }

    balls.add(
      Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.0, color: Colors.black),
          color : color,
        ),
        margin: EdgeInsets.only(left: 10),
        child: Text(value.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold , fontStyle: FontStyle.italic, fontSize: 20
            )),
        padding: EdgeInsets.all(10.0),
      ),
    );

    if(ballCouts >= 6){
      setState(() {
        ballCouts = 0;
        match.currentPlayers.overs += 0.4;
        swapStrikers();
        _currentBowlingPlayer[0].overs += 0.4;
      });
    }


    DatabaseService().updateScoreOnBall(match).then((value) => (){
      showSuccessColoredToast("Data Synced");
    }).catchError((e){
      print("failed to sync data" + e.toString());
    });
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
            DatabaseService().updateScoreOnBall(match).then((value) => (){
              showSuccessColoredToast("Data Synced");
            });
          });
        },
      ),
    );
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
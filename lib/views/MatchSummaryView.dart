

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/selectTeam.dart';
import 'package:flutter_app/widgets/gradient.dart';
import 'package:flutter_app/widgets/loader.dart';

class MatchSummaryList extends StatefulWidget{
  _MatchSummaryList createState() => _MatchSummaryList();
}


class _MatchSummaryList extends State<MatchSummaryList> {

  String usercity;
  Future matches;
  MatchGame game;
  bool loading = true;
  List<MatchGame> _matches = new List();
  List<Player> batsmansplayers;
  List<Player> bowler;

  @override
  void initState() {
    usercity = AuthService.user.getCity();
    matches = getMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Matches in your City"),
//      ),
      body: SingleChildScrollView(
        child : Container(
          child: Column(
            children: <Widget>[
              matchListView(context),
//              Container(
//               child: userListView(context),
//              )
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }



  Future MatchList() async{
    return await DatabaseService().getListOfMatches(usercity);
  }

  Widget matchListView(BuildContext context){
    return FutureBuilder(
        future: matches,
        // ignore: missing_return
        builder: (context,  snapshot){
          if(snapshot.data == null){
            return Loading();
          } else if (snapshot.hasData) {
            _matches = snapshot.data;
            _matches.forEach((element) {
              print(element.getMatchTitle());
            });
            if(_matches.length > 0){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _matches.length,
                  itemBuilder: (context, index) {
                    return getCardList(context, index);
                  }
              );
            }else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                        color: const Color(0xFF75A2EA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: AutoSizeText(
                            "Start New Match",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SelectTeam()));
                        }
                    ),
                  ],
                ),
              );
            }
          }else{
            return Text("No data");
          }
        });
  }

//  Future getListOfMatchesintheCities(){
//     listOfMatches = DatabaseService().getListOfMatches(usercity);
//  }


  Widget getCardList(BuildContext context, index){
    return Container(
      height: 250,
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        color : (_matches[index].isLive) ? null : Color.fromRGBO(255, 255, 255, 0.2),
        child: (_matches[index] != null ) ? updateGameData(_matches[index]) : Container(),
      ),
    );
  }


  Future getMatches() async{
    return await DatabaseService().getListOfMatches(usercity);
  }

  Widget updateGameData(MatchGame matchGame){
    return StreamBuilder<MatchGame>(
      stream: DatabaseService().gameStreamData(matchGame.getMatchVenue(), matchGame.getMatchTitle()),
      builder: (context, snapshot){
        if(snapshot.hasData){
          matchGame = snapshot.data;
          batsmansplayers = matchGame.currentPlayers.battingTeamPlayer.values.toList();
          bowler = matchGame.currentPlayers.bowlingTeamPlayer.values.toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),

                    child: AutoSizeText(
                      matchGame.getMatchTitle().substring(0, matchGame.getMatchTitle().lastIndexOf(" - ")),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Literata',
                        //color: Color(0xFF75A2EA),
                      ),


//                    child : Text(matchGame.getMatchTitle().substring(0, matchGame.getMatchTitle().lastIndexOf(" - ")), textAlign: TextAlign.center, style: TextStyle(
//                      fontWeight: FontWeight.bold, fontSize: 25 ,fontFamily: 'Bitter bold', fontStyle: FontStyle.italic,
//                    ),),
                    ),
                  ),

                  if (matchGame.isLive) Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.all(5),
                    child : Text("Live", textAlign: TextAlign.center,style: TextStyle(fontSize: 10,
                    ),),
                  ) else Container(),
                ],
              ),

//              Container(
//                alignment: Alignment.topRight,
//                padding: EdgeInsets.only(top: 10, right: 10),
//                child : Text(_matches[index].getMatchTitle().substring(_matches[index].getMatchTitle().lastIndexOf(" - ")+3), textAlign: TextAlign.center,style: TextStyle(
//                  fontSize: 15,
//                ),),
//              ),

              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: AutoSizeText(
                              matchGame.firstInning.battingteam.getTeamName(),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style : TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Literata',
                              ),
                            ),

//                            child: Text(matchGame.firstInning.battingteam.getTeamName(), textAlign: TextAlign.center, style : TextStyle(
//                              fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'ERGaramond italic', fontStyle: FontStyle.italic,
//                            ),),
                            margin: EdgeInsets.all(5),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5),

                            child: AutoSizeText(
                              (matchGame.isFirstInningsOver) ? matchGame.firstInning.run.toString() + "/" + matchGame.firstInning.wickets.toString()
                                  : matchGame.currentPlayers.run.toString() + "/" + matchGame.currentPlayers.wickets.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Oswaldd',
                              ),
                            ),


//                            child: Text(
//                              (matchGame.isFirstInningsOver) ? matchGame.firstInning.run.toString() + "/" + matchGame.firstInning.wickets.toString()
//                                  : matchGame.currentPlayers.run.toString() + "/" + matchGame.currentPlayers.wickets.toString(),
//                              style: TextStyle(
//                                fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'ERGaramond',
//                              ),
//
//                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: (matchGame.isLive) ? getButtonGradientColor(BoxShape.circle) :
                      BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 255, 255, 0.0),
                          border: Border.all(width: 1.0, color: Colors.black)
                      ),
                      margin: EdgeInsets.all(5),
                      child: Text("VS",style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300,),
                      ),
                      padding: EdgeInsets.all(5.0),

                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(

                            padding: EdgeInsets.only(left: 5),

                            child: AutoSizeText(
                              matchGame.secondInning.battingteam.getTeamName(),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style : TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Literata',
                              ),
                            ),

//                            child: Text(matchGame.secondInning.battingteam.getTeamName(), textAlign: TextAlign.center,style : TextStyle(
//                              fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'ERGaramond italic', fontStyle: FontStyle.italic,
//                            ),),
                            margin: EdgeInsets.all(5),
                          ),
                          Container(

                            child: AutoSizeText(
                              (matchGame.isFirstInningsOver && matchGame.isLive) ? matchGame.currentPlayers.run.toString() + "/" + matchGame.currentPlayers.wickets.toString()
                                  : matchGame.secondInning.run.toString() + "/" + matchGame.secondInning.wickets.toString(),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Oswaldd',
                              ),
                            ),

//                            child: Text(
//                              (matchGame.isFirstInningsOver) ? matchGame.currentPlayers.run.toString() + "/" + matchGame.currentPlayers.wickets.toString()
//                                  : matchGame.secondInning.run.toString() + "/" + matchGame.secondInning.wickets.toString(),
//                              style: TextStyle(
//                                fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'ERGaramond',
//                              ),
//                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              Container(

                margin: EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      AutoSizeText(
                        "Batsman : ",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Lemonada',
                        ),
                      ),

                      SizedBox(width: 10,),

                      Container(
                        child: CircleAvatar(
                          backgroundImage: ExactAssetImage(
                              "lib/assets/images/batting.png"),
                          backgroundColor: (batsmansplayers[0].isOnStrike) ? Colors.orangeAccent : Colors.transparent,
                          minRadius: 8,
                          maxRadius: 8,
                        ),
                        margin: EdgeInsets.all(5),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),

                        child : AutoSizeText(
                          batsmansplayers[0].playerName + " :-   "+batsmansplayers[0].run.toString() + "(" + batsmansplayers[0].ballsFaced.toString() + ")",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: (batsmansplayers[0].isOnStrike) ? FontWeight.bold : null , fontSize: 13,
                              fontFamily: 'Literata'),),),


                      SizedBox(width: 15,),

                      Container(
                        child: CircleAvatar(
                          backgroundImage: ExactAssetImage(
                              "lib/assets/images/batting.png"),
                          backgroundColor: (batsmansplayers[1].isOnStrike) ? Colors.orangeAccent : Colors.transparent,
                          minRadius: 8,
                          maxRadius: 8,
                        ),
                        margin: EdgeInsets.all(5),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child : AutoSizeText(
                          batsmansplayers[1].playerName + " :-   "+batsmansplayers[1].run.toString() + "(" + batsmansplayers[1].ballsFaced.toString() + ")",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: (batsmansplayers[1].isOnStrike) ? FontWeight.bold : null , fontSize: 13,
                              fontFamily: 'Literata'),),),
                    ],
                  )
              ),

              Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      AutoSizeText(
                        "Bowler : ",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Lemonada',
                        ),
                      ),

                      SizedBox(width: 10,),

                      Container(
                        child: CircleAvatar(
                          backgroundImage: ExactAssetImage(
                              "lib/assets/images/cricket_ball.png"),
                          backgroundColor: Colors.orangeAccent,
                          minRadius: 8,
                          maxRadius: 8,
                        ),
                        margin: EdgeInsets.all(5),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child : AutoSizeText(
                          bowler[0].playerName + " :     "+bowler[0].overs.toStringAsFixed(1) + " - " + bowler[0].wicket.toString() + " - " + bowler[0].runsGiven.toString() + " - " + bowler[0].extra.toString(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold , fontSize: 13,
                              fontFamily: 'Literata'),),),
                    ],
                  )
              ),

              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 30),
                child:  AutoSizeText(
                  (!matchGame.isLive) ? "Result :     " + matchGame.result :
                  (matchGame.isFirstInningsOver) ? "Target :     "+matchGame.target.toString() : "",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Lemonada',
                  ),
                ),
              ),
            ],
          );
        }else if(snapshot.data == null){
          return Loading();
        }else{
          return Text("No Data");
        }
      },
    );
  }
}
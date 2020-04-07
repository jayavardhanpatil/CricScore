

import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/gradient.dart';
import 'package:flutter_app/widgets/loader.dart';
import 'package:shimmer/shimmer.dart';

class MatchSummaryList extends StatefulWidget{
  _MatchSummaryList createState() => _MatchSummaryList();
}


class _MatchSummaryList extends State<MatchSummaryList> {

  String usercity;
  Future matches;
  MatchGame game;
  bool loading = true;
  List<MatchGame> _matches = new List();

  @override
  void initState() {
    usercity = AuthService.user.getCity();
    matches = getMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matches in your City"),
      ),
      body: SingleChildScrollView(
        child : Container(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
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
      height: 200,
      child: Card(
          elevation: 10,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Container(
                    padding: EdgeInsets.all(10),
                    child : Text(matchGame.getMatchTitle().substring(0, matchGame.getMatchTitle().lastIndexOf(" - ")), textAlign: TextAlign.center,style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20,
                    ),),
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
                            padding: EdgeInsets.only(left: 20),
                            child: Text(matchGame.firstInning.battingteam.getTeamName(), textAlign: TextAlign.center, style : TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15,
                            ),),
                            margin: EdgeInsets.all(10),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              (matchGame.isFirstInningsOver) ? matchGame.firstInning.run.toString() + "/" + matchGame.firstInning.wickets.toString()
                                  : matchGame.currentPlayers.run.toString() + "/" + matchGame.currentPlayers.wickets.toString(),
                              style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold,
                              ),

                            ),
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
                      margin: EdgeInsets.all(10),
                      child: Text("VS",style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300,),
                      ),
                      padding: EdgeInsets.all(10.0),

                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(matchGame.secondInning.battingteam.getTeamName(), textAlign: TextAlign.center,style : TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15,
                            ),),
                            margin: EdgeInsets.all(10),
                          ),
                          Container(
                            child: Text(
                              (matchGame.isFirstInningsOver) ? matchGame.currentPlayers.run.toString() + "/" + matchGame.currentPlayers.wickets.toString()
                                  : matchGame.secondInning.run.toString() + "/" + matchGame.secondInning.wickets.toString(),
                              style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
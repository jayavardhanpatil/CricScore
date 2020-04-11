import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:CricScore/model/match.dart';
import 'package:CricScore/model/player.dart';
import 'package:CricScore/model/team.dart';
import 'package:CricScore/services/auth_service.dart';
import 'package:CricScore/services/database_service.dart';
import 'package:CricScore/views/selectPlayers.dart';
import 'package:CricScore/views/startMatch.dart';
import 'package:CricScore/widgets/ToastWidget.dart';
import 'package:CricScore/widgets/gradient.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';


class SelectTeam extends StatefulWidget{

  _SelectTeam createState() => _SelectTeam();

}

class _SelectTeam extends State<SelectTeam> {

  Color primaryColor = const Color(0xFF75A2EA);

  String previousvalueFirstTeam = "";
  String previousvalueSecondteam = "";

  String todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController _firstTteamName = TextEditingController();
  final _secondTteamName = TextEditingController();
  final _firstTeamCity = TextEditingController();
  final _secondTeamCity = TextEditingController();
  final __typefirstAheadController = TextEditingController();
  final __typesecondAheadController = TextEditingController();
  //final _venueCity = TextEditingController();
  final _venuetypeAheadController = TextEditingController();


  MatchGame match;

  initState(){
    super.initState();
    match = new MatchGame();
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
        title: AutoSizeText(
          "Select teams",
          maxLines: 1,
          style: TextStyle(
              fontFamily: "Lemonada",
          ),
        ),
        flexibleSpace: getAppBarGradient(),
      ),
      body: SingleChildScrollView(
              
              padding: EdgeInsets.all(10),
              
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  AutoSizeText(
                    "Select teams",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 30,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lemonada",
                    ),
                  ),

//                  Text("Select teams" , style: TextStyle(
//                      color: Colors.black, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontSize: 25)),
////                  SizedBox(height: _height * 0.01),
////
////                  typeAhed(_venueCity, _venuetypeAheadController, _width * 0.5, "Match venue"),

                  SizedBox(height: _height * 0.01),

                  TextField(
                    //validator: Validator.validate,
                    controller: _firstTteamName,
                    decoration: inputDecoration("Team A Name"),
                      onTap: (){
                        previousvalueFirstTeam = _firstTteamName.text;
                      },
                    style: TextStyle(fontFamily: "Lemonada",),
                    ),

                  SizedBox(height: _height * 0.01),

                    Row(children: <Widget>[
                      Container(
                        child: typeAhed(__typefirstAheadController, _firstTeamCity, _width * 0.5, "Team A City"),
                      ),

                      Container(
                        child: addPlayersButton(_firstTteamName.text, previousvalueFirstTeam, _firstTeamCity.text),
                      ),
                    ]),

                  //rowWithCityAndPlayer(__typefirstAheadController, _firstTeamCity, _width * 0.5, _firstTteamName, "Team A City"),


                  SizedBox(height: _height * 0.05),

                  rowWithText("VS"),

                  SizedBox(height: _height * 0.04),

                  TextFormField(
                    validator: Validator.validate,
                    controller: _secondTteamName,
                    decoration: inputDecoration("Team B Name"),
                    onTap: (){
                      previousvalueSecondteam = _secondTteamName.text;
                    },
                    style: TextStyle(fontFamily: "Lemonada",),

                  ),

                  SizedBox(height: _height * 0.01),

                  Row(children: <Widget>[
                    Container(
                      child: typeAhed(__typesecondAheadController, _secondTeamCity, _width * 0.5, "Team B City"),
                    ),

                    Container(
                      child: addPlayersButton(_secondTteamName.text, previousvalueSecondteam, _secondTeamCity.text),
                    ),
                  ]),

                  SizedBox(height: _height * 0.07),

                  //SilderButton("Slide to Start a match", _height * 0.09, _width * 0.8, context),


                  RaisedButton(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: AutoSizeText(
                        "Start Match",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          fontFamily: "Lemonada",
                        ),
                      ),
                    ),
                    onPressed: () {
                      print("after changin the value : "+ _firstTteamName.text);
                      String matchBetween = "";
                      match.teams.forEach((key, value) {
                        matchBetween = matchBetween + key + " - ";
                      });
                      match.setMatchTitle(matchBetween.substring(0, matchBetween.length-3) + " - " + todaysDate);
                      print("Match Between "+ match.getMatchTitle());
                      match.teams.forEach((key, value) {
                        print("Team Name : "+key);
                        //print("Team City : "+value.getTeamCity());
//                          for(int i=0;i<value.getTeamPlayers().length;i++){
//                            print("Team Player : "+value.players[i].playerName);
//                          }playerName
                      });

                      match.teams.forEach((key, value) {
                        DatabaseService().addTeams(value);
                      });

                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StartMatch(match: match)));
                    },
                  ),


//                  FlatButton(
//                    onPressed: (){
//                      print("after changin the value : "+ _firstTteamName.text);
//                      String matchBetween = "";
//                      match.teams.forEach((key, value) {
//                        matchBetween = matchBetween + key + " - ";
//                      });
//                      match.setMatchTitle(matchBetween.substring(0, matchBetween.length-3) + " - " + todaysDate);
//                      print("Match Between "+ match.getMatchTitle());
//                      match.teams.forEach((key, value) {
//                          print("Team Name : "+key);
//                          //print("Team City : "+value.getTeamCity());
////                          for(int i=0;i<value.getTeamPlayers().length;i++){
////                            print("Team Player : "+value.players[i].playerName);
////                          }playerName
//                        });
//
//                      match.teams.forEach((key, value) {
//                        DatabaseService().addTeams(value);
//                      });
//
//                      Navigator.pop(context);
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => StartMatch(match: match)));
//
//                      //DatabaseService().addMatchDetails(match);
//
////                        match.teams.forEach((key, value) {
////                          DatabaseService().addMatchDetails(match);
////                          print("Team Name : "+value.getTeamName());
////                          print("Team City : "+value.getTeamCity());
////                          for(int i=0;i<value.getTeamPlayers().length;i++){
////                            print("Team Player : "+value.getTeamPlayers()[i].getName());
////                          }
////                        });
//                    },
//                    textColor: Colors.white,
//                    child: Container(
//                      decoration: getButtonGradientColor(BoxShape.rectangle),
//                      padding: const EdgeInsets.all(20.0),
//                      child: const Text(
//                          'Start Match',
//                          style: TextStyle(fontSize: 20)
//                      ),
//                    ),
//                  ),
                ],
              ),
      ),

    );
  }

  inputDecoration(String lable){
    return new InputDecoration(
      labelText: lable,
      fillColor: Colors.white,
//      border: new OutlineInputBorder(
//        borderRadius: new BorderRadius.circular(5.0),
//      ),
    );
  }



  addPlayersButton(String currentTeamName,  String previousTeamName, String teamCity){

    return Container(
      padding: EdgeInsets.only(left: 20, right: 10),
      child: Column(
        children: <Widget>[

            RaisedButton.icon(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),

                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              label: AutoSizeText(
                  "Players",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    fontFamily: "Lemonada",
                  ),
                ),
              onPressed: () {
                print("current Team Name : " + currentTeamName);
                print("Previous Team name : " + previousTeamName);

                selectPlayers(currentTeamName, previousTeamName, teamCity);
              },
              icon: Icon(Icons.add, color: Colors.white,),
//              label: Text("Players", style: TextStyle(
//                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
//              ),
            ),





//            decoration: getButtonGradientColor(BoxShape.rectangle),
//            child: FlatButton.icon(
//              padding: EdgeInsets.all(12),
////              shape :RoundedRectangleBorder(
////                borderRadius: new BorderRadius.circular(18.0),
////              ),
//              color: Colors.transparent,
//              onPressed: (){
//                print("current Team Name : "+currentTeamName);
//                print("Previous Team name : "+previousTeamName);
//
//                selectPlayers(currentTeamName, previousTeamName, teamCity);
//              },
//              icon: Icon(Icons.add, color: Colors.white,),
//              label: Text("Players", style: TextStyle(
//                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
//              ),
//            ),
        ],
      ),
    );
  }

  selectPlayers(String currentTeamName, String previousTypedTeamName, String cityName) async{
    {
      Team team = new Team();
      Map<String, Player> selectedTeamPlayers = new Map();

      if(currentTeamName.length < 3){
        showFailedColoredToast("Team Name length should be greater then 3 letter");
      }else {
        team.setTeamName(currentTeamName);
        team.setTeamCity(cityName);

        print("Seelcted City Name : "+ cityName + " for tema Name : "+currentTeamName);

        print("Previously typed : "+previousTypedTeamName);
        print("Current typed : "+ currentTeamName);

        //print("Contains team Name : "+match.teams.containsKey(previousTypedTeamName).toString());
        if(match.teams != null && match.teams.containsKey(currentTeamName)){
          if(match.teams[currentTeamName].players != null) {
            selectedTeamPlayers = match.teams[currentTeamName].players;
          }
        }

        team.setTeamPlayers(selectedTeamPlayers);

        if(previousTypedTeamName.isNotEmpty && (previousTypedTeamName != currentTeamName)){
          match.teams.remove(previousTypedTeamName);
        }

//        if(match.teams != null && previousTypedTeamName.isNotEmpty && (previousTypedTeamName != currentTeamName) && match.teams.containsKey(previousTypedTeamName)){
//          print("copy old players : ");
//          team.setTeamPlayers(match.teams[previousTypedTeamName].getTeamPlayers());
//          print(team.getTeamPlayers());
//          match.teams.remove(previousTypedTeamName);
//          print(team.getTeamPlayers());
//        }else{
//          team.setTeamPlayers(new List<Player>());
//        }
        match.addTeam(currentTeamName, team);
        //match.teams.update(currentTeamName, (value) => team, ifAbsent: () => team);
        //print(match.getTeams()[teamName.text].getTeamName());

        selectedTeamPlayers = await Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayersList(match: match, team: team,)));

        team.setTeamPlayers(selectedTeamPlayers);
        match.addTeam(team.teamName, team);
      }
    }
  }

  typeAhed(TextEditingController typedValue,  TextEditingController valueController, double width, String lable){
    return Container(
      width: width,
      child: TypeAheadFormField(
        suggestionsBoxVerticalOffset: -100,
        getImmediateSuggestions: true,
        hideSuggestionsOnKeyboardHide: false,
        textFieldConfiguration: TextFieldConfiguration(
          controller: typedValue,
          decoration: inputDecoration(lable),
          style: TextStyle(fontFamily: "Lemonada",),
        ),
        suggestionsCallback: (pattern) {
          // ignore: missing_return
          if(pattern.length > 2) {
            return DatabaseService().getCity(pattern[0].toUpperCase()+pattern.substring(1));
          }
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion, style: TextStyle(fontFamily: "Lemonada",),),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          typedValue.text = suggestion;
          valueController.text = suggestion;
        },
      ),
    );
  }

  rowWithText(String text){
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
      Container(
            decoration: getButtonGradientColor(BoxShape.circle),
          child: AutoSizeText(
            text,
            maxLines: 4,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: "Lemonada",
              color: Colors.white,

            ),
          ),
          padding: EdgeInsets.all(20.0),

      ),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
    ]);
  }

}
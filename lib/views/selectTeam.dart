import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/model/team.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/selectPlayers.dart';
import 'package:flutter_app/views/startMatch.dart';
import 'package:flutter_app/widgets/ToastWidget.dart';
import 'package:flutter_app/widgets/gradient.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';



class SelectTeam extends StatefulWidget{

  _SelectTeam createState() => _SelectTeam();

}

class _SelectTeam extends State<SelectTeam> {

  String previousvalueFirstTeam = "";
  String previousvalueSecondteam = "";

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
        title: Text("Select Team"),
        flexibleSpace: getAppBarGradient(),
      ),
      body: Center(
            child: SingleChildScrollView(
              
              padding: EdgeInsets.all(10),
              
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text("Select teams" , style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontSize: 25)),
//                  SizedBox(height: _height * 0.01),
//
//                  typeAhed(_venueCity, _venuetypeAheadController, _width * 0.5, "Match venue"),

                  SizedBox(height: _height * 0.05),

                  TextField(
                    //validator: Validator.validate,
                    controller: _firstTteamName,
                    decoration: inputDecoration("Team A Name"),
                      onTap: (){
                        previousvalueFirstTeam = _firstTteamName.text;
                      },
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


                  SizedBox(height: _height * 0.07),

                  rowWithText("VS"),

                  SizedBox(height: _height * 0.06),

                  TextFormField(
                    validator: Validator.validate,
                    controller: _secondTteamName,
                    decoration: inputDecoration("Team B Name"),
                    onTap: (){
                      previousvalueSecondteam = _secondTteamName.text;
                    },

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
                    onPressed: (){
                      print("after changin the value : "+ _firstTteamName.text);
                      String matchBetween = "";
                      match.teams.forEach((key, value) {
                        matchBetween = matchBetween + key + " - ";
                      });
                      match.setMatchTitle(matchBetween.substring(0, matchBetween.length-3));
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


                      Navigator.push(context, MaterialPageRoute(builder: (context) => StartMatch(match: match)));

                      //DatabaseService().addMatchDetails(match);

//                        match.teams.forEach((key, value) {
//                          DatabaseService().addMatchDetails(match);
//                          print("Team Name : "+value.getTeamName());
//                          print("Team City : "+value.getTeamCity());
//                          for(int i=0;i<value.getTeamPlayers().length;i++){
//                            print("Team Player : "+value.getTeamPlayers()[i].getName());
//                          }
//                        });
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: getButtonGradientColor(BoxShape.rectangle),
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                          'Start Match',
                          style: TextStyle(fontSize: 20)
                      ),
                    ),
                  ),
                ],
              ),
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
          Container(
            decoration: getButtonGradientColor(BoxShape.rectangle),
            child: RaisedButton.icon(
              padding: EdgeInsets.all(12),
//              shape :RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(18.0),
//              ),
              color: Colors.transparent,
              onPressed: (){
                print("current Team Name : "+currentTeamName);
                print("Previous Team name : "+previousTeamName);

                selectPlayers(currentTeamName, previousTeamName, teamCity);
              },
              icon: Icon(Icons.add, color: Colors.white,),
              label: Text("Players", style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
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
        textFieldConfiguration: TextFieldConfiguration(
          controller: typedValue,
          decoration: inputDecoration(lable),
        ),
        suggestionsCallback: (pattern) {
          // ignore: missing_return
          if(pattern.length > 2) {
            return DatabaseService().getCity(pattern[0].toUpperCase()+pattern.substring(1));
          }
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
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
          child: Text(text,style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
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
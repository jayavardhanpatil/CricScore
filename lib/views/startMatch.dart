import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/team.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/selectPlayers.dart';
import 'package:flutter_app/widgets/ToastWidget.dart';
import 'package:flutter_app/widgets/animatedButtton.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';



class StartMatch extends StatefulWidget{

  _StartMatch createState() => _StartMatch();

}

class _StartMatch extends State<StartMatch> {

  String previousvalueFirstTeam = "";
  String previousvalueSecondteam = "";

  TextEditingController _firstTteamName = TextEditingController();
  final _secondTteamName = TextEditingController();
  final _firstTeamCity = TextEditingController();
  final _secondTeamCity = TextEditingController();
  final __typefirstAheadController = TextEditingController();
  final __typesecondAheadController = TextEditingController();
  final _venueCity = TextEditingController();
  final _venuetypeAheadController = TextEditingController();
  TextEditingController _controller = new TextEditingController();


  Match match;

  initState(){
    super.initState();
    match = new Match();
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
        title: Text("Start Match"),
      ),
      body: Center(
            child: SingleChildScrollView(
              
              padding: EdgeInsets.all(10),
              
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text("Choose teams"),
                  SizedBox(height: _height * 0.01),

                  typeAhed(_venueCity, _venuetypeAheadController, _width * 0.5, "Match venue"),

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


                  SizedBox(height: _height * 0.05),

                  rowWithText("VS"),

                  SizedBox(height: _height * 0.05),

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

                  SizedBox(height: _height * 0.08),

                  SilderButton("Slide to Start a match", _height * 0.09, _width * 0.8, context),

                  RaisedButton(
                    onPressed: (){
                      print("after changin the value : "+ _firstTteamName.text);
                        match.teams.forEach((key, value) {
                          DatabaseService().addMatchDetails(match);
                          print("Team Name : "+value.getTeamName());
                          print("Team City : "+value.getTeamCity());
                          for(int i=0;i<value.getTeamPlayers().length;i++){
                            print("Team Player : "+value.getTeamPlayers()[i].getName());
                          }
                        });
                    },
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
            child: RaisedButton.icon(
              padding: EdgeInsets.all(10),
              shape :RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              color: Colors.blue,
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
      List<User> selectedTeamPlayers;

      if(currentTeamName.length < 3){
        showFailedColoredToast("Team Name length should be greater then 3 letter");
      }else {
        team.setTeamName(currentTeamName);
        team.setTeamCity(cityName);

        print("Seelcted City Name : "+ cityName + " for tema Name : "+currentTeamName);

        print("Previously typed : "+previousTypedTeamName);
        print("Current typed : "+ currentTeamName);
        print("Contains team Name : "+match.teams.containsKey(previousTypedTeamName).toString());

        match.teams.forEach((key, value) {
          print(key);
        });

        if(previousTypedTeamName.isNotEmpty && (previousTypedTeamName != currentTeamName) && match.teams.containsKey(previousTypedTeamName)){
          print("copy old players : ");
          team.setTeamPlayers(match.teams[previousTypedTeamName].getTeamPlayers());
          print(team.getTeamPlayers());
          match.teams.remove(previousTypedTeamName);
          print(team.getTeamPlayers());
        }else{
          team.setTeamPlayers(new List<User>());
        }

        match.teams.update(currentTeamName, (value) => team, ifAbsent: () => team);
        //print(match.getTeams()[teamName.text].getTeamName());

        selectedTeamPlayers = await Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayersList(match: match, team: team,)));

        team.setTeamPlayers(selectedTeamPlayers);
        match.teams.update(team.getTeamName(), (value) => team);
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
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            ),
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
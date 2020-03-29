
import 'package:flutter_app/model/user.dart';

class Team {

  String _teamName;
  List<User> _players;
  String _teamCity;


  void setTeamName(String teamName){
    this._teamName = teamName;
  }

  void setTeamCity(String teamCity){
    this._teamCity = teamCity;
  }

  void setTeamPlayers(List<User> players){
    this._players = players;
  }

  String getTeamName(){
    return this._teamName;
  }

  List<User> getTeamPlayers(){
    return this._players;
  }

  String getTeamCity(){
    return this._teamCity;
  }

}
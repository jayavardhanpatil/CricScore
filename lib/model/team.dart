

import 'package:flutter_app/model/user.dart';

class Team {

  final String _teamName;
  final List<User> _players;
  final String teamCity;

  Team(this._teamName, this._players, this.teamCity);

  String getTeamName(){
    return this._teamName;
  }

  List<User> getTeamPlayers(){
    return this._players;
  }

  String getTeamCity(){
    return this.teamCity;
  }

}
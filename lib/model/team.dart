
import 'dart:convert';

import 'package:CricScore/model/player.dart';
import 'package:CricScore/model/user.dart';

class Team {

  String teamName;
  String teamCity;
  //List<User> players;
  Map<String, Player> players;

  Team({this.teamName, this.teamCity, this.players});

  factory Team.fromJson(Map<dynamic, dynamic> json) {
    return Team(
      teamCity: json['teamCity'],
      teamName: json['teamName'],

      players: (json['players'] as Map<dynamic, dynamic>)?.map(
            (k, e) => MapEntry(
            k, e == null ? null : Player.fromJson(e as Map<dynamic, dynamic>)),
      ),

      //players: json['players'] != null ? (json['players'] as List).map((i) => Player.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamCity'] = this.teamCity.trim();
    data['teamName'] = this.teamName.trim();

    if (this.players != null) {
      data['players'] = toMapJson();
    }

    return data;
  }

  Map<String, dynamic> toMapJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.players.forEach((k, v) => data[k] = this.players[k].toJson());
    return data;
  }

  void setTeamName(String teamName){
    this.teamName = teamName.trim();
  }

  void setTeamCity(String teamCity){
    this.teamCity = teamCity;
  }

  void setTeamPlayers(Map<String, Player> players){
    this.players = players;
  }

  String getTeamName(){
    return this.teamName.trim();
  }

  Map<String, Player> getTeamPlayers(){
    return this.players;
  }

  String getTeamCity(){
    return this.teamCity;
  }

}
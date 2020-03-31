
import 'dart:convert';

import 'package:flutter_app/model/user.dart';

class Team {

  String teamName;
  String teamCity;
  List<User> players;

  Team({this.teamName, this.teamCity, this.players});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamCity: json['teamCity'],
      teamName: json['teamName'],
      players: json['players'] != null ? (json['players'] as List).map((i) => User.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamCity'] = this.teamCity;
    data['teamName'] = this.teamName;
    if (this.players != null) {
      data['players'] = this.players.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void setTeamName(String teamName){
    this.teamName = teamName;
  }

  void setTeamCity(String teamCity){
    this.teamCity = teamCity;
  }

  void setTeamPlayers(List<User> players){
    this.players = players;
  }

  String getTeamName(){
    return this.teamName;
  }

  List<User> getTeamPlayers(){
    return this.players;
  }

  String getTeamCity(){
    return this.teamCity;
  }

}
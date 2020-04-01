
import 'dart:convert';
import 'dart:core';

import 'package:flutter_app/model/team.dart';

class Match {

  String matchVenue;
  String matchBetween;
  Map<String, Team> teams = new Map();
  int totalOvers;
  String tossWonTeam;
  String selectedInning;

  Match({this.matchVenue, this.matchBetween, this.teams});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      matchBetween: json['matchBetween'],
      matchVenue: json['match_Venue'],
      teams: (json['teams'] as Map<String, dynamic>)?.map(
            (k, e) => MapEntry(
            k, e == null ? null : Team.fromJson(e as Map<String, dynamic>)),
      ),
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchBetween'] = this.matchBetween;
    data['match_Venue'] = this.matchVenue;
    if (this.teams != null) {
      data['teams'] = toMapJson();
    }
    return data;
  }

  Map<String, dynamic> toMapJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.teams.forEach((k, v) => data[k] = this.teams[k].toJson());
    return data;
  }

  void setMatchVenue(String matchVenue) {
    this.matchVenue = matchVenue;
  }

  void setMatchTitle(String matchTitle) {
    this.matchBetween = matchTitle;
  }

  String getMatchTitle() {
    return this.matchBetween;
  }

  String getMatchVenue() {
    return this.matchVenue;
  }

  void addTeam(String teamName, Team team){
    if(this.teams == null){
      Map<String, Team> map = new Map();
      map.putIfAbsent(teamName, () => team);
      this.teams = map;
    }
    teams.update(teamName, (value) => team, ifAbsent: () => team);
  }

  List<Team> getTeams(){
    List<Team> teams = List();
    this.teams.forEach((key, value) {
      teams.add(value);
    });
    return teams;
  }

  void setTotalOvers(int totalOvers){
    this.totalOvers = totalOvers;
  }

  int getTTotalOvers(){
    return this.totalOvers;
  }

  void setWonTossTeam(String teamName){
    this.tossWonTeam = teamName;
  }

  Team getTossWonTeam() {
    return this.teams[this.tossWonTeam];
  }

  void setSelectedInnings(String inning){
    this.selectedInning = inning;
  }

  String getTeamSelectedInnings(){
    return this.selectedInning;
  }

}


import 'dart:core';

import 'package:flutter_app/model/innings.dart';
import 'package:flutter_app/model/team.dart';

import 'appStaticBarTitles.dart';

class MatchGame {

  Map<String, Team> teams = new Map();
  String matchVenue;
  String matchBetween;
  int totalOvers;
  String tossWonTeam;
  String selectedInning;
  bool isFirstInningsOver;
  int totalScore;
  Inning firstInning;
  Inning secondInning;
  Inning currentPlayers;

  MatchGame({this.matchVenue, this.matchBetween, this.teams, this.totalOvers, this.tossWonTeam, this.selectedInning, this.isFirstInningsOver
    ,this.totalScore, this.firstInning, this.secondInning, this.currentPlayers});

  factory MatchGame.fromJson(Map<String, dynamic> json) {
    return MatchGame(
      matchBetween: json['matchBetween'],
      matchVenue: json['match_Venue'],
      teams: (json['teams'] as Map<String, dynamic>)?.map(
            (k, e) => MapEntry(
            k, e == null ? null : Team.fromJson(e as Map<String, dynamic>)),
      ),
      totalOvers: json['totalOvers'],
      tossWonTeam: json['tossWonTeam'],
      selectedInning : json['selectedInning'],
      isFirstInningsOver : json['isFirstInningsOver'],
      totalScore : json['totalScore'],
      firstInning : (json['firstInning'] != null) ? Inning.fromJson(json['firstInning']) : null,
      secondInning: (json['secondInning'] != null) ? Inning.fromJson(json['secondInning']) : null,
      currentPlayers: (json['currentPlayers'] != null) ? Inning.fromJson(json['currentPlayers']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchVenue'] = this.matchVenue;
    data['matchBetween'] = this.matchBetween;
    data['totalOvers'] = this.totalOvers;
    data['tossWonTeam'] = this.tossWonTeam;
    data['selectedInning'] = this.selectedInning;
    data['isFirstInningsOver'] = this.isFirstInningsOver;
    data['totalScore'] = this.totalScore;
    if (this.teams != null) {
      data['teams'] = toMapJson();
    }
    if (this.firstInning != null) {
      data['firstInnings'] = this.firstInning.toJson();
    }
    if (this.secondInning != null) {
      data['secondInnings'] = this.secondInning.toJson();
    }
    if(this.currentPlayers != null){
      data['currentPlayers'] = this.currentPlayers.toJson();
    }
    return data;
  }


  void setInning(){
    Inning inning1 = new Inning();
    Inning inning2 = new Inning();

    teams.forEach((key, value) {
      if(key == tossWonTeam){
        if(selectedInning == StaticString.BATTING_INNING) {
          inning1.setBattingInning(value.players);
          inning2.setBowlingInning(value.players);
        }else{
          inning1.setBowlingInning(value.players);
          inning2.setBattingInning(value.players);
        }
      }else{
        if(selectedInning == StaticString.BATTING_INNING) {
          inning2.setBattingInning(value.players);
          inning1.setBowlingInning(value.players);
        }else{
          inning2.setBowlingInning(value.players);
          inning1.setBattingInning(value.players);
        }
      }
    });
    firstInning = inning1;
    secondInning = inning2;

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

  void setIsFirstInningsOver(bool isFirstInnignsOver){
    this.isFirstInningsOver = isFirstInnignsOver;
  }

  bool getisFirstInningsOver(){
    return isFirstInningsOver;
  }
}

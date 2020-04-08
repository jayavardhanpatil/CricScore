
import 'dart:core';
import 'package:flutter_app/model/innings.dart';
import 'package:flutter_app/model/team.dart';

import 'appStaticBarTitles.dart';
import 'currentPlayer.dart';

class MatchGame {

  Map<dynamic, Team> teams = new Map();
  String matchVenue;
  String matchBetween;
  int totalOvers;
  String tossWonTeam;
  String selectedInning;
  bool isFirstInningsOver;
  int totalScore;
  Inning firstInning;
  Inning secondInning;
  CurrentPlayIng currentPlayers;
  bool isLive;
  String result;
  int target;

  MatchGame({this.matchVenue, this.matchBetween, this.teams, this.totalOvers, this.tossWonTeam, this.selectedInning, this.isFirstInningsOver
    ,this.totalScore, this.firstInning, this.secondInning, this.currentPlayers, this.isLive = true, this.result, this.target});

  factory MatchGame.fromJson(Map<dynamic, dynamic> json) {
    return MatchGame(
      matchBetween: json['matchBetween'],
      matchVenue: json['matchVenue'],
//      teams: (json['teams'] as Map<String, dynamic>)?.map(
//            (k, e) => MapEntry(
//            k, e == null ? null : Team.fromJson(e as Map<String, dynamic>)),
//      ),
      totalOvers: json['totalOvers'],
      tossWonTeam: json['tossWonTeam'],
      selectedInning : json['selectematchVenuedInning'],
      isFirstInningsOver : json['isFirstInningsOver'],
      totalScore : json['totalScore'],
      firstInning : (json['firstInnings'] != null) ? Inning.fromJson(json['firstInnings']) : null,
      secondInning: (json['secondInnings'] != null) ? Inning.fromJson(json['secondInnings']) : null,
      currentPlayers: (json['currentPlayers'] != null) ? CurrentPlayIng.fromJson(json['currentPlayers']) : null,
      isLive: (json['isLive']),
        result : (json['result']),
      target: (json['target']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['matchVenue'] = this.matchVenue;
    data['matchBetween'] = this.matchBetween;
    data['totalOvers'] = this.totalOvers;
    data['tossWonTeam'] = this.tossWonTeam;
    data['selectedInning'] = this.selectedInning;
    data['isFirstInningsOver'] = this.isFirstInningsOver;
    data['totalScore'] = this.totalScore;
//    if (this.teams != null) {
//      data['teams'] = toMapJson();
//    }
    if (this.firstInning != null) {
      data['firstInnings'] = this.firstInning.toJson();
    }
    if (this.secondInning != null) {
      data['secondInnings'] = this.secondInning.toJson();
    }
    if(this.currentPlayers != null){
      data['currentPlayers'] = this.currentPlayers.toJson();
    }
    data['isLive'] = this.isLive;

    data['result'] = this.result;
    data['target'] = this.target;
    return data;
  }


  void setInning(){
    Inning inning1 = new Inning();
    Inning inning2 = new Inning();

    teams.forEach((key, value) {
      if(key == tossWonTeam){
        if(selectedInning == StaticString.BATTING_INNING) {
          inning1.setBattingInning(value);
          inning2.setBowlingInning(value);
        }else{
          inning1.setBowlingInning(value);
          inning2.setBattingInning(value);
        }
      }else{
        if(selectedInning == StaticString.BATTING_INNING) {
          inning2.setBattingInning(value);
          inning1.setBowlingInning(value);
        }else{
          inning2.setBowlingInning(value);
          inning1.setBattingInning(value);
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

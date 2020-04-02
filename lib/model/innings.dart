

import 'package:flutter_app/model/player.dart';

class Inning{

  int run;
  int wickets;
  int overs;
  int extra;
  Map<String, Player> battingTeam;
  Map<String, Player> bowlingTeam;

  Inning(
      {this.run,
        this.wickets,
        this.overs,
        this.extra,
        this.battingTeam,
        this.bowlingTeam});

  Inning.fromJson(Map<String, dynamic> json) {
    run = json['run'];
    wickets = json['wickets'];
    overs = json['overs'];
    extra = json['extra'];

    battingTeam = (json['batting'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)),
    );

    bowlingTeam = (json['bowling'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)),
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['run'] = this.run;
    data['wickets'] = this.wickets;
    data['overs'] = this.overs;
    data['extra'] = this.extra;
    if (this.battingTeam != null) {
      data['batting'] = toMapBattingJson();
    }
    if (this.bowlingTeam != null) {
      data['bowling'] = toMapBowlingJson();
    }
    return data;
  }

  Map<String, dynamic> toMapBattingJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.battingTeam.forEach((k, v) => data[k] = this.battingTeam[k].toJson());
    return data;
  }

  Map<String, dynamic> toMapBowlingJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.bowlingTeam.forEach((k, v) => data[k] = this.bowlingTeam[k].toJson());
    return data;
  }

  void setBattingInning(Map<String, Player> battingteam){
    this.battingTeam = battingteam;
  }

  void setBowlingInning(Map<String, Player>bowlingTeam){
    this.bowlingTeam = bowlingTeam;
  }

}
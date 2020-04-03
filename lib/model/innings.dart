

import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/model/team.dart';

class Inning{

  int run;
  int wickets;
  double overs;
  int extra;
  Team battingteam;
  Team bowlingteam;
  Map<String, Player> battingTeamPlayer;
  Map<String, Player> bowlingTeamPlayer;

  Inning(
      {this.run,
        this.wickets,
        this.overs,
        this.extra,
        this.battingteam,
        this.bowlingteam,
      this.battingTeamPlayer,
      this.bowlingTeamPlayer});

  Inning.fromJson(Map<String, dynamic> json) {
    run = json['run'];
    wickets = json['wickets'];
    overs = json['overs'];
    extra = json['extra'];
   // battingteam = (json['battingteam'] != null) ? Team.fromJson(json['battingteam']) : null;
   // bowlingteam = (json['bowlingteam'] != null) ? Team.fromJson(json['bowlingteam']) : null;
    battingTeamPlayer = (json['batting'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)),
    );

    bowlingTeamPlayer = (json['bowling'] as Map<String, dynamic>)?.map(
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
  //  if (this.battingteam != null) {
  //    data['battingteam'] = this.battingteam.toJson();
  //  }
  //  if (this.bowlingteam != null) {
  //    data['bowlingteam'] = this.bowlingteam.toJson();
  //  }

    if (this.battingTeamPlayer != null) {
      data['batting'] = toMapBattingJson();
    }
    if (this.bowlingTeamPlayer != null) {
      data['bowling'] = toMapBowlingJson();
    }
    return data;
  }

  Map<String, dynamic> toMapBattingJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.battingTeamPlayer.forEach((k, v) => data[k] = this.battingTeamPlayer[k].toJson());
    return data;
  }

  Map<String, dynamic> toMapBowlingJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.bowlingTeamPlayer.forEach((k, v) => data[k] = this.bowlingTeamPlayer[k].toJson());
    return data;
  }

  void setBattingInning(Team battingteam){
    this.battingteam = battingteam;
  }
//
  void setBowlingInning(Team bowlingTeam){
    this.bowlingteam = bowlingTeam;
  }

  void setBattingInningPlayers(Map<String, Player> battingteam){
    this.battingTeamPlayer = battingteam;
  }
//
  void setBowlingInningPlayers(Map<String, Player> bowlingTeam){
    this.bowlingTeamPlayer = bowlingTeam;
  }

}
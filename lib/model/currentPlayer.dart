
import 'package:CricScore/model/player.dart';

class CurrentPlayIng {

  int run;
  int wickets;
  var overs;
  int extra;
  String teamName;
  Map<String, Player> battingTeamPlayer;
  Map<String, Player> bowlingTeamPlayer;

  CurrentPlayIng(
      {this.run = 0,
        this.wickets = 0,
        this.overs = 0.0,
        this.extra = 0,
        this.battingTeamPlayer,
        this.bowlingTeamPlayer,
        this.teamName,
      });

  CurrentPlayIng.fromJson(Map<dynamic, dynamic> json) {
    run = json['run'];
    wickets = json['wickets'];
    overs = json['overs'];
    extra = json['extra'];
    teamName = json['teamName'];
//    battingteam = (json['batting_team'] != null) ? Team.fromJson(json['batting_team']) : null;
//    bowlingteam = (json['bowling_team'] != null) ? Team.fromJson(json['bowling_team']) : null;
    battingTeamPlayer = (json['batting'] as Map<dynamic, dynamic>)?.map(
          (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<dynamic, dynamic>)),
    );

    bowlingTeamPlayer = (json['bowling'] as Map<dynamic, dynamic>)?.map(
          (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<dynamic, dynamic>)),
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['run'] = this.run;
    data['wickets'] = this.wickets;
    data['overs'] = this.overs;
    data['extra'] = this.extra;
    data['teamName'] = this.teamName;
//    if (this.battingteam != null) {
//      data['batting_team'] = this.battingteam.toJson();
//    }
//    if (this.bowlingteam != null) {
//      data['bowling_team'] = this.bowlingteam.toJson();
//    }

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

  void setBattingInningPlayers(Map<String, Player> battingteam){
    this.battingTeamPlayer = battingteam;
  }

  void setBowlingInningPlayers(Map<String, Player> bowlingTeam){
    this.bowlingTeamPlayer = bowlingTeam;
  }


}
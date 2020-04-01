class Player {
  String playerUID;
  String playerName;
  bool isOnStrike;
  int run;
  int wicket;
  int extra;
  double overs;

  Player(
      {this.playerUID,
        this.playerName,
        this.isOnStrike,
        this.run,
        this.wicket,
        this.extra,
        this.overs});

  Player.fromJson(Map<String, dynamic> json) {
    playerUID = json['playerUID'];
    playerName = json['playerName'];
    isOnStrike = json['isOnStrike'];
    run = json['run'];
    wicket = json['wicket'];
    extra = json['extra'];
    overs = json['overs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playerUID'] = this.playerUID;
    data['playerName'] = this.playerName;
    data['isOnStrike'] = this.isOnStrike;
    data['run'] = this.run;
    data['wicket'] = this.wicket;
    data['extra'] = this.extra;
    data['overs'] = this.overs;
    return data;
  }
}
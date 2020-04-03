class Player {
  String playerUID;
  String playerName;
  bool isOnStrike;
  int run;
  int wicket;
  int extra;
  double overs;
  int ballsFaced;
  int runsGiven;
  int numberOfFours;
  int numberOfsixes;
  int centuries;
  int fifties;


  Player(
      {this.playerUID,
        this.playerName,
        this.isOnStrike,
        this.run,
        this.wicket,
        this.extra,
        this.overs,this.ballsFaced,
      this.runsGiven,
      this.centuries,
      this.fifties,
      this.numberOfFours,
      this.numberOfsixes});

  Player.fromJson(Map<String, dynamic> json) {
    playerUID = json['playerUID'];
    playerName = json['playerName'];
    isOnStrike = json['isOnStrike'];
    run = json['run'];
    wicket = json['wicket'];
    extra = json['extra'];
    overs = json['overs'];
    ballsFaced = json['ballsFaced'];
    runsGiven = json['runsGiven'];
    centuries = json['centuries'];
    fifties = json['fifties'];
    numberOfFours = json['numberOfFours'];
    numberOfsixes = json['numberOfsixes'];
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
    data['ballsFaced'] = this.ballsFaced;
    data['runsGiven'] = this.runsGiven;
    data['centuries'] = this.centuries;
    data['fifties'] = this.fifties;
    data['numberOfFours'] = this.numberOfFours;
    data['numberOfsixes'] = this.numberOfsixes;

    return data;
  }
}
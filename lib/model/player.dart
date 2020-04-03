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
  int playedPosition;
  bool isOut;


  Player(
      {this.playerUID,
        this.playerName,
        this.isOnStrike = false,
        this.run = 0,
        this.wicket = 0,
        this.extra = 0,
        this.overs = 0,
        this.ballsFaced = 0,
      this.runsGiven = 0,
      this.centuries,
      this.fifties,
      this.numberOfFours,
      this.numberOfsixes,
      this.playedPosition,
      this.isOut = false});

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
    playedPosition = json['playedPosition'];
    isOut = json['isOut'];
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
    data['isOut'] = this.isOut;
    return data;
  }
}
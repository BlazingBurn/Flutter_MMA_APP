class FighterEventModel {
  int fighterId;
  String firstName;
  String lastName;
  int preFightWins;
  int preFightLosses;
  int preFightDraws;
  int preFightNoContests;
  bool winner;
  int moneyline;
  bool active;

  FighterEventModel({
    required this.fighterId,
    required this.firstName,
    required this.lastName,
    required this.preFightWins,
    required this.preFightLosses,
    required this.preFightDraws,
    required this.preFightNoContests,
    required this.winner,
    required this.moneyline,
    required this.active,
  });

  factory FighterEventModel.fromJson(Map<String, dynamic> json) {
    return FighterEventModel(
      fighterId: json['FighterId'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      preFightWins: json['PreFightWins'],
      preFightLosses: json['PreFightLosses'],
      preFightDraws: json['PreFightDraws'],
      preFightNoContests: json['PreFightNoContests'],
      winner: json['Winner'],
      moneyline: json['Moneyline'],
      active: json['Active'],
    );
  }
}
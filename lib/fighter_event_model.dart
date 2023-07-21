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
      fighterId: json['FighterId'] ?? 0,
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      preFightWins: json['PreFightWins'] ?? 0,
      preFightLosses: json['PreFightLosses'] ?? 0,
      preFightDraws: json['PreFightDraws'] ?? 0,
      preFightNoContests: json['PreFightNoContests'] ?? 0,
      winner: json['Winner'] ?? false,
      moneyline: json['Moneyline'] ?? 0,
      active: json['Active'] ?? false,
    );
  }
}
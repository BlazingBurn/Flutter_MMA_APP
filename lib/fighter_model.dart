import 'career_model.dart';

class FighterModel {
  int fighterId;
  String firstName;
  String lastName;
  String nickName;
  String weightClass;
  String birthdate;
  double height;
  double weight;
  double reach;
  int wins;
  int losses;
  int draws;
  int noContests;
  int technicalKnockouts;
  int technicalKnockoutsLosses;
  int submissions;
  int submissionsLosses;
  int titleWins;
  int titleLosses;
  int titleDraw;
  CareerModel stats;

  FighterModel({
    required this.fighterId,
    required this.firstName,
    required this.lastName,
    required this.nickName,
    required this.weightClass,
    required this.birthdate,
    required this.height,
    required this.weight,
    required this.reach,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.noContests,
    required this.technicalKnockouts,
    required this.technicalKnockoutsLosses,
    required this.submissions,
    required this.submissionsLosses,
    required this.titleWins,
    required this.titleLosses,
    required this.titleDraw,
    required this.stats
    }
  );

  static FighterModel fromJson(Map<String, dynamic> json) {
    return FighterModel(
      fighterId: json['FighterId'] ?? 0,
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      nickName: json['Nickname'] ?? '',
      weightClass: json['WeightClass'] ?? '',
      birthdate: json['Birthdate'] ?? '',
      height: json['Height'] ?? 0,
      weight: json['Weight'] ?? 0,
      reach: json['Reach'] ?? 0,
      wins: json['Wins'] ?? 0,
      losses: json['Losses'] ?? 0,
      draws: json['Draws'] ?? 0,
      noContests: json['NoContests'] ?? 0,
      technicalKnockouts: json['TechnicalKnockouts'] ?? 0,
      technicalKnockoutsLosses: json['TechnicalKnockoutsLosses'] ?? 0,
      submissions: json['Submissions'] ?? 0,
      submissionsLosses: json['SubmissionsLosses'] ?? 0,
      titleWins: json['TitleWins'] ?? 0,
      titleLosses: json['TitleLosses'] ?? 0,
      titleDraw: json['TitleDraw'] ?? 0,
      stats: CareerModel.fromJson(json['CareerStats'] ?? {}),
    );
  }
}
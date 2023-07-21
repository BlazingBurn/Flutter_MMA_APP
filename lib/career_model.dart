class CareerModel {
  int fighterId;
  String firstName;
  String lastName;
  double sigStrikesLandedPerMinute;
  double sigStrikeAccuracy;
  double takedownAverage;
  double submissionAverage;
  double knockoutPercentage;
  double technicalKnockoutPercentage;
  double decisionPercentage;


  CareerModel({
    required this.fighterId,
    required this.firstName,
    required this.lastName,
    required this.sigStrikesLandedPerMinute,
    required this.sigStrikeAccuracy,
    required this.takedownAverage,
    required this.submissionAverage,
    required this.knockoutPercentage,
    required this.technicalKnockoutPercentage,
    required this.decisionPercentage,
  }
      );

  static CareerModel fromJson(Map<String, dynamic> json) {
    return CareerModel(
      fighterId: json['FighterId'] ?? 0,
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      sigStrikesLandedPerMinute: json['SigStrikesLandedPerMinute'] ?? 0,
      sigStrikeAccuracy: json['SigStrikeAccuracy'] ?? 0,
      takedownAverage: json['TakedownAverage'] ?? 0,
      submissionAverage: json['SubmissionAverage'] ?? 0,
      knockoutPercentage: json['KnockoutPercentage'] ?? 0,
      technicalKnockoutPercentage: json['TechnicalKnockoutPercentage'] ?? 0,
      decisionPercentage: json['DecisionPercentage'] ?? 0,
    );
  }
}
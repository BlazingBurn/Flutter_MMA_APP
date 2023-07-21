class FighterModel {
  String firstName;
  String lastName;
  String nickName;
  int wins;
  int losses;
  int draws;

  FighterModel({
    required this.firstName,
    required this.lastName,
    required this.nickName,
    required this.wins,
    required this.losses,
    required this.draws,
    }
  );

  static FighterModel fromJson(Map<String, dynamic> json) {
    return FighterModel(
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      nickName: json['NickName'] ?? '',
      wins: json['Wins'] ?? 0,
      losses: json['Losses'] ?? 0,
      draws: json['Draws'] ?? 0,

    );
  }
}
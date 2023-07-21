import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FighterDetails extends StatefulWidget {
  final String fighterId;

  const FighterDetails({super.key, required this.fighterId});

  @override
  _FighterDetailsState createState() => _FighterDetailsState();
}

class _FighterDetailsState extends State<FighterDetails> {
  late Future<Map<String, dynamic>> fighterDetails;

  @override
  void initState() {
    super.initState();
    fighterDetails = _fetchFighterDetails();
  }

  Future<Map<String, dynamic>> _fetchFighterDetails() async {
    final response = await http.get(
      Uri.parse('https://api.sportsdata.io/v3/mma/scores/json/Fighter/${widget.fighterId}?key=01dc155fc0e9412d9078229fc6d9baea'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load fighter details');
    }
  } 
  

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(
      redirection: "/fighters",
      widget: _fighterDetails()
      );
    }

    // title: Text('Détails du Fighter'),
  Widget _fighterDetails() {
      return FutureBuilder<Map<String, dynamic>>(
        future: fighterDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur : ${snapshot.error}'),
            );
          } else {
            final fighterData = snapshot.data;
            final String firstName = fighterData?['FirstName'] ?? '';
            final String lastName = fighterData?['LastName'] ?? '';
            final String nickname = fighterData?['Nickname'] ?? '';
            final int wins = fighterData?['Wins'] ?? 0;
            final int losses = fighterData?['Losses'] ?? 0;
            final int draws = fighterData?['Draws'] ?? 0;
            final String birthDate = fighterData?['BirthDate'] ?? '';
            final double height = fighterData?['Height'] ?? 0.0;
            final double weight = fighterData?['Weight'] ?? 0.0;
            final String weightClass = fighterData?['WeightClass'] ?? '';
            final int technicalKnockouts = fighterData?['TechnicalKnockouts'] ?? 0;
            final int technicalKnockoutLosses = fighterData?['TechnicalKnockoutLosses'] ?? 0;
            final int submissions = fighterData?['Submissions'] ?? 0;
            final int submissionLosses = fighterData?['SubmissionLosses'] ?? 0;
            final int titleWins = fighterData?['TitleWins'] ?? 0;
            final int titleLosses = fighterData?['TitleLosses'] ?? 0;
            final int titleDraws = fighterData?['TitleDraws'] ?? 0;
            final double sigStrikesLandedPerMinute = fighterData?['SigStrikesLandedPerMinute'] ?? 0.0;
            final double sigStrikeAccuracy = fighterData?['SigStrikeAccuracy'] ?? 0.0;
            final double takedownAverage = fighterData?['TakedownAverage'] ?? 0.0;
            final double submissionAverage = fighterData?['SubmissionAverage'] ?? 0.0;
            final double knockoutPercentage = fighterData?['KnockoutPercentage'] ?? 0.0;
            final double technicalKnockoutPercentage = fighterData?['TechnicalKnockoutPercentage'] ?? 0.0;
            final double decisionPercentage = fighterData?['DecisionPercentage'] ?? 0.0;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text('FirstName: $firstName'),
                  const SizedBox(height: 10),
                  Text('LastName: $lastName'),
                  const SizedBox(height: 10),
                  Text('Nickname: $nickname'),
                  const SizedBox(height: 10),
                  Text('Wins: $wins'),
                  const SizedBox(height: 10),
                  Text('Losses: $losses'),
                  const SizedBox(height: 10),
                  Text('Draws: $draws'),
                  const SizedBox(height: 10),
                  Text('BirthDate: $birthDate'),
                  const SizedBox(height: 10),
                  Text('Height: $height'),
                  const SizedBox(height: 10),
                  Text('Weight: $weight'),
                  const SizedBox(height: 10),
                  Text('WeightClass: $weightClass'),
                  const SizedBox(height: 10),
                  Text('TechnicalKnockouts: $technicalKnockouts'),
                  const SizedBox(height: 10),
                  Text('TechnicalKnockoutLosses: $technicalKnockoutLosses'),
                  const SizedBox(height: 10),
                  Text('Submissions: $submissions'),
                  const SizedBox(height: 10),
                  Text('SubmissionLosses: $submissionLosses'),
                  const SizedBox(height: 10),
                  Text('TitleWins: $titleWins'),
                  const SizedBox(height: 10),
                  Text('TitleLosses: $titleLosses'),
                  const SizedBox(height: 10),
                  Text('TitleDraws: $titleDraws'),
                  const SizedBox(height: 10),
                  Text('SigStrikesLandedPerMinute: $sigStrikesLandedPerMinute'),
                  const SizedBox(height: 10),
                  Text('SigStrikeAccuracy: $sigStrikeAccuracy'),
                  const SizedBox(height: 10),
                  Text('TakedownAverage: $takedownAverage'),
                  const SizedBox(height: 10),
                  Text('SubmissionAverage: $submissionAverage'),
                  const SizedBox(height: 10),
                  Text('KnockoutPercentage: $knockoutPercentage'),
                  const SizedBox(height: 10),
                  Text('TechnicalKnockoutPercentage: $technicalKnockoutPercentage'),
                  const SizedBox(height: 10),
                  Text('DecisionPercentage: $decisionPercentage'),
                  const SizedBox(height: 20),
                
                ],
              ),
            );
          }
        },
      );
  }
}

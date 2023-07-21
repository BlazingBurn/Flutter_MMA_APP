import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

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

  String formatDateTime(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('EEE MMM d y').format(dateTime);
    
  }

  Future<Map<String, dynamic>> _fetchFighterDetails() async {
    final response = await http.get(
      Uri.parse(
          'https://api.sportsdata.io/v3/mma/scores/json/Fighter/${widget.fighterId}?key=01dc155fc0e9412d9078229fc6d9baea'),
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
      widget: _fighterDetails(),
    );
  }

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
          final double sigStrikesLandedPerMinute = fighterData?['CareerStats']?['SigStrikesLandedPerMinute'] ?? 0.0;
          final double sigStrikeAccuracy = fighterData?['CareerStats']?['SigStrikeAccuracy'] ?? 0.0;
          final double takedownAverage = fighterData?['CareerStats']?['TakedownAverage'] ?? 0.0;
          final double submissionAverage = fighterData?['CareerStats']?['SubmissionAverage'] ?? 0.0;
          final double knockoutPercentage = fighterData?['CareerStats']?['KnockoutPercentage'] ?? 0.0;
          final double technicalKnockoutPercentage = fighterData?['CareerStats']?['TechnicalKnockoutPercentage'] ?? 0.0;
          final double decisionPercentage = fighterData?['CareerStats']?['DecisionPercentage'] ?? 0.0;

          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sports_mma, // Icône de gant de boxe
                          color: Color.fromARGB(255, 198, 33, 21),
                          size: 45),
                      Text(
                        'Détails du fighter', // En-tête "Détails du fighter"
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 190, 27, 27),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/marc.png', // Image "ali.png"
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 20),
               Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Row(
    children: [
      Expanded(
        child: Center(
          child: Text(
            'First name : $firstName',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: Text(
            'Last name : $lastName',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ],
  ),
),
const SizedBox(height: 10),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Row(
    children: [
      Expanded(
        child: Center(
          child: Text(
            'Nickname : $nickname',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromARGB(255, 188, 49, 40),
            ),
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: Text(
            'Birth date : ${formatDateTime(birthDate)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ],
  ),
),

                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Wins: $wins',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Losses: $losses',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Draws: $draws',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Height: $height',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Weight: $weight',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Weight class: $weightClass',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(),
                ),
                const SizedBox(
                  height: 10,
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Techn. KO: $technicalKnockouts',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Techn. KO Losses: $technicalKnockoutLosses',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10), // Ajout du padding horizontal
                          child: Text(
                            'Submissions: $submissions',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8), // Ajout du padding horizontal
                          child: Text(
                            'Submissions Losses: $submissionLosses',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                _buildCircleData('Title Wins ', titleWins as double),
                _buildCircleData('Title Losses ', titleLosses as double),
                _buildCircleData('Title Draws ', titleDraws as double),
                _buildCircleData('Strikes landed/mn ', sigStrikesLandedPerMinute),
                _buildCircleData('Strike accuracy ', sigStrikeAccuracy),
                _buildCircleData('Takedown average ', takedownAverage),
                _buildCircleData('Submission average ', submissionAverage),
                _buildCircleData('Knockout % ', knockoutPercentage),
                _buildCircleData('Techn. KO % ', technicalKnockoutPercentage),
                _buildCircleData('Decision % ', decisionPercentage),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildCircleData(String title, double value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            // Centrer les textes horizontalement
            child: Text(
              '$title:',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16), // Agrandir la taille du texte
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getColor(value),
            ),
            alignment: Alignment.center,
            child: Text(
              value == 0 ? '-' : value.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14), // Agrandir la taille du texte
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(double value) {
    if (value == 0) {
      return const Color.fromARGB(255, 162, 157, 157);
    } else if (value <= 40) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}

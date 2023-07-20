import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fighterSearch.dart';

class Fighters extends StatefulWidget {
  const Fighters({super.key});

  @override
  State<Fighters> createState() => _MyFightersState();
}

class _MyFightersState extends State<Fighters> {
  late Future<List<dynamic>> fightersList;
  late Future<List<dynamic>> fightersListOrigin;

  @override
  void initState() {
    super.initState();
    fightersListOrigin = _fetchEventData();
    fightersList = fightersListOrigin;
  }

  Future<List<dynamic>> _fetchEventData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.sportsdata.io/v3/mma/scores/json/Fighters?key=01dc155fc0e9412d9078229fc6d9baea'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(
      redirection: "/",
      widget: Column(
        children: [
          FighterSearch(onFilter: _filterFightersList),
          Expanded(child: _fightersList()),
        ],
      ),
    );
  }

  Widget _fightersList() {
    return FutureBuilder<List<dynamic>>(
      future: fightersList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final fightersData = snapshot.data;
          return Column( children: [
            const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sports_mma,
                        color: Color.fromARGB(255, 198, 33, 21), size: 50),
                    // Icône de gant de boxe
                    SizedBox(width: 8),
                    Text(
                      'Fighters', // En-tête "Fighters"
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 190, 27, 27),
                      ),
                    ),
                  ],
                ),
              ),

        Expanded(child:
            ListView.builder(
            itemCount: fightersData?.length ?? 0,
            itemBuilder: (context, index) {
              final fighters = fightersData?[index];
              final String? fighterFirstName = fighters['FirstName'] as String?;
              final String? fighterLastName = fighters['LastName'] as String?;
              final String? fighterNickName = fighters['Nickname'] as String?;
              final int fighterWins = fighters['Wins'] as int? ?? 0;
              final int fighterLosses = fighters['Losses'] as int? ?? 0;
              final int fighterDraws = fighters['Draws'] as int? ?? 0;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Center(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/ali.webp',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    '${fighterFirstName ?? '-'} ${fighterLastName ?? '-'}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Center(
                                  child: Text(
                                    fighterNickName ?? '',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 190, 27, 27),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Wins: $fighterWins | Losses: $fighterLosses | Draws: $fighterDraws',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
         ], );
      }
      },
    );
  }

void _filterFightersList(String query) {
  if (query.isEmpty) {
    setState(() {
      fightersList = fightersListOrigin;
    });
  } else {
    setState(() {
      fightersList = fightersListOrigin.then((fightersData) => fightersData
          .where((fighter) {
            final String? firstName = fighter['FirstName'] as String?;
            final String? lastName = fighter['LastName'] as String?;
            final String? nickName = fighter['Nickname'] as String?;

            return (firstName != null && firstName.toLowerCase().contains(query.toLowerCase())) ||
                (lastName != null && lastName.toLowerCase().contains(query.toLowerCase())) ||
                (nickName != null && nickName.toLowerCase().contains(query.toLowerCase()));
          })
          .toList());
    });
  }
}
}
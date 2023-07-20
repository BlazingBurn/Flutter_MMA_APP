import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Fighters extends StatelessWidget {

  const Fighters({super.key});

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
    return ScaffoldGeneral(redirection: "/", widget: _fightersTest());

  }

  Widget _fighters() {
    return const Center(
      child: Text("Fighters"),
    );
  }

  Widget _fightersTest() {
    return FutureBuilder<List<dynamic>>(
      future: _fetchEventData(),
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
          return ListView.builder(
            itemCount: fightersData?.length ?? 0,
            itemBuilder: (context, index) {
              final fighters = fightersData?[index];
              final int fighterId = fighters['FighterId'];
              final String fighterFirstName = fighters['FirstName'];
              // final String fighterLastName = fighters['LastName'];
              // final String fighterNickName = fighters['NickName'];
              // final String fighterWins = fighters['Wins'];
              // final String fighterLosses = fighters['Losses'];
              // final String fighterDraws = fighters['Draws'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(fighterId.toString()),
                    subtitle: Text('FighterFistName: $fighterFirstName'),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }


}
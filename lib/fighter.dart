import 'package:flutter/material.dart';

class Fighter extends StatelessWidget {

  const Fighter({super.key, required this.fighterId});

  final String fighterId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UFC STATS',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('UFC STATS'), // Titre de l'AppBar
            centerTitle: true, // Centrer le titre de l'AppBar
          ),
          body: Center(
            child:
              Text("fighterId : $fighterId"),
          )
      ),
    );
  }

}
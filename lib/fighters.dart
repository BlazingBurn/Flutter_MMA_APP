import 'package:flutter/material.dart';

class Fighters extends StatelessWidget {

  const Fighters({super.key});

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
              body: const Center(
                child:
                  Text("Fighters"),
              )
      ),
    );
  }

}
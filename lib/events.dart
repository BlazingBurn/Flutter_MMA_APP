import 'package:flutter/material.dart';

class Events extends StatelessWidget {

  const Events({super.key});

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
              Text("Events"),
          )
      ),
    );
  }

}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UFC Stats', // Titre de l'application
      theme: ThemeData(
        primarySwatch: Colors.red, // Modifier la couleur en rouge
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UFC Stats'), // Titre de l'AppBar
          centerTitle: true, // Centrer le titre de l'AppBar
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ), // Charger l'image depuis le dossier local
              const SizedBox(height: 5), // Espacement entre l'image et le titre
              const Text(
                "Les meilleures stats de l'UFC :",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0), // Modifier la couleur en rouge
                ),
              ),
              const SizedBox(height: 32), // Espacement entre le titre et les boutons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Naviguer vers l'écran des combattants
                    }, // Bouton "Fighters"
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50), // Taille minimale du bouton
                    ),
                    child: const Text('Fighters'),
                  ),
                  const SizedBox(width: 16), // Espacement horizontal entre les boutons
                  ElevatedButton(
                    onPressed: () {
                      // Naviguer vers l'écran des événements
                    }, // Bouton "Evenements"
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50), // Taille minimale du bouton
                    ),
                    child: const Text('Evenements'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UFC STATS', // Titre de l'application
      theme: ThemeData(
        primarySwatch: Colors.red, // Modifier la couleur en rouge
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UFC STATS'), // Titre de l'AppBar
          centerTitle: true, // Centrer le titre de l'AppBar
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/Ciryl-Gane-UFC.png', // Chemin de l'image
              fit: BoxFit.cover, // Ajuster la taille de l'image pour couvrir toute la largeur
            ),
            const SizedBox(height: 120), // Espacement entre l'image et le reste en bas
            Image.asset(
              'assets/images/logo.png',
              width: 100,
              height: 100,
            ), // Charger l'image depuis le dossier local
            const SizedBox(height: 32), // Espacement entre l'image et le titre
            const Center(
              child: Text(
                "Les meilleures stats de l'UFC",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0), // Modifier la couleur en rouge
                ),
              ),
            ),
            const SizedBox(height: 32), // Espacement entre le titre et les boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Naviguer vers l'écran des combattants
                  },
                  icon: const Icon(Icons.sports_mma), 
                  label: const Text('Fighters'), // Texte du bouton "Fighters"
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50), // Taille minimale du bouton
                  ),
                ),
                const SizedBox(width: 16), // Espacement horizontal entre les boutons
                ElevatedButton.icon(
                  onPressed: () {
                    // Naviguer vers l'écran des événements
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Evenements'), // Texte du bouton "Evenements"
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50), // Taille minimale du bouton
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

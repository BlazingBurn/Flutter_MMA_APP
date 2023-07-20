import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';

class Fighters extends StatelessWidget {
  const Fighters({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(
      redirection: "/",
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_mma, color: const Color.fromARGB(255, 198, 33, 21), size: 50), // Icône de gant de boxe                    
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
          Expanded(
            child: ListView.builder(
              itemCount: fightersList.length,
              itemBuilder: (context, index) {
                // Récupérer les données du combattant actuel
                Map<String, dynamic> fighter = fightersList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 58), // Réduire la taille gauche et droite de la card
                  child: Center(
                    child: Card(
                      elevation: 4, // Rajoute une ombre moderne
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/${fighter['image']}',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      '${fighter['firstName']} ${fighter['lastName']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Center(
                                    child: Text(
                                      '${fighter['nickname']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 190, 27, 27),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Wins: ${fighter['wins']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ' | ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Losses: ${fighter['losses']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ' | ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Draws: ${fighter['draws']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}

// Liste de données fictives pour les combattants
List<Map<String, dynamic>> fightersList = [
  {
    'image': 'ali.webp',
    'firstName': 'Muhammad',
    'lastName': 'Ali',
    'nickname': 'The Greatest',
    'wins': 56,
    'losses': 5,
    'draws': 0,
  },
  // Ajouter d'autres combattants ici
];

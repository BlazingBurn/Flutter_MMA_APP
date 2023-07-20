
import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';

class Fighter extends StatelessWidget {
  const Fighter({super.key, required this.fighterId});

  final String fighterId;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(redirection: "/fighters", widget: _fighter(context));
  }

  Widget _fighter(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width < 600 ? 4 : 8;
    return Center(
      child:
      SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("fighterId : $fighterId"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/mma-fight.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOM',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'PRENOM',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'UN SURNOM',
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Petit texte',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return ProgressBlock(
                  title: 'Titre ${index + 1}',
                  progress:
                  0.5, // Remplacez cette valeur par la progression réelle
                );
              },
            ),
          ],
        ),
      ),
      );
    }

}

class ProgressBlock extends StatelessWidget {
  String title;
  double progress;

  ProgressBlock({super.key, required this.title, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: progress),
        ],
      ),
    );
  }
}
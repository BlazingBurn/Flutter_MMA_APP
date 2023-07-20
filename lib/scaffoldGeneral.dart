import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldGeneral extends StatelessWidget {

  const ScaffoldGeneral({super.key, required this.redirection, required this.widget});

  final Widget widget;
  final String redirection;

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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                GoRouter.of(context).go(redirection); // Retour à la page précédente
              },
            ),
          ),
          body: widget,
          )
    );
  }

}
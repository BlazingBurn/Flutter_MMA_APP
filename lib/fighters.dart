import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';

class Fighters extends StatelessWidget {

  const Fighters({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(redirection: "/", widget: _fighters());

  }

  Widget _fighters() {
      return const Center(
            child: Text("Fighters"),
          );
  }

}
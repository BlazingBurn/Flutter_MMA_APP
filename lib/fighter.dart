import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';

class Fighter extends StatelessWidget {

  const Fighter({super.key, required this.fighterId});

  final String fighterId;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(redirection: "/fighters", widget: _fighter());
  }

  Widget _fighter() {
    return Center(
      child:
        Text("fighterId : $fighterId"),
      );
    }

}
import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';

class Events extends StatelessWidget {

  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(redirection: "/", widget: _events());
  }

  Widget _events() {
    return const Center(
      child:
      Text("Events"),
    );
  }
}

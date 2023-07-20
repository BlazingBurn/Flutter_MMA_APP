import 'package:flutter/material.dart';

class FighterSearch extends StatelessWidget {
  final void Function(String) onFilter;

  FighterSearch({required this.onFilter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            onChanged: onFilter,
            decoration: InputDecoration(
              hintText: "Rechercher un combattant",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

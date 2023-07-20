import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_mma_app/scaffoldGeneral.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  Future<List<dynamic>> _fetchEventData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.sportsdata.io/v3/mma/scores/json/Schedule/UFC/2023?key=ec5838ef36b54cccae0a603380c1544a'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(
      redirection: "/",
      widget: FutureBuilder<List<dynamic>>(
        future: _fetchEventData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final eventData = snapshot.data;
            return ListView.builder(
              itemCount: eventData?.length ?? 0,
              itemBuilder: (context, index) {
                final event = eventData?[index];
                final eventId = event['EventID'];
                final eventName = event['Name'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(eventName),
                      subtitle: Text('EventID: $eventId'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

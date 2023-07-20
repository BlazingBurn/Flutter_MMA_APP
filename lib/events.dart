import 'package:flutter/material.dart';
import 'package:flutter_mma_app/scaffoldGeneral.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<dynamic> eventData = [];
  int? selectedEventId;
  Map<int, List<dynamic>> eventDetailsMap = {};

  @override
  void initState() {
    super.initState();
    _fetchEventData();
  }

  Future<void> _fetchEventData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.sportsdata.io/v3/mma/scores/json/Schedule/UFC/2023?key=ec5838ef36b54cccae0a603380c1544a'),
    );
    if (response.statusCode == 200) {
      setState(() {
        eventData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> _fetchEventDetails(int eventId) async {
    final response = await http.get(
      Uri.parse(
          'https://api.sportsdata.io/v3/mma/scores/json/Event/$eventId?key=ec5838ef36b54cccae0a603380c1544a'),
    );
    if (response.statusCode == 200) {
      final dynamic decodedData = jsonDecode(response.body);
      if (decodedData is List<dynamic>) {
        return decodedData;
      } else if (decodedData is Map<String, dynamic>) {
        // Wrap the map inside a list to match the expected format
        return [decodedData];
      } else {
        print(
            'Invalid data format. Expected List<dynamic> or Map<String, dynamic>, but got ${decodedData.runtimeType}');
        throw Exception('Invalid event details data format');
      }
    } else {
      throw Exception('Failed to load event details');
    }
  }

  String formatDateTime(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('EEE, MMM d, y - h:mm a').format(dateTime);
  }

  void _toggleEventDetails(int eventId) async {
    if (selectedEventId == eventId) {
      setState(() {
        selectedEventId = null;
      });
    } else {
      setState(() {
        selectedEventId = eventId;
      });

      if (!eventDetailsMap.containsKey(eventId)) {
        final eventDetails = await _fetchEventDetails(eventId);
        setState(() {
          eventDetailsMap[eventId] = eventDetails;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneral(redirection: "/", widget: _events(context));
  }

  Widget _events(BuildContext context) {
    return ListView.builder(
      itemCount: eventData.length,
      itemBuilder: (context, index) {
        final event = eventData[index];
        final eventId = event['EventId'];
        final eventName = event['Name'];
        final eventDateTimeString = event['DateTime'];
        final isEventSelected = selectedEventId == eventId;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: EventCard(
            eventId: eventId,
            eventName: eventName,
            eventDateTime: formatDateTime(eventDateTimeString),
            isExpanded: isEventSelected,
            onToggle: () => _toggleEventDetails(eventId),
            eventDetails: eventDetailsMap[eventId],
          ),
        );
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final int eventId;
  final String eventName;
  final String eventDateTime;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<dynamic>? eventDetails;

  const EventCard({
    required this.eventId,
    required this.eventName,
    required this.eventDateTime,
    required this.isExpanded,
    required this.onToggle,
    this.eventDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(eventName),
            subtitle: Text('EventID: $eventId\nDate/Time: $eventDateTime'),
            onTap: onToggle,
          ),
          if (isExpanded && eventDetails != null)
            Column(
              children: eventDetails![0]['Fights'].map<Widget>((fight) {
                if (fight['Fighters'].length != 2) {
                  print('Invalid fight data: ${fight.toString()}');
                  return SizedBox.shrink(); // Ignore invalid fight data
                }
                final fighter1 = fight['Fighters'][0];
                final fighter2 = fight['Fighters'][1];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('FightID: ${fight['FightId']}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${fighter1['FirstName']} ${fighter1['LastName']}',
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${fighter1['PreFightWins']} - ${fighter1['PreFightLosses']} - ${fighter1['PreFightDraws']} - ${fighter1['PreFightNoContests']}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'VS',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${fighter2['FirstName']} ${fighter2['LastName']}',
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${fighter2['PreFightWins']} - ${fighter2['PreFightLosses']} - ${fighter2['PreFightDraws']} - ${fighter2['PreFightNoContests']}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Winner: ${fighter1['Winner'] == true ? '${fighter1['FirstName']} ${fighter1['LastName']}' : (fighter2['Winner'] == true ? '${fighter2['FirstName']} ${fighter2['LastName']}' : 'No winner yet')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Divider(), // Le Divider pour séparer les combats
                    ],
                  ),
                );
              }).toList(),
            ),
          if (isExpanded && (eventDetails == null || eventDetails!.isEmpty))
            Text('loading...'), // Gérer le cas où eventDetails est vide
        ],
      ),
    );
  }
}

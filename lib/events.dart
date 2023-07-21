import 'package:flutter/material.dart';
import 'package:flutter_mma_app/event_detail_model.dart';
import 'package:flutter_mma_app/event_model.dart';
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
  late Future<List<EventModel>> eventList;
  int? selectedEventId;
  Map<int, List<EventDetailModel>> eventDetailsMap = {};

  @override
  void initState() {
    super.initState();
    eventList = _fetchEventData();
  }

  Future<List<EventModel>> _fetchEventData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.sportsdata.io/v3/mma/scores/json/Schedule/UFC/2023?key=ec5838ef36b54cccae0a603380c1544a'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> eventData = jsonDecode(response.body);
      List<EventModel> eventList = eventData.map((json) =>
          EventModel.fromJson(json)).toList();
      return eventList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<EventDetailModel>> _fetchEventDetails(int eventId) async {
    final response = await http.get(
      Uri.parse(
          'https://api.sportsdata.io/v3/mma/scores/json/Event/$eventId?key=ec5838ef36b54cccae0a603380c1544a'),
    );
    if (response.statusCode == 200) {
      final dynamic decodedData = jsonDecode(response.body);
      if (decodedData is List<dynamic>) {
        List<EventDetailModel> eventDetails = decodedData.map((json) => EventDetailModel.fromJson(json)).toList();
        return eventDetails;
      } else if (decodedData is Map<String, dynamic>) {
        // Wrap the map inside a list to match the expected format
        return [EventDetailModel.fromJson(decodedData)];
      } else {
        print(
            'Invalid data format. Expected List<dynamic> or Map<String, dynamic>, but got ${decodedData
                .runtimeType}');
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
    return FutureBuilder<List<EventModel>>(
        future: eventList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final eventsData = snapshot.data;
            return Column(
              children: [
                Expanded(
                  child:
                  ListView.builder(
                    itemCount: eventsData?.length ?? 0,
                    itemBuilder: (context, index) {
                      final event = eventsData?[index];
                      final isEventSelected = selectedEventId == event?.eventId;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EventCard(
                          event: event!,
                          isExpanded: isEventSelected,
                          onToggle: () => _toggleEventDetails(event?.eventId ?? 0),
                          eventDetails: eventDetailsMap[event?.eventId],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }
    );
  }
}


class EventCard extends StatelessWidget {
  final EventModel event;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<EventDetailModel>? eventDetails;

  const EventCard({
    required this.event,
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
            title: Text(event.eventName),
            subtitle: Text('EventID: ${event.eventId != null ? event.eventId! : ''}\nDate/Time: ${event.eventDateTime}'),
            onTap: onToggle,
          ),
          if (isExpanded && eventDetails != null)
            Column(
              children: eventDetails![0].fights.map<Widget>((fight) {
                if (fight.fighters.length != 2) {
                  print('Invalid fight data: ${fight.toString()}');
                  return SizedBox.shrink(); // Ignore invalid fight data
                }
                final fighter1 = fight.fighters[0];
                final fighter2 = fight.fighters[1];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('FightID: ${fight.fightId}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${fighter1.firstName} ${fighter1.lastName}',
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${fighter1.preFightWins} - ${fighter1.preFightLosses} - ${fighter1.preFightDraws} - ${fighter1.preFightNoContests}',
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
                                  '${fighter2.firstName} ${fighter2.lastName}',
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${fighter2.preFightWins} - ${fighter2.preFightLosses} - ${fighter2.preFightDraws} - ${fighter2.preFightNoContests}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Winner: ${fighter1.winner == true ? '${fighter1.firstName} ${fighter1.lastName}' : (fighter2.winner == true ? '${fighter2.firstName} ${fighter2.lastName}' : 'No winner yet')}',
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

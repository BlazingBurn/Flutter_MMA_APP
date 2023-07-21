import 'fight_model.dart';

class EventDetailModel {
  int eventId;
  int leagueId;
  String name;
  String shortName;
  int season;
  DateTime day;
  DateTime dateTime;
  String status;
  bool active;
  List<FightModel> fights;

  EventDetailModel({
    required this.eventId,
    required this.leagueId,
    required this.name,
    required this.shortName,
    required this.season,
    required this.day,
    required this.dateTime,
    required this.status,
    required this.active,
    required this.fights,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> fightsJsonList = json['Fights'];
    List<FightModel> fightsList = fightsJsonList.map((json) => FightModel.fromJson(json)).toList();

    return EventDetailModel(
      eventId: json['EventId'],
      leagueId: json['LeagueId'],
      name: json['Name'],
      shortName: json['ShortName'],
      season: json['Season'],
      day: DateTime.parse(json['Day']),
      dateTime: DateTime.parse(json['DateTime']),
      status: json['Status'],
      active: json['Active'],
      fights: fightsList,
    );
  }
}
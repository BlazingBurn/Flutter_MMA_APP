import 'package:flutter_mma_app/fighter_event_model.dart';

class FightModel {
  int fightId;
  int order;
  String status;
  String weightClass;
  String cardSegment;
  String referee;
  int rounds;
  int resultClock;
  int resultRound;
  String resultType;
  int? winnerId;
  bool active;
  List<FighterEventModel> fighters;

  FightModel({
    required this.fightId,
    required this.order,
    required this.status,
    required this.weightClass,
    required this.cardSegment,
    required this.referee,
    required this.rounds,
    required this.resultClock,
    required this.resultRound,
    required this.resultType,
    required this.winnerId,
    required this.active,
    required this.fighters,
  });

  factory FightModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> fightersJsonList = json['Fighters'];
    List<FighterEventModel> fightersList = fightersJsonList?.map((json) => FighterEventModel.fromJson(json))?.toList() ?? [];


    return FightModel(
      fightId: json['FightId'] ?? 0,
      order: json['Order'] ?? 0,
      status: json['Status'] ?? '',
      weightClass: json['WeightClass'] ?? '',
      cardSegment: json['CardSegment'] ?? '',
      referee: json['Referee'] ?? '',
      rounds: json['Rounds'] ?? 0,
      resultClock: json['ResultClock'] ?? 0,
      resultRound: json['ResultRound'] ?? 0,
      resultType: json['ResultType'] ?? '',
      winnerId: json['WinnerId'] ?? 0,
      active: json['Active'] ?? false,
      fighters: fightersList,
    );
  }

}
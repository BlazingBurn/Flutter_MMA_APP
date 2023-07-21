import 'dart:html';

import 'package:flutter_mma_app/event_detail_model.dart';
import 'package:intl/intl.dart';

class EventModel {
  int? eventId;
  String eventName;
  String eventDateTime;

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.eventDateTime,
  }
      );

  static EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['EventId'] ?? 0,
      eventName: json['Name'] ?? '',
      eventDateTime: DateFormat('EEE, MMM d, y - h:mm a').format(DateTime.parse(json['DateTime'])) ?? '',
    );
  }
}
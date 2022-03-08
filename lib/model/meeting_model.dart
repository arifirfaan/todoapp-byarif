import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// retrieve the Source of date for event calendar
class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  /// get the start time of event
  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  /// get the end time of event
  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  /// get the subject of event
  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

    /// get the color background of event
  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Event {
  Event(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
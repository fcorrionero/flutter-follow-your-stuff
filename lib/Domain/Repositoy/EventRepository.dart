import 'package:followyourstuff/Application/DTO/EventDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/EventAggregate.dart';

abstract class EventRepository {

  Future<List<EventAggregate>> findEventsByElementId(int elementId);

  void insertEvent(EventDTO event);

  Future<void> deleteEvent(int eventId);

}
import 'package:followyourstuff/Application/DTO/EventDTO.dart';
import 'package:followyourstuff/Domain/Repositoy/EventRepository.dart';
import 'package:followyourstuff/Domain/Aggregate/EventAggregate.dart';
import 'package:followyourstuff/Infrastructure/sqlite/db.dart';

class SqliteEventRepository extends EventRepository {

  @override
  Future<List<EventAggregate>> findEventsByElementId(int elementId) async {
    String sql = '''
      SELECT 
        ev.id,
        ev.description,
        ev.createdAt,
        el.name as element_name,
        el.id as element_id,
        p.name as event_type,
        p.id as property_id
      FROM events ev 
      INNER JOIN properties p ON ev.propertyId = p.id
      INNER JOIN elements el ON ev.elementId = el.id
      WHERE ev.elementId = ?
    ''';
    List<Map> result = await DB.getDB().rawQuery(sql,[elementId]);

    //[{id: 1, description: '', createdAt: 01-03-2020 12:00, element_name: Arce Palmatum Grande, element_id: 1, event_type: Trasplante, property_id: 1}]

    List<EventAggregate> eventAggregatesList = List();
    result.forEach((item) => {
      eventAggregatesList.add(EventAggregate(
          item['id'],
          item['description'],
          item['createdAt'],
          item['element_name'],
          item['element_id'],
          item['event_type'],
          item['property_id']
       ))
    });
    return Future<List<EventAggregate>>.value(eventAggregatesList);
  }

  @override
  void insertEvent(EventDTO eventDTO) async {

    String sql = '''
    INSERT INTO events(description, createdAt, propertyId, elementId) VALUES( ?, ?, ?, ?)
    ''';
    await DB.getDB().rawInsert(sql, [
      eventDTO.description, eventDTO.createdAt, eventDTO.propertyId, eventDTO.elementId
    ]);

  }


}
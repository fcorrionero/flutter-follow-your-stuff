import 'package:followyourstuff/Application/DTO/ElementDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/ElementAggregate.dart';
import 'package:followyourstuff/Domain/Repositoy/ElementRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/db.dart';

class SqliteElementRepository implements ElementRepository {

  @override
  Future<List<ElementAggregate>> findElementsByThingId(int thingId) async{
    String sql = '''
      SELECT * FROM elements WHERE thingId = ?
    ''';
    List<Map> result = await DB.getDB().rawQuery(sql,[thingId]);

    List<ElementAggregate> elementAggregateList = List();
    result.forEach((item) => {
      elementAggregateList.add(ElementAggregate(
          item['id'],
          item['name'],
          item['createdAt'],
          item['thingId']
      ))
    });

    return Future<List<ElementAggregate>>.value(elementAggregateList);
  }

  @override
  Future<void> insertElement(ElementDTO elementDTO) async{
    String sql = 'INSERT INTO elements(name,createdAt,thingId) VALUES (?,?,?)';
    await DB.getDB().rawInsert(sql,[elementDTO.name,elementDTO.createdAt,elementDTO.thingId]);
  }

}
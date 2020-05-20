import 'package:followyourstuff/Application/DTO/ThingDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/ThingAggregate.dart';
import 'package:followyourstuff/Domain/Repositoy/ThingRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/db.dart';

class SqliteThingRepository implements ThingRepository {

  @override
  Future<List<ThingAggregate>> findAllThings() async{
    String sql = '''
      SELECT * FROM things;
    ''';
    List<Map> result = await DB.getDB().rawQuery(sql);

    List<ThingAggregate> thingAggregateList = List();
    result.forEach((item) => {
      thingAggregateList.add(ThingAggregate(
        item['id'],
        item['name'],
        item['createdAt']
      ))
    });

    return Future<List<ThingAggregate>>.value(thingAggregateList);
  }

  @override
  Future<void> insertThing(ThingDTO thingDTO) async{
    String sql = 'INSERT INTO things(name, createdAt) VALUES (?,?)';
    await DB.getDB().rawInsert(sql,[thingDTO.name,thingDTO.createdAt]);
  }

}
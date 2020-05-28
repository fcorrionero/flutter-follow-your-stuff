import 'package:followyourstuff/Application/DTO/PropertyDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/PropertyAggregate.dart';
import 'package:followyourstuff/Domain/Repositoy/PropertyRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/db.dart';
import 'package:followyourstuff/injection.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PropertyRepository, env: Env.prod)
class SqlitePropertyRepository implements PropertyRepository {

  @override
  Future<void> insertProperty(PropertyDTO propertyDTO) async{
    String sql = 'INSERT INTO properties(name, createdAt, thingId) VALUES (?,?,?)';
    await DB.getDB().rawInsert(sql,[propertyDTO.name,propertyDTO.createdAt, propertyDTO.thingId]);
  }

  @override
  Future<List<PropertyAggregate>> getAllPropertiesByThingId(int thingId) async{
    String sql = 'SELECT * FROM properties WHERE thingId = ?';
    List<Map> result = await DB.getDB().rawQuery(sql,[thingId]);

    List<PropertyAggregate> propertyAggregateList = List();
    result.forEach((item) => {
      propertyAggregateList.add(PropertyAggregate(
        item['id'],
        item['name'],
        item['thingId'],
        item['createdAt']
      ))
    });

    return Future<List<PropertyAggregate>>.value(propertyAggregateList);
  }

}
import 'package:followyourstuff/Application/DTO/ThingDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/ThingAggregate.dart';

abstract class ThingRepository {

  Future<List<ThingAggregate>> findAllThings();

  Future<void> insertThing(ThingDTO thingDTO);

}
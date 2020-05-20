import 'package:followyourstuff/Application/DTO/PropertyDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/PropertyAggregate.dart';

abstract class PropertyRepository {

  Future<void> insertProperty(PropertyDTO propertyDTO);

  Future<List<PropertyAggregate>> getAllPropertiesByThingId(int thingId);

}
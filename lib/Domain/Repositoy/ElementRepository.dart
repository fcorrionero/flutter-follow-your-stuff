import 'package:followyourstuff/Application/DTO/ElementDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/ElementAggregate.dart';

abstract class ElementRepository {

  Future<List<ElementAggregate>> findElementsByThingId(int thingId);

  Future<void> insertElement(ElementDTO elementDTO);

}
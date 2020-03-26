import 'package:followyourstuff/models/BaseModel.dart';

class Event extends BaseModel{

  static String table = 'events';

  final int id;
  final String name;
  final String createdAt;
  final int propertyId;

  Event({this.id, this.name, this.createdAt, this.propertyId});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'createdAt': createdAt
    };
    if (id != null) { map['id'] = id; }
    return {
      'name': name,
      'createdAt': createdAt,
      'thingId': propertyId
    };
  }

  String getTable() {
    return table;
  }

  int getPrimaryKey() {
    return id;
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
        id: map['id'],
        name: map['name'],
        createdAt: map['createdAt'],
        propertyId: map['propertyId']
    );
  }
}
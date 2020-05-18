import 'package:followyourstuff/models/BaseModel.dart';

class Event extends BaseModel{

  static String table = 'events';

  final int id;
  final String description;
  final String createdAt;
  final int propertyId;

  Event({this.id, this.description, this.createdAt, this.propertyId});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'description': description,
      'createdAt': createdAt
    };
    if (id != null) { map['id'] = id; }
    return {
      'description': description,
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
        description: map['description'],
        createdAt: map['createdAt'],
        propertyId: map['propertyId']
    );
  }
}
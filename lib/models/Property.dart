import 'package:followyourstuff/models/BaseModel.dart';

class Property extends BaseModel{

  static String table = 'properties';

  final int id;
  final String name;
  final String createdAt;
  final int elementId;

  Property({this.id, this.name, this.createdAt, this.elementId});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'createdAt': createdAt
    };
    if (id != null) { map['id'] = id; }
    return {
      'name': name,
      'createdAt': createdAt,
      'thingId': elementId
    };
  }

  String getTable() {
    return table;
  }

  int getPrimaryKey() {
    return id;
  }

  static Property fromMap(Map<String, dynamic> map) {
    return Property(
        id: map['id'],
        name: map['name'],
        createdAt: map['createdAt'],
        elementId: map['elementId']
    );
  }
}
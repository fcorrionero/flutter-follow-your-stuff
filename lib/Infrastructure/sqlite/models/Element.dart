import 'package:followyourstuff/Infrastructure/sqlite/models/BaseModel.dart';

class Element extends BaseModel {

  static String table = 'elements';

  final int id;
  final String name;
  final String createdAt;
  final int thingId;

  Element({this.id, this.name, this.createdAt, this.thingId});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'createdAt': createdAt
    };
    if (id != null) { map['id'] = id; }
    return {
      'name': name,
      'createdAt': createdAt,
      'thingId': thingId
    };
  }

  String getTable() {
    return table;
  }

  int getPrimaryKey() {
    return id;
  }

  static Element fromMap(Map<String, dynamic> map) {
    return Element(
        id: map['id'],
        name: map['name'],
        createdAt: map['createdAt'],
        thingId: map['thingId']
    );
  }
}
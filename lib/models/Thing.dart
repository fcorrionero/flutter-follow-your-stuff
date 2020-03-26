import 'package:followyourstuff/models/BaseModel.dart';

class Thing extends BaseModel {

  static String table = 'things';

  final int id;
  final String name;
  final String createdAt;

  Thing({this.id, this.name, this.createdAt});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'createdAt': createdAt
    };
    if (id != null) { map['id'] = id; }
    return {
      'name': name,
      'createdAt': createdAt,
    };
  }

  String getTable() {
    return table;
  }

  int getPrimaryKey() {
    return id;
  }

  static Thing fromMap(Map<String, dynamic> map) {
    return Thing(
      id: map['id'],
      name: map['name'],
      createdAt: map['createdAt']
    );
  }
}
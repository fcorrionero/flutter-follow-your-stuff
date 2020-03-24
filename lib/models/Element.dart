import 'package:followyourstuff/models/Thing.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class ElementTable extends SqfEntityTableBase {
  ElementTable() {
    tableName       = 'elements';
    primaryKeyName  = 'id';
    primaryKeyType  = PrimaryKeyType.integer_auto_incremental;
    useSoftDeleting = true;
    modelName       = 'Element';

    fields = [
      SqfEntityFieldBase('name', DbType.text),
      SqfEntityFieldBase('description', DbType.text),
      SqfEntityFieldBase('createdAt', DbType.date),
      SqfEntityFieldRelationshipBase(
        ThingTable.getInstance,
        DeleteRule.CASCADE,
        defaultValue: 0,
        fieldName: 'thingId'
      )
    ];

    super.init();
  }

  static SqfEntityTableBase _instance;
  static SqfEntityTableBase get getInstance {
    return _instance = _instance ?? ElementTable();
  }
}

class Element {

  static String table = 'elements';

  final int id;
  final String name;
  final String createdAt;

  Element({this.id, this.name, this.createdAt});

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

  static Element fromMap(Map<String, dynamic> map) {
    return Element(
        id: map['id'],
        name: map['name'],
        createdAt: map['createdAt']
    );
  }
}
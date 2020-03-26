import 'package:followyourstuff/models/Element.dart' as Element;
import 'package:sqfentity_gen/sqfentity_gen.dart';

const thingTable = SqfEntityTable(
  tableName: 'things',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  modelName: 'Thing',
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('createdAt', DbType.date)
  ]
);

class ThingTable extends SqfEntityTableBase {
  ThingTable() {
    tableName       = 'things';
    primaryKeyName  = 'id';
    primaryKeyType  = PrimaryKeyType.integer_auto_incremental;
    useSoftDeleting = true;
    modelName       = 'Thing';

    fields = [
      SqfEntityFieldBase('name', DbType.text),
      SqfEntityFieldBase('createdAt', DbType.date)
    ];

    super.init();
  }

  static SqfEntityTableBase _instance;
  static SqfEntityTableBase get getInstance {
    return _instance = _instance ?? ThingTable();
  }
}

class Thing {

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

  static Thing fromMap(Map<String, dynamic> map) {
    return Thing(
      id: map['id'],
      name: map['name'],
      createdAt: map['createdAt']
    );
  }
}
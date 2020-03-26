import 'package:followyourstuff/models/Property.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';


const eventTable = SqfEntityTable(
  tableName: 'events',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  modelName: 'Event',
  fields: [
    SqfEntityField('description', DbType.text),
    SqfEntityField('createdAt', DbType.date),
    SqfEntityFieldRelationship(
        parentTable: propertyTable,
        deleteRule: DeleteRule.CASCADE,
        defaultValue: '0',
        fieldName: 'propertyId'
    )
  ],
);

class EventTable extends SqfEntityTableBase {
  EventTable() {
    tableName       = 'properties';
    primaryKeyName  = 'id';
    primaryKeyType  = PrimaryKeyType.integer_auto_incremental;
    useSoftDeleting = true;
    modelName       = 'Property';

    fields = [
      SqfEntityFieldBase('description', DbType.text),
      SqfEntityFieldBase('createdAt', DbType.date),
      SqfEntityFieldRelationshipBase(
          PropertyTable.getInstance,
          DeleteRule.CASCADE,
          defaultValue: 0,
          fieldName: 'propertyId'
      )
    ];

    super.init();
  }

  static SqfEntityTableBase _instance;
  static SqfEntityTableBase get getInstance {
    return _instance = _instance ?? EventTable();
  }
}
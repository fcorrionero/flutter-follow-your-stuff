import 'package:followyourstuff/models/Element.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';


const propertyTable = SqfEntityTable(
  tableName: 'properties',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  modelName: 'Property',
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('description', DbType.text),
    SqfEntityField('createdAt', DbType.date),
    SqfEntityFieldRelationship(
        parentTable: elementTable,
        deleteRule: DeleteRule.CASCADE,
        defaultValue: '0',
        fieldName: 'elementId'
    )
  ],
);

class PropertyTable extends SqfEntityTableBase {
  PropertyTable() {
    tableName       = 'properties';
    primaryKeyName  = 'id';
    primaryKeyType  = PrimaryKeyType.integer_auto_incremental;
    useSoftDeleting = true;
    modelName       = 'Property';

    fields = [
      SqfEntityFieldBase('name', DbType.text),
      SqfEntityFieldBase('description', DbType.text),
      SqfEntityFieldBase('createdAt', DbType.date),
      SqfEntityFieldRelationshipBase(
          ElementTable.getInstance,
          DeleteRule.CASCADE,
          defaultValue: 0,
          fieldName: 'elementId'
      )
    ];

    super.init();
  }

  static SqfEntityTableBase _instance;
  static SqfEntityTableBase get getInstance {
    return _instance = _instance ?? PropertyTable();
  }
}
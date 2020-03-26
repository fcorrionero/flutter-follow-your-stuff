import 'package:followyourstuff/models/Element.dart';
import 'package:followyourstuff/models/Property.dart';
import 'package:followyourstuff/models/Thing.dart';
import 'package:followyourstuff/models/Event.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
//part 'model.g.dart';

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel', // optional
    databaseName: 'follow_your_stuff.db',
    databaseTables: [thingTable, elementTable, propertyTable, eventTable],
    bundledDatabasePath: null
);
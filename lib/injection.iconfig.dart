// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:followyourstuff/Infrastructure/sqlite/SqliteElementRepository.dart';
import 'package:followyourstuff/Domain/Repositoy/ElementRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqliteEventRepository.dart';
import 'package:followyourstuff/Domain/Repositoy/EventRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqlitePropertyRepository.dart';
import 'package:followyourstuff/Domain/Repositoy/PropertyRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqliteThingRepository.dart';
import 'package:followyourstuff/Domain/Repositoy/ThingRepository.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerFactory<ElementRepository>(() => SqliteElementRepository());
    g.registerFactory<EventRepository>(() => SqliteEventRepository());
    g.registerFactory<PropertyRepository>(() => SqlitePropertyRepository());
    g.registerFactory<ThingRepository>(() => SqliteThingRepository());
  }
}

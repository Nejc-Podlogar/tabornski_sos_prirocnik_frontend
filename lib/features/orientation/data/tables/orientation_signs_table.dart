import 'package:drift/drift.dart';

import '../../domain/value_objects/topo_group_type.dart';

class OrientationSignsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get imageLoc => text()();

  TextColumn get topoGroupType =>
      textEnum<TopoGroupType>()();
}

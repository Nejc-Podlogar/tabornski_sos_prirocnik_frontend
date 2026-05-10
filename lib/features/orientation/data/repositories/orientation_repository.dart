import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/orientation_sign.dart';
import '../../domain/repositories/i_orientation_repository.dart';
import '../../domain/value_objects/topo_group_type.dart';
import '../mappers/orientation_sign_mapper.dart';

class OrientationRepository implements IOrientationRepository {
  const OrientationRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<OrientationSign>> getAll() async {
    final rows = await _db.select(_db.orientationSignsTable).get();
    return rows.map(OrientationSignMapper.fromRow).toList();
  }

  @override
  Future<List<OrientationSign>> getByGroup(TopoGroupType group) async {
    final rows = await (_db.select(_db.orientationSignsTable)
          ..where((t) => t.topoGroupType.equalsValue(group)))
        .get();
    return rows.map(OrientationSignMapper.fromRow).toList();
  }

  @override
  Future<List<OrientationSign>> getByGroups(Set<TopoGroupType> groups) async {
    if (groups.isEmpty) return [];
    final rows = await (_db.select(_db.orientationSignsTable)
          ..where((t) => t.topoGroupType.isIn(groups.map((g) => g.name).toList())))
        .get();
    return rows.map(OrientationSignMapper.fromRow).toList();
  }
}

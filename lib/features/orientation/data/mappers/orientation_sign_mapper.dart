import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/orientation_sign.dart';

class OrientationSignMapper {
  OrientationSignMapper._();

  static OrientationSign fromRow(OrientationSignsTableData row) {
    return OrientationSign(
      id: row.id,
      name: row.name,
      imageLoc: row.imageLoc,
      topoGroupType: row.topoGroupType,
    );
  }

  static OrientationSignsTableCompanion toCompanion(OrientationSign entity) {
    return OrientationSignsTableCompanion.insert(
      name: entity.name,
      imageLoc: entity.imageLoc,
      topoGroupType: entity.topoGroupType,
    );
  }
}

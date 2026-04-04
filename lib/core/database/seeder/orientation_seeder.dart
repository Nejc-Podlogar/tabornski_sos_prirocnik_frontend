import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../../features/orientation/domain/value_objects/topo_group_type.dart';
import '../app_database.dart';
import 'i_seeder.dart';

class OrientationSeeder implements ISeeder {
  static const Map<String, TopoGroupType> _folderToGroup = {
    'geodetske_tocke': TopoGroupType.geodetskeTocke,
    'meje_in_ograje': TopoGroupType.mejeInOgraje,
    'morje_in_morska_obala': TopoGroupType.morjeInMorskaObala,
    'naselja_in_objekti': TopoGroupType.naseljaInObjekti,
    'promet_komunikacije': TopoGroupType.prometKomunikacije,
    'rastje_in_vrste_tal': TopoGroupType.rastjeInVrsteTal,
    'relief': TopoGroupType.relief,
    'vodovje': TopoGroupType.vodovje,
  };

  // TODO: complete name map — add all ~230 entries before release
  static const Map<String, String> _nameMap = {
    // geodetske_tocke
    'g_1': 'Triangulacijska točka',
    'g_2': 'Višinska točka',
    'g_3': 'Geodetska mreža',
    // meje_in_ograje
    'm_1': 'Državna meja',
    'm_2': 'Občinska meja',
    'm_3': 'Ograja',
    // morje_in_morska_obala
    'o_1': 'Obala',
    'o_2': 'Pristan',
    'o_3': 'Svetilnik',
    // naselja_in_objekti
    'n_1': 'Mesto',
    'n_2': 'Vas',
    'n_3': 'Cerkev',
    // promet_komunikacije
    'p_1': 'Avtocesta',
    'p_2': 'Glavna cesta',
    'p_3': 'Železnica',
    // rastje_in_vrste_tal
    'r_1': 'Gozd',
    'r_2': 'Travnik',
    'r_3': 'Njiva',
    // relief
    're_1': 'Plastnica',
    're_2': 'Greben',
    're_3': 'Dolina',
    // vodovje
    'v_1': 'Reka',
    'v_2': 'Jezero',
    'v_3': 'Izvir',
  };

  @override
  Future<void> seed(AppDatabase db) async {
    final manifestJson =
        await rootBundle.loadString('AssetManifest.json');
    final manifest = jsonDecode(manifestJson) as Map<String, dynamic>;

    final companions = <OrientationSignsTableCompanion>[];

    for (final assetPath in manifest.keys) {
      if (!assetPath.startsWith('assets/images/topografija/')) continue;

      final segments = assetPath.split('/');
      // segments: ['assets', 'images', 'topografija', '<folder>', '<file>']
      if (segments.length < 5) continue;

      final folder = segments[3];
      final group = _folderToGroup[folder];
      if (group == null) continue; // skip unknown / corrupt folder names

      final fileName = segments.last;
      final key = fileName.contains('.')
          ? fileName.substring(0, fileName.lastIndexOf('.'))
          : fileName;

      final name = _nameMap[key] ?? key;

      companions.add(
        OrientationSignsTableCompanion.insert(
          name: name,
          imageLoc: assetPath,
          topoGroupType: group,
        ),
      );
    }

    await db.transaction(() async {
      await db.batch((batch) {
        batch.insertAll(db.orientationSignsTable, companions);
      });
    });
  }
}

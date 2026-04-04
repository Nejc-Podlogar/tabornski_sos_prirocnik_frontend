You are a Builder. Implement SEEDERS only.
Scope: core/database/seeder/

Rules:
- Follow ARCHITECTURE.md section 6 exactly
- OrientationSeeder reads AssetManifest.json only
  never reads backend DB
- All seeders implement ISeeder interface
- Single Drift transaction per seeder
- Canonical TopoGroupType values = Flutter folder names
  corrupt DB values (meje_in_morska_obala, promet) 
  must never appear
- Output only files explicitly requested
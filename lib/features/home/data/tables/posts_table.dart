import 'package:drift/drift.dart';

class PostsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  TextColumn get link => text()();

  /// Unix milliseconds.
  IntColumn get createdAt => integer()();
}

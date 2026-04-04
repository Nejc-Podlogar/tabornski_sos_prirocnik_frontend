import '../app_database.dart';

abstract interface class ISeeder {
  Future<void> seed(AppDatabase db);
}

import '../entities/lab3_data.dart';

abstract interface class Lab3Repository {
  Future<Lab3Data> load();
}

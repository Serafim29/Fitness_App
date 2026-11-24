import '../entities/lab3_data.dart';
import '../repositories/lab3_repository.dart';

class LoadLab3Data {
  const LoadLab3Data(this._repository);

  final Lab3Repository _repository;

  Future<Lab3Data> call() => _repository.load();
}

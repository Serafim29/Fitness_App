import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/usecases/load_lab3_data.dart';
import '../domain/entities/lab3_data.dart';

enum LoadStatus { loading, success, error }

enum ProgramSort { name, calories, duration }

class Lab3State {
  const Lab3State({
    this.status = LoadStatus.loading,
    this.data,
    this.error,
    this.category = 'All Type',
    this.query = '',
    this.favoritesOnly = false,
    this.sort = ProgramSort.name,
    this.favoriteIds = const {},
  });
  final LoadStatus status;
  final Lab3Data? data;
  final String? error;
  final String category, query;
  final bool favoritesOnly;
  final ProgramSort sort;
  final Set<String> favoriteIds;

  List<WorkoutData> get visiblePrograms {
    final items =
        data?.programs.where((item) {
          final categories = switch (item.id) {
            'wp001' => const {'yoga', 'pilates'},
            'wp002' => const {'cardio', 'boxing'},
            'wp003' => const {'cardio'},
            _ => const <String>{},
          };
          final categoryMatches =
              category == 'All Type' ||
              categories.contains(category.toLowerCase());
          return categoryMatches &&
              item.title.toLowerCase().contains(query.toLowerCase()) &&
              (!favoritesOnly || favoriteIds.contains(item.id));
        }).toList() ??
        <WorkoutData>[];
    items.sort(
      (a, b) => switch (sort) {
        ProgramSort.name => a.title.compareTo(b.title),
        ProgramSort.calories => b.calories.compareTo(a.calories),
        ProgramSort.duration => a.minutes.compareTo(b.minutes),
      },
    );
    return items;
  }
}

class Lab3Cubit extends Cubit<Lab3State> {
  Lab3Cubit(this._loadLab3Data) : super(const Lab3State());
  final LoadLab3Data _loadLab3Data;

  Future<void> load() async {
    emit(const Lab3State(status: LoadStatus.loading));
    try {
      emit(
        Lab3State(status: LoadStatus.success, data: await _loadLab3Data()),
      );
    } catch (error) {
      emit(Lab3State(status: LoadStatus.error, error: error.toString()));
    }
  }

  void setCategory(String value) => emit(_copy(category: value));
  void setQuery(String value) => emit(_copy(query: value));
  void setFavoritesOnly(bool value) => emit(_copy(favoritesOnly: value));
  void setSort(ProgramSort value) => emit(_copy(sort: value));
  void toggleFavorite(String id) {
    final updated = {...state.favoriteIds};
    if (!updated.add(id)) updated.remove(id);
    emit(_copy(favoriteIds: updated));
  }

  Lab3State _copy({
    String? category,
    String? query,
    bool? favoritesOnly,
    ProgramSort? sort,
    Set<String>? favoriteIds,
  }) => Lab3State(
    status: state.status,
    data: state.data,
    error: state.error,
    category: category ?? state.category,
    query: query ?? state.query,
    favoritesOnly: favoritesOnly ?? state.favoritesOnly,
    sort: sort ?? state.sort,
    favoriteIds: favoriteIds ?? state.favoriteIds,
  );
}

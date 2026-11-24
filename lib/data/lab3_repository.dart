import '../domain/repositories/lab3_repository.dart';
import '../domain/entities/lab3_data.dart';
import 'lab3_remote_data_source.dart';

class Lab3RepositoryImpl implements Lab3Repository {
  Lab3RepositoryImpl(this._remoteDataSource);

  final Lab3RemoteDataSource _remoteDataSource;

  @override
  Future<Lab3Data> load() async {
    final responses = await Future.wait([
      _remoteDataSource.getFeed(),
      _remoteDataSource.getDetails(),
    ]);
    return _mapResponses(responses[0], responses[1]);
  }

  Lab3Data _mapResponses(
    Map<String, dynamic> feedJson,
    Map<String, dynamic> detailsJson,
  ) {
    final challenge = feedJson['todaysChallenge'] as Map<String, dynamic>;
    final workoutPrograms =
        feedJson['workoutPrograms'] as Map<String, dynamic>;
    final gym = detailsJson['gym'] as Map<String, dynamic>;
    final pricing = gym['pricing'] as Map<String, dynamic>;

    return Lab3Data(
      challenge: ChallengeData(
        title: challenge['title'] as String,
        activity: challenge['activity'] as String,
        completed: (challenge['completed'] as num).toInt(),
        total: (challenge['total'] as num).toInt(),
      ),
      featuredPlans: (feedJson['featuredPlans'] as List<dynamic>)
          .map((item) {
            final json = item as Map<String, dynamic>;
            return FeaturedPlanData(
              title: json['title'] as String,
              duration: json['duration'] as String,
              frequency: json['frequency'] as String,
              imageUrl: json['imageUrl'] as String,
            );
          })
          .toList(),
      filters: (workoutPrograms['filters'] as List<dynamic>)
          .map((item) => (item as Map<String, dynamic>)['name'] as String)
          .toList(),
      programs: (workoutPrograms['items'] as List<dynamic>)
          .map((item) {
            final json = item as Map<String, dynamic>;
            return WorkoutData(
              id: json['id'] as String,
              title: json['title'] as String,
              calories: (json['calories'] as num).toInt(),
              minutes: (json['durationMinutes'] as num).toInt(),
              isPro: json['isPro'] as bool,
              imageUrl: json['imageUrl'] as String,
            );
          })
          .toList(),
      gym: GymData(
        name: gym['name'] as String,
        location: gym['location'] as String,
        imageUrl: gym['heroImageUrl'] as String,
        rating: (gym['rating'] as num).toDouble(),
        reviews: (gym['reviewCount'] as num).toInt(),
        description: gym['description'] as String,
        amenities: (gym['amenities'] as List<dynamic>)
            .map((item) => (item as Map<String, dynamic>)['name'] as String)
            .toList(),
        price: (pricing['amount'] as num).toDouble(),
        currency: pricing['currency'] as String,
        period: pricing['period'] as String,
      ),
    );
  }
}
